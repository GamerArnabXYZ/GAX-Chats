import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:intl/intl.dart';

import 'dart:async';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(

    options: const FirebaseOptions(

      apiKey: "AIzaSyCDxsFZBoEG-WJkN-2wuD_U5DCotgEXZkc",

      appId: "1:354112198175:web:e40eb50c44aac27c37a72a",

      messagingSenderId: "354112198175",

      projectId: "gax-chatapp",

      databaseURL: "https://gax-chatapp-default-rtdb.asia-southeast1.firebasedatabase.app",

    ),

  );

  runApp(const GaxApp());

}

class GaxApp extends StatefulWidget {

  const GaxApp({super.key});

  @override State<GaxApp> createState() => _GaxAppState();

}

class _GaxAppState extends State<GaxApp> {

  ThemeMode _themeMode = ThemeMode.system;

  @override

  Widget build(BuildContext context) => MaterialApp(

    debugShowCheckedModeBanner: false,

    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal, brightness: Brightness.light),

    darkTheme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal, brightness: Brightness.dark),

    themeMode: _themeMode,

    home: AuthGate(onTheme: (v) => setState(() => _themeMode = v ? ThemeMode.dark : ThemeMode.light), mode: _themeMode),

  );

}

class AuthGate extends StatelessWidget {

  final Function(bool) onTheme;

  final ThemeMode mode;

  const AuthGate({super.key, required this.onTheme, required this.mode});

  @override

  Widget build(BuildContext context) => StreamBuilder<User?>(

    stream: FirebaseAuth.instance.authStateChanges(),

    builder: (context, snap) {

      if (!snap.hasData) return const LoginScreen();

      final uid = snap.data!.uid;

      FirebaseDatabase.instance.ref('users/$uid/status').set("online");

      FirebaseDatabase.instance.ref('users/$uid/status').onDisconnect().set(ServerValue.timestamp);

      return StreamBuilder(

        stream: FirebaseDatabase.instance.ref('users/$uid').onValue,

        builder: (c, db) {

          if (db.connectionState == ConnectionState.waiting) return const Scaffold(body: Center(child: CircularProgressIndicator()));

          final data = db.data?.snapshot.value as Map?;

          if (data == null || data['username'] == null) return const ProfileSetup();

          return MainScreen(onTheme: onTheme, mode: mode);

        },

      );

    },

  );

}

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final _e = TextEditingController(), _p = TextEditingController();

  @override

  Widget build(BuildContext context) => Scaffold(

    body: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

      const Icon(Icons.bolt, size: 80, color: Colors.teal),

      const Text("GAX CHATS", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

      const SizedBox(height: 20),

      TextField(controller: _e, decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder())),

      const SizedBox(height: 10),

      TextField(controller: _p, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder())),

      const SizedBox(height: 20),

      SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => FirebaseAuth.instance.signInWithEmailAndPassword(email: _e.text.trim(), password: _p.text.trim()).catchError((err) => FirebaseAuth.instance.createUserWithEmailAndPassword(email: _e.text.trim(), password: _p.text.trim())), child: const Text("Continue"))),

    ])),

  );

}

class ProfileSetup extends StatefulWidget {

  const ProfileSetup({super.key});

  @override State<ProfileSetup> createState() => _ProfileSetupState();

}

class _ProfileSetupState extends State<ProfileSetup> {

  final _n = TextEditingController(), _u = TextEditingController(), _b = TextEditingController();

  @override

  Widget build(BuildContext context) => Scaffold(

    appBar: AppBar(title: const Text("Setup Profile")),

    body: Padding(padding: const EdgeInsets.all(25), child: Column(children: [

      TextField(controller: _n, decoration: const InputDecoration(labelText: "Full Name")),

      TextField(controller: _u, decoration: const InputDecoration(labelText: "Username")),

      TextField(controller: _b, decoration: const InputDecoration(labelText: "Bio")),

      const SizedBox(height: 20),

      ElevatedButton(onPressed: () {

        final uid = FirebaseAuth.instance.currentUser!.uid;

        FirebaseDatabase.instance.ref('users/$uid').update({

          'uid': uid, 'name': _n.text, 'username': _u.text.toLowerCase(), 'bio': _b.text,

          'pfp': "https://ui-avatars.com/api/?name=${_n.text}&background=random", 'status': 'online'

        });

      }, child: const Text("Save Profile"))

    ])),

  );

}

class MainScreen extends StatefulWidget {

  final Function(bool) onTheme;

  final ThemeMode mode;

  const MainScreen({super.key, required this.onTheme, required this.mode});

  @override State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  int _idx = 0;

  @override

  Widget build(BuildContext context) {

    final tabs = [const HomeTab(), const FindTab(), const SocialTab(), SettingsTab(onTheme: widget.onTheme, mode: widget.mode)];

    return Scaffold(

      body: tabs[_idx],

      bottomNavigationBar: NavigationBar(

        selectedIndex: _idx,

        onDestinationSelected: (i) => setState(() => _idx = i),

        destinations: const [

          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: "Chats"),

          NavigationDestination(icon: Icon(Icons.search), label: "Find"),

          NavigationDestination(icon: Icon(Icons.people_outline), label: "Social"),

          NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Settings"),

        ],

      ),

    );

  }

}

class HomeTab extends StatelessWidget {

  const HomeTab({super.key});

  @override

  Widget build(BuildContext context) {

    final myId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(title: const Text("GAX")),

      body: StreamBuilder(

        stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,

        builder: (c, snap) {

          if (!snap.hasData || snap.data!.snapshot.value == null) return const Center(child: Text("No conversations"));

          final fids = (snap.data!.snapshot.value as Map).keys.toList();

          return ListView.builder(itemCount: fids.length, itemBuilder: (c, i) => StreamBuilder(

            stream: FirebaseDatabase.instance.ref('users/${fids[i]}').onValue,

            builder: (c, uSnap) {

              if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();

              final u = uSnap.data!.snapshot.value as Map;

              final chatId = ([myId, fids[i]]..sort()).join('_');

              return StreamBuilder(

                stream: FirebaseDatabase.instance.ref('messages/$chatId').limitToLast(1).onValue,

                builder: (c, mSnap) {

                  String last = "Tap to chat";

                  if (mSnap.hasData && mSnap.data!.snapshot.value != null) {

                    last = (mSnap.data!.snapshot.value as Map).values.first['text'];

                  }

                  return ListTile(

                    leading: GestureDetector(

                      onTap: () => showDialog(context: context, builder: (c) => ProfileDialog(user: u)),

                      child: Stack(children: [

                        CircleAvatar(backgroundImage: NetworkImage(u['pfp'])),

                        Positioned(right: 0, bottom: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: u['status'] == 'online' ? Colors.green : Colors.grey, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),

                      ]),

                    ),

                    title: Text(u['name']),

                    subtitle: StreamBuilder(

                      stream: FirebaseDatabase.instance.ref('typing/$chatId/${fids[i]}').onValue,

                      builder: (context, tSnap) {

                        bool isTyping = tSnap.hasData && tSnap.data!.snapshot.value == true;

                        return Text(isTyping ? "typing..." : last, style: TextStyle(color: isTyping ? Colors.teal : Colors.grey));

                      },

                    ),

                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ChatRoom(target: u))),

                  );

                },

              );

            },

          ));

        },

      ),

    );

  }

}

class ProfileDialog extends StatelessWidget {

  final Map user;

  const ProfileDialog({super.key, required this.user});

  String formatLastSeen(dynamic status) {

    if (status == "online") return "Online";

    if (status is! int) return "Offline";

    final date = DateTime.fromMillisecondsSinceEpoch(status);

    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Last seen just now";

    if (diff.inMinutes < 60) return "Last seen ${diff.inMinutes}m ago";

    if (diff.inHours < 24) return "Last seen ${diff.inHours}h ago";

    return "Last seen ${DateFormat('MMM d').format(date)}";

  }

  @override

  Widget build(BuildContext context) => AlertDialog(

    content: Column(mainAxisSize: MainAxisSize.min, children: [

      CircleAvatar(radius: 50, backgroundImage: NetworkImage(user['pfp'])),

      const SizedBox(height: 15),

      Text(user['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

      Text("@${user['username']}", style: const TextStyle(color: Colors.grey)),

      Text(formatLastSeen(user['status']), style: const TextStyle(fontSize: 12, color: Colors.teal)),

      const Divider(),

      Text(user['bio'] ?? "No bio yet", textAlign: TextAlign.center),

    ]),

  );

}

class FindTab extends StatefulWidget {

  const FindTab({super.key});

  @override State<FindTab> createState() => _FindTabState();

}

class _FindTabState extends State<FindTab> {

  String q = "";

  @override

  Widget build(BuildContext context) {

    // Get current user ID to filter out self

    final myId = FirebaseAuth.instance.currentUser!.uid;

    

    return Scaffold(

      appBar: AppBar(title: TextField(onChanged: (v) => setState(() => q = v), decoration: const InputDecoration(hintText: "Search @username...", border: InputBorder.none))),

      body: q.isEmpty ? const Center(child: Text("Search for friends")) : StreamBuilder(

        // FIX 1: Convert search query to lowercase for case-insensitive search

        stream: FirebaseDatabase.instance.ref('users').orderByChild('username').startAt(q.toLowerCase()).endAt("${q.toLowerCase()}\uf8ff").onValue,

        builder: (c, snap) {

          if (!snap.hasData) return const SizedBox();

          final users = []; 

          (snap.data!.snapshot.value as Map?)?.forEach((k, v) => users.add(v));

          

          return ListView.builder(

            itemCount: users.length, 

            itemBuilder: (c, i) {

              // FIX 2: Do not show current user in search results

              if (users[i]['uid'] == myId) return const SizedBox();

              

              return ListTile(

                leading: CircleAvatar(backgroundImage: NetworkImage(users[i]['pfp'])),

                title: Text(users[i]['name']),

                subtitle: Text("@${users[i]['username']}"),

                trailing: ElevatedButton(onPressed: () => FirebaseDatabase.instance.ref('users/${users[i]['uid']}/req/${FirebaseAuth.instance.currentUser!.uid}').set(true), child: const Text("Add")),

              );

            }

          );

        },

      ),

    );

  }

}

class SocialTab extends StatefulWidget {

  const SocialTab({super.key});

  @override State<SocialTab> createState() => _SocialTabState();

}

class _SocialTabState extends State<SocialTab> {

  String filter = "";

  @override

  Widget build(BuildContext context) {

    final myId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      appBar: AppBar(title: const Text("Social")),

      body: Column(children: [

        Padding(padding: const EdgeInsets.all(8.0), child: TextField(onChanged: (v) => setState(() => filter = v.toLowerCase()), decoration: const InputDecoration(hintText: "Filter friends...", border: OutlineInputBorder()))),

        StreamBuilder(

          stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue,

          builder: (c, snap) {

            if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();

            final ids = (snap.data!.snapshot.value as Map).keys.toList();

            return Column(children: [

              const ListTile(title: Text("Requests", style: TextStyle(fontWeight: FontWeight.bold))),

              // FIX 3: Improved UI to show sender Name/Avatar instead of just ID

              ...ids.map((id) => StreamBuilder(

                stream: FirebaseDatabase.instance.ref('users/$id').onValue,

                builder: (context, userSnap) {

                  if (!userSnap.hasData || userSnap.data!.snapshot.value == null) return const SizedBox();

                  final reqUser = userSnap.data!.snapshot.value as Map;

                  return ListTile(

                    leading: CircleAvatar(backgroundImage: NetworkImage(reqUser['pfp'])),

                    title: Text(reqUser['name']),

                    subtitle: Text("@${reqUser['username']}"),

                    trailing: IconButton(

                      icon: const Icon(Icons.check, color: Colors.green), 

                      onPressed: () {

                        FirebaseDatabase.instance.ref('users/$myId/friends/$id').set(true);

                        FirebaseDatabase.instance.ref('users/$id/friends/$myId').set(true);

                        FirebaseDatabase.instance.ref('users/$myId/req/$id').remove();

                      }

                    ),

                  );

                },

              )),

            ]);

          },

        ),

        const ListTile(title: Text("All Friends", style: TextStyle(fontWeight: FontWeight.bold))),

        Expanded(child: StreamBuilder(

          stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,

          builder: (c, snap) {

            if (!snap.hasData || snap.data!.snapshot.value == null) return const Center(child: Text("No friends yet"));

            final fids = (snap.data!.snapshot.value as Map).keys.toList();

            return ListView.builder(itemCount: fids.length, itemBuilder: (c, i) => StreamBuilder(

              stream: FirebaseDatabase.instance.ref('users/${fids[i]}').onValue,

              builder: (c, uSnap) {

                if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();

                final u = uSnap.data!.snapshot.value as Map;

                if (!u['name'].toString().toLowerCase().contains(filter)) return const SizedBox();

                return ListTile(

                  leading: GestureDetector(

                    onTap: () => showDialog(context: context, builder: (c) => ProfileDialog(user: u)),

                    child: Stack(children: [

                      CircleAvatar(backgroundImage: NetworkImage(u['pfp'])),

                      Positioned(right: 0, bottom: 0, child: Container(width: 10, height: 10, decoration: BoxDecoration(color: u['status'] == 'online' ? Colors.green : Colors.grey, shape: BoxShape.circle, border: Border.all(color: Colors.white)))),

                    ]),

                  ), 

                  title: Text(u['name']), 

                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => ChatRoom(target: u)))

                );

              },

            ));

          },

        )),

      ]),

    );

  }

}

class SettingsTab extends StatelessWidget {

  final Function(bool) onTheme;

  final ThemeMode mode;

  const SettingsTab({super.key, required this.onTheme, required this.mode});

  void _showAbout(BuildContext context) {

    showDialog(context: context, builder: (c) => AlertDialog(

      title: const Row(children: [Icon(Icons.bolt, color: Colors.teal), SizedBox(width: 10), Text("About GAX")]),

      content: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        Text("GAX Chats is a modern real-time messaging app built for fast, secure, and smooth communication. Chat instantly, manage friends, and enjoy a clean experience across mobile and web."),

        SizedBox(height: 10),

        Text("Optimized to run smoothly even on older devices like Android 7 and iOS 12.5.7.", style: TextStyle(fontWeight: FontWeight.bold)),

        Divider(),

        Text("Simple. Secure. Seamless.", style: TextStyle(fontStyle: FontStyle.italic)),

        SizedBox(height: 10),

        Text("👨‍💻 Made By: GamerArnabXYZ", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),

      ]),

    ));

  }

  void _showEditProfile(BuildContext context, Map data) {

    final n = TextEditingController(text: data['name']);

    final u = TextEditingController(text: data['username']);

    final p = TextEditingController(text: data['pfp']);

    final b = TextEditingController(text: data['bio'] ?? "");

    showModalBottomSheet(context: context, isScrollControlled: true, builder: (c) => Padding(

      padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom, left: 20, right: 20, top: 20),

      child: Column(mainAxisSize: MainAxisSize.min, children: [

        const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

        TextField(controller: n, decoration: const InputDecoration(labelText: "Name")),

        TextField(controller: u, decoration: const InputDecoration(labelText: "Username")),

        TextField(controller: b, decoration: const InputDecoration(labelText: "Bio")),

        TextField(controller: p, decoration: const InputDecoration(labelText: "PFP URL")),

        const SizedBox(height: 20),

        ElevatedButton(onPressed: () {

          FirebaseDatabase.instance.ref('users/${data['uid']}').update({'name': n.text, 'username': u.text.toLowerCase(), 'pfp': p.text, 'bio': b.text});

          Navigator.pop(c);

        }, child: const Text("Update Profile")),

        const SizedBox(height: 20),

      ]),

    ));

  }

  @override

  Widget build(BuildContext context) {

    final myId = FirebaseAuth.instance.currentUser!.uid;

    bool isDark = mode == ThemeMode.dark || (mode == ThemeMode.system && MediaQuery.of(context).platformBrightness == Brightness.dark);

    return StreamBuilder(

      stream: FirebaseDatabase.instance.ref('users/$myId').onValue,

      builder: (context, snap) {

        if (!snap.hasData || snap.data!.snapshot.value == null) return const Scaffold();

        final d = snap.data!.snapshot.value as Map;

        return Scaffold(

          appBar: AppBar(title: const Text("Settings"), actions: [IconButton(icon: const Icon(Icons.edit_note), onPressed: () => _showEditProfile(context, d))]),

          body: ListView(children: [

            UserAccountsDrawerHeader(accountName: Text(d['name']), accountEmail: Text("@${d['username']}"), currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(d['pfp']))),

            Padding(padding: const EdgeInsets.all(15), child: Text(d['bio'] ?? "No bio")),

            SwitchListTile(title: const Text("Dark Mode"), value: isDark, onChanged: (v) => onTheme(v)),

            ListTile(leading: const Icon(Icons.info_outline), title: const Text("About App"), onTap: () => _showAbout(context)),

            ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("Logout"), onTap: () => FirebaseAuth.instance.signOut()),

          ]),

        );

      },

    );

  }

}

class ChatRoom extends StatefulWidget {

  final Map target;

  const ChatRoom({super.key, required this.target});

  @override State<ChatRoom> createState() => _ChatRoomState();

}

class _ChatRoomState extends State<ChatRoom> {

  final _ctrl = TextEditingController();

  late String chatId;

  final myId = FirebaseAuth.instance.currentUser!.uid;

  Timer? _typingTimer;

  @override

  void initState() {

    super.initState();

    List<String> ids = [myId, widget.target['uid']]; ids.sort();

    chatId = ids.join('_');

    _markRead();

  }

  void _markRead() => FirebaseDatabase.instance.ref('messages/$chatId').get().then((snap) {

    if(snap.value == null) return;

    (snap.value as Map).forEach((k, v) {

      if(v['senderId'] != myId) FirebaseDatabase.instance.ref('messages/$chatId/$k/read').set(true);

    });

  });

  void _onTyping(String v) {

    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(true);

    _typingTimer?.cancel();

    _typingTimer = Timer(const Duration(seconds: 2), () {

      FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false);

    });

  }

  @override

  Widget build(BuildContext context) => Scaffold(

    appBar: AppBar(title: InkWell(onTap: () => showDialog(context: context, builder: (c) => ProfileDialog(user: widget.target)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Text(widget.target['name']),

      StreamBuilder(

        stream: FirebaseDatabase.instance.ref('typing/$chatId/${widget.target['uid']}').onValue,

        builder: (context, snap) {

          if (snap.hasData && snap.data!.snapshot.value == true) return const Text("typing...", style: TextStyle(fontSize: 12, color: Colors.teal));

          return Text(widget.target['status'] == 'online' ? 'Online' : 'Offline', style: const TextStyle(fontSize: 12, color: Colors.grey));

        },

      )

    ]))),

    body: Column(children: [

      Expanded(child: StreamBuilder(stream: FirebaseDatabase.instance.ref('messages/$chatId').onValue, builder: (c, snap) {

        if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();

        final msgs = []; (snap.data!.snapshot.value as Map).forEach((k, v) => msgs.add(v));

        msgs.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        return ListView.builder(itemCount: msgs.length, itemBuilder: (c, i) {

          final m = msgs[i];

          final time = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(m['timestamp']));

          final isMe = m['senderId'] == myId;

          return Align(

            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

            child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [

                Container(padding: const EdgeInsets.all(12), margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2), decoration: BoxDecoration(color: isMe ? Colors.teal : Colors.grey[300], borderRadius: BorderRadius.circular(15)), child: Text(m['text'], style: TextStyle(color: isMe ? Colors.white : Colors.black))),

                Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2), child: Row(mainAxisSize: MainAxisSize.min, children: [

                  Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),

                  if(isMe) Icon(Icons.done_all, size: 14, color: m['read'] == true ? Colors.blue : Colors.grey),

                ])),

              ]),

          );

        });

      })),

      Padding(padding: const EdgeInsets.all(10), child: Row(children: [

        Expanded(child: TextField(controller: _ctrl, onChanged: _onTyping, decoration: const InputDecoration(hintText: "Message...", border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)))))),

        const SizedBox(width: 8),

        CircleAvatar(backgroundColor: Colors.teal, child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: () {

          if(_ctrl.text.isEmpty) return;

          FirebaseDatabase.instance.ref('messages/$chatId').push().set({'senderId': myId, 'text': _ctrl.text, 'timestamp': ServerValue.timestamp, 'read': false});

          FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false);

          _ctrl.clear();

        })),

      ])),

    ]),

  );

}