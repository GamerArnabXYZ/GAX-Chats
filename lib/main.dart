import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _openUrl(String raw) async {
  final uri = Uri.tryParse(raw.startsWith('http') ? raw : 'https://$raw');
  if (uri == null) return;
  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
}

class Gx {
  static const d0=Color(0xFF05050E), d1=Color(0xFF080916), d2=Color(0xFF0C0D1E), d3=Color(0xFF111228), d4=Color(0xFF171933), d5=Color(0xFF1F2142), d6=Color(0xFF262950);
  static const l0=Color(0xFFF7F7FF), l1=Color(0xFFFFFFFF), l2=Color(0xFFEEEEFB), l3=Color(0xFFE4E4F6), l4=Color(0xFFD8D8F0);
  static const violet=Color(0xFF7C5CFC), cyan=Color(0xFF00D4FF), indigo=Color(0xFF4535CC), mint=Color(0xFF00E5A0), rose=Color(0xFFFF4D80), amber=Color(0xFFFFB340);
  static const sentD=Color(0xFF1A1650), recvD=Color(0xFF0F1024), sentL=Color(0xFFEDE8FF), recvL=Color(0xFFFFFFFF);
  static const tx1=Color(0xFFF0F0FF), tx2=Color(0xFF7878A8), tx3=Color(0xFF3C3D62), tx1L=Color(0xFF080916), tx2L=Color(0xFF5A5A88), tx3L=Color(0xFF9090C0);
  static const live=Color(0xFF2EFF9A), away=Color(0xFF3A3D60), readClr=Color(0xFF00D4FF), err=Color(0xFFFF4D80), divD=Color(0xFF141630), divL=Color(0xFFDDDDF4);
  static const navL=Color(0xFFFFFFFF), navD=Color(0xFF0C0D1E);
  static const gBrand=LinearGradient(colors:[violet,cyan],begin:Alignment.topLeft,end:Alignment.bottomRight);
  static const gBrand2=LinearGradient(colors:[violet,Color(0xFFB044FF)],begin:Alignment.topLeft,end:Alignment.bottomRight);
  static const gHdr=LinearGradient(colors:[Color(0xFF130F40),Color(0xFF080916)],begin:Alignment.topLeft,end:Alignment.bottomRight);
  static const gLHdr=LinearGradient(colors:[Color(0xFF6040E8),Color(0xFF8560FF)],begin:Alignment.topLeft,end:Alignment.bottomRight);
  static List<BoxShadow> glow(Color c,{double b=20,double s=-2})=>[BoxShadow(color:c.withOpacity(0.3),blurRadius:b,spreadRadius:s)];
  static List<BoxShadow> glow2(Color c)=>[BoxShadow(color:c.withOpacity(0.18),blurRadius:28,spreadRadius:-4,offset:const Offset(0,8))];
  static List<BoxShadow> softShadow(bool d)=>[BoxShadow(color:Colors.black.withOpacity(d?0.3:0.1),blurRadius:12,offset:const Offset(0,3))];
}

ThemeData gaxTheme(bool dark) => ThemeData(
  useMaterial3: true, brightness: dark ? Brightness.dark : Brightness.light,
  scaffoldBackgroundColor: dark ? Gx.d1 : Gx.l0,
  colorScheme: ColorScheme.fromSeed(seedColor: Gx.violet, brightness: dark ? Brightness.dark : Brightness.light).copyWith(primary: Gx.violet, secondary: Gx.cyan, surface: dark ? Gx.d3 : Gx.l1, error: Gx.err),
  appBarTheme: AppBarTheme(backgroundColor: dark ? Gx.d3 : Gx.violet, foregroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0, centerTitle: false, titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.1), iconTheme: const IconThemeData(color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: dark ? Gx.navD : Gx.navL, selectedItemColor: Gx.violet, unselectedItemColor: dark ? Gx.tx2 : Gx.tx2L, elevation: 0, type: BottomNavigationBarType.fixed, showSelectedLabels: false, showUnselectedLabels: false),
  inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: dark ? Gx.d4 : Gx.l2, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Gx.violet, width: 1.6)), hintStyle: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 14), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13)),
  listTileTheme: ListTileThemeData(textColor: dark ? Gx.tx1 : Gx.tx1L, iconColor: dark ? Gx.tx2 : Gx.tx2L),
  dividerTheme: DividerThemeData(color: dark ? Gx.divD : Gx.divL, thickness: 0.6),
  switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((s)=>s.contains(WidgetState.selected)?Gx.violet:Colors.grey), trackColor: WidgetStateProperty.resolveWith((s)=>s.contains(WidgetState.selected)?Gx.violet.withOpacity(0.4):Colors.grey.withOpacity(0.3))),
);

enum AutoThemeMode { system, timeBased }

class ThemeCtrl extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  bool _auto = true;
  AutoThemeMode _autoMode = AutoThemeMode.system;
  Timer? _autoTimer;
  ThemeMode get mode => _mode;
  bool get auto => _auto;
  AutoThemeMode get autoMode => _autoMode;
  bool get isDarkNow {
    if (_mode == ThemeMode.dark) return true;
    if (_mode == ThemeMode.light) return false;
    return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }
  ThemeCtrl() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onSysBr;
    _startAuto();
  }
  void _onSysBr() { if (!_auto || _autoMode == AutoThemeMode.timeBased) return; notifyListeners(); }
  void setAuto(bool v) { _auto=v; if(v){_autoMode=AutoThemeMode.system;_mode=ThemeMode.system;_apply();} notifyListeners(); }
  void setAutoMode(AutoThemeMode m) { _auto=true; _autoMode=m; if(m==AutoThemeMode.timeBased)_applyTime(); else _mode=ThemeMode.system; notifyListeners(); }
  void setDark(bool v) { _auto=false; _mode=v?ThemeMode.dark:ThemeMode.light; notifyListeners(); }
  void _apply() { if(!_auto)return; if(_autoMode==AutoThemeMode.timeBased)_applyTime(); else _mode=ThemeMode.system; }
  void _applyTime() { if(!_auto)return; final h=DateTime.now().hour; final newMode=(h<6||h>=19)?ThemeMode.dark:ThemeMode.light; if(newMode!=_mode){_mode=newMode;notifyListeners();} }
  void _startAuto() { _apply(); _autoTimer=Timer.periodic(const Duration(minutes: 5),(_){if(_auto&&_autoMode==AutoThemeMode.timeBased)_applyTime();}); }
  @override void dispose() { _autoTimer?.cancel(); WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged=null; super.dispose(); }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCDxsFZBoEG-WJkN-2wuD_U5DCotgEXZkc",
      appId: "1:354112198175:web:e40eb50c44aac27c37a72a",
      messagingSenderId: "354112198175", projectId: "gax-chatapp",
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
  final _tc = ThemeCtrl();
  @override void dispose() { _tc.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) => ListenableBuilder(listenable: _tc, builder: (_, __) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: _tc.isDarkNow ? Brightness.dark : Brightness.light, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: _tc.isDarkNow ? Gx.navD : Gx.navL, systemNavigationBarDividerColor: Colors.transparent, systemNavigationBarIconBrightness: _tc.isDarkNow ? Brightness.light : Brightness.dark));
    return MaterialApp(debugShowCheckedModeBanner: false, theme: gaxTheme(false), darkTheme: gaxTheme(true), themeMode: _tc.mode, home: _AuthGate(tc: _tc));
  });
}

class _AuthGate extends StatelessWidget {
  final ThemeCtrl tc;
  const _AuthGate({required this.tc});
  @override Widget build(BuildContext ctx) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (ctx, snap) {
      if (snap.connectionState == ConnectionState.waiting) return const _Splash();
      if (!snap.hasData) return const LoginScreen();
      final uid = snap.data!.uid;
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      ref.child('status').set('online').catchError((_){});
      ref.child('status').onDisconnect().set('offline').catchError((_){});
      ref.child('lastSeen').onDisconnect().set(ServerValue.timestamp).catchError((_){});
      return StreamBuilder(
        stream: ref.onValue,
        builder: (c, db) {
          if (db.connectionState == ConnectionState.waiting) return const _Splash();
          if ((db.data?.snapshot.value as Map?)?['username'] == null) return const ProfileSetup();
          return MainScreen(tc: tc);
        },
      );
    },
  );
}

class _Splash extends StatefulWidget {
  const _Splash();
  @override State<_Splash> createState() => _SplashState();
}
class _SplashState extends State<_Splash> with TickerProviderStateMixin {
  late final _a=AnimationController(vsync:this,duration:const Duration(milliseconds:1200))..forward(), _p=AnimationController(vsync:this,duration:const Duration(milliseconds:1600))..repeat(reverse:true), _r=AnimationController(vsync:this,duration:const Duration(milliseconds:2400))..repeat();
  @override void dispose() { _a.dispose(); _p.dispose(); _r.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor: Gx.d0, body: Center(child: FadeTransition(opacity: CurvedAnimation(parent:_a,curve:const Interval(0,.6,curve:Curves.easeOut)), child: SlideTransition(position: Tween<Offset>(begin:const Offset(0,.12),end:Offset.zero).animate(CurvedAnimation(parent:_a,curve:const Interval(0,.7,curve:Curves.easeOutCubic))), child: Column(mainAxisSize: MainAxisSize.min, children:[ScaleTransition(scale: Tween(begin:0.95,end:1.05).animate(CurvedAnimation(parent:_p,curve:Curves.easeInOut)), child: Stack(alignment: Alignment.center, children:[AnimatedBuilder(animation:_r,builder:(_,__)=>Transform.rotate(angle:_r.value*2*math.pi,child:Container(width:116,height:116,decoration:BoxDecoration(shape:BoxShape.circle,gradient:SweepGradient(colors:[Gx.violet.withOpacity(.55),Colors.transparent,Gx.cyan.withOpacity(.45),Colors.transparent]))))), Container(width: 100, height: 100, decoration: const BoxDecoration(shape: BoxShape.circle, color: Gx.d0)), const _GaxLogo(size: 82)])), const SizedBox(height: 24), const _BrandText('GAX', size: 38, spacing: 9), const SizedBox(height: 7), const Text('Messaging · Reimagined', style: TextStyle(color: Gx.tx2, fontSize: 13, letterSpacing: 0.8)), const SizedBox(height: 36), const _DotsLoader()])))));
}

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState() => _LoginState(); }
class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  final _emailC=TextEditingController(), _passC=TextEditingController();
  bool _busy=false, _hide=true; String? _err;
  late final _bgAc=AnimationController(vsync:this,duration:const Duration(seconds:12))..repeat(reverse:true), _entAc=AnimationController(vsync:this,duration:const Duration(milliseconds:900))..forward();
  @override void dispose() { _emailC.dispose(); _passC.dispose(); _bgAc.dispose(); _entAc.dispose(); super.dispose(); }
  Future<void> _auth() async {
    if (_emailC.text.trim().isEmpty || _passC.text.trim().isEmpty) return setState(() => _err = 'Enter email and password');
    setState(() { _busy=true; _err=null; });
    try { await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailC.text.trim(), password: _passC.text.trim());
    } catch (_) { try { await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailC.text.trim(), password: _passC.text.trim()); } catch (_) { setState(() => _err = 'Invalid credentials or weak password'); }}
    if (mounted) setState(() => _busy = false);
  }
  @override Widget build(BuildContext ctx) => Scaffold(backgroundColor: Gx.d0, body: Stack(children:[AnimatedBuilder(animation: _bgAc, builder: (_,__) => CustomPaint(painter: _NebulaPainter(_bgAc.value), size: MediaQuery.of(ctx).size)), SafeArea(child: FadeTransition(opacity: CurvedAnimation(parent: _entAc, curve: Curves.easeOut), child: SlideTransition(position: Tween<Offset>(begin:const Offset(0,.16),end:Offset.zero).animate(CurvedAnimation(parent: _entAc, curve: Curves.easeOutCubic)), child: SingleChildScrollView(padding: const EdgeInsets.symmetric(horizontal: 26), child: ConstrainedBox(constraints: BoxConstraints(minHeight: MediaQuery.of(ctx).size.height - MediaQuery.of(ctx).padding.top), child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[const _GaxLogo(size: 70), const SizedBox(height: 18), const _BrandText('GAX CHATS', size: 23, spacing: 5), const SizedBox(height: 7), const Text('Sign in · auto-create', style: TextStyle(color: Gx.tx2, fontSize: 12.5)), const SizedBox(height: 40), _GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Container(height: 3.5, width: 52, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(2))), const Text('Welcome to GAX', style: TextStyle(color: Gx.tx1, fontSize: 21, fontWeight: FontWeight.w800)), const SizedBox(height: 3), const Text('Connect with people around you', style: TextStyle(color: Gx.tx2, fontSize: 12.5)), const SizedBox(height: 22), _GaxField(ctrl: _emailC, hint: 'Email', icon: Icons.mail_outline_rounded, type: TextInputType.emailAddress, dark: true), const SizedBox(height: 12), _GaxField(ctrl: _passC, hint: 'Password', icon: Icons.shield_outlined, obscure: _hide, dark: true, suffix: GestureDetector(onTap: ()=>setState(()=>_hide=!_hide), child: Icon(_hide ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18, color: Gx.tx2))), if (_err != null) Padding(padding: const EdgeInsets.only(top: 12), child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9), decoration: BoxDecoration(color: Gx.err.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: Gx.err.withOpacity(0.3))), child: Row(children:[const Icon(Icons.warning_amber_rounded, size: 14, color: Gx.err), const SizedBox(width: 8), Expanded(child: Text(_err!, style: const TextStyle(color: Gx.err, fontSize: 12)))]))), const SizedBox(height: 22), _GaxBtn(onTap: _busy ? null : _auth, child: _busy ? const _GaxSpinner() : const Row(mainAxisAlignment: MainAxisAlignment.center, children:[Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)), SizedBox(width: 8), Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white)]))]))]))))))]));
}

class _NebulaPainter extends CustomPainter {
  final double t; _NebulaPainter(this.t);
  @override void paint(Canvas c, Size s) {
    for (var b in [[.14,.18,240.0,Gx.violet],[.84,.14,180.0,Gx.cyan],[.76,.82,200.0,Gx.indigo],[.08,.78,150.0,Gx.violet],[.5,.5,130.0,Gx.cyan]]) {
      c.drawCircle(Offset(s.width*(b[0]as double)+math.sin(t*math.pi*2+(b[0]as double)*7)*32, s.height*(b[1]as double)+math.cos(t*math.pi*2+(b[1]as double)*5)*32), b[2]as double, Paint()..shader=RadialGradient(colors:[(b[3]as Color).withOpacity(0.12),Colors.transparent]).createShader(Rect.fromCircle(center:Offset(s.width*(b[0]as double),s.height*(b[1]as double)),radius:b[2]as double)));
    }
  }
  @override bool shouldRepaint(_NebulaPainter o) => o.t != t;
}

class ProfileSetup extends StatefulWidget { const ProfileSetup({super.key}); @override State<ProfileSetup> createState() => _PSState(); }
class _PSState extends State<ProfileSetup> {
  final _n=TextEditingController(), _u=TextEditingController(), _b=TextEditingController();
  bool _busy=false; String? _err;
  @override void dispose() { _n.dispose(); _u.dispose(); _b.dispose(); super.dispose(); }
  Future<void> _save() async {
    if (_n.text.trim().isEmpty || _u.text.trim().isEmpty) return setState(() => _err = 'Name & username required');
    setState(() { _busy=true; _err=null; });
    final uid=FirebaseAuth.instance.currentUser!.uid, nm=_n.text.trim();
    await FirebaseDatabase.instance.ref('users/$uid').update({'uid':uid, 'name':nm, 'username':_u.text.trim().toLowerCase(), 'bio':_b.text.trim(), 'pfp':'https://ui-avatars.com/api/?name=${Uri.encodeComponent(nm)}&background=0C0D1E&color=7C5CFC&bold=true&size=200', 'status':'online', 'createdAt':ServerValue.timestamp});
    if (mounted) setState(() => _busy = false);
  }
  @override Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(appBar: AppBar(backgroundColor: dark?Gx.d3:Gx.violet, leading: const SizedBox.shrink(), title: const Row(children:[_GaxLogo(size: 28), SizedBox(width: 10), Text('Create Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))])), body: ListView(padding: const EdgeInsets.all(24), children:[const Center(child: _GaxLogo(size: 64)), const SizedBox(height: 10), Center(child: Text('Set up your identity', style: TextStyle(color: dark?Gx.tx2:Gx.tx2L, fontSize: 13))), const SizedBox(height: 32), _GaxField(ctrl: _n, hint: 'Full Name', icon: Icons.person_outline_rounded, dark: dark), const SizedBox(height: 12), _GaxField(ctrl: _u, hint: 'Username', icon: Icons.alternate_email_rounded, dark: dark), const SizedBox(height: 12), _GaxField(ctrl: _b, hint: 'Bio (optional)', icon: Icons.notes_rounded, maxLines: 2, dark: dark), if (_err != null) Padding(padding: const EdgeInsets.only(top: 10), child: Text(_err!, style: const TextStyle(color: Gx.err, fontSize: 12))), const SizedBox(height: 28), _GaxBtn(onTap: _busy ? null : _save, child: _busy ? const _GaxSpinner() : const Text('Get Started', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)))]));
  }
}

class MainScreen extends StatefulWidget { final ThemeCtrl tc; const MainScreen({super.key, required this.tc}); @override State<MainScreen> createState() => _MainState(); }
class _MainState extends State<MainScreen> {
  int _tab=0; late final _pc=PageController();
  @override void dispose() { _pc.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) {
    final myId=FirebaseAuth.instance.currentUser!.uid, dark=Theme.of(ctx).brightness==Brightness.dark;
    return Scaffold(resizeToAvoidBottomInset: false, appBar: _GaxAppBar(tab: _tab, dark: dark, tc: widget.tc), bottomNavigationBar: _buildNavBar(ctx, myId, dark, dark ? Gx.d2 : Colors.white), body: PageView(controller: _pc, physics: const NeverScrollableScrollPhysics(), children:[ChatsTab(myId: myId), const FindTab(), SocialTab(myId: myId), ProfileTab(tc: widget.tc)]));
  }
  Widget _buildNavBar(BuildContext ctx, String myId, bool dark, Color bg) {
    final act=Gx.violet, inact=dark?const Color(0xFF4A4B6A):const Color(0xFF9999BB);
    return StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue, builder: (_, snap) {
      final reqCnt = (snap.data?.snapshot.value as Map?)?.length ?? 0;
      NavigationDestination nD(int i, IconData ic, IconData sIc, String l, bool badge) => NavigationDestination(icon: Badge(isLabelVisible: badge, label: Text(reqCnt>9?'9+':'$reqCnt', style: const TextStyle(fontSize: 8, color: Colors.white)), backgroundColor: act, child: Icon(ic)), selectedIcon: Badge(isLabelVisible: badge, label: Text(reqCnt>9?'9+':'$reqCnt', style: const TextStyle(fontSize: 8, color: Colors.white)), backgroundColor: act, child: Icon(sIc)), label: l);
      return Theme(data: Theme.of(ctx).copyWith(navigationBarTheme: NavigationBarThemeData(backgroundColor: bg, indicatorColor: Gx.violet.withOpacity(0.18), indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), iconTheme: WidgetStateProperty.resolveWith((s)=>IconThemeData(color: s.contains(WidgetState.selected)?act:inact, size: 24)), labelTextStyle: WidgetStateProperty.resolveWith((s)=>TextStyle(fontSize: 10.5, fontWeight: s.contains(WidgetState.selected)?FontWeight.w700:FontWeight.w500, color: s.contains(WidgetState.selected)?act:inact)), height: 64)), child: Column(mainAxisSize: MainAxisSize.min, children:[Divider(height: 1, thickness: 0.8, color: dark?const Color(0xFF1E1F38):const Color(0xFFE0E0EE)), NavigationBar(selectedIndex: _tab, onDestinationSelected: (i) { if(i==_tab)return; HapticFeedback.selectionClick(); setState(()=>_tab=i); _pc.jumpToPage(i); }, destinations:[nD(0,Icons.chat_bubble_outline_rounded,Icons.chat_bubble_rounded,'Chats',false),nD(1,Icons.explore_outlined,Icons.explore_rounded,'Find',false),nD(2,Icons.people_outline_rounded,Icons.people_rounded,'Social',reqCnt>0),nD(3,Icons.person_outline_rounded,Icons.person_rounded,'Profile',false)])]));
    });
  }
}

class _GaxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int tab; final bool dark; final ThemeCtrl tc; const _GaxAppBar({required this.tab, required this.dark, required this.tc});
  static const _t=['Chats','Discover','Social','Profile'];
  @override Size get preferredSize => const Size.fromHeight(58);
  @override Widget build(BuildContext ctx) => Container(color: dark?Gx.d3:Gx.violet, child: SafeArea(bottom: false, child: SizedBox(height: 58, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Row(children:[const SizedBox(width: 6), const _GaxLogo(size: 32), const SizedBox(width: 10), AnimatedSwitcher(duration: const Duration(milliseconds: 220), transitionBuilder: (c,a)=>FadeTransition(opacity:a,child:SlideTransition(position:Tween<Offset>(begin:const Offset(0,.3),end:Offset.zero).animate(a),child:c)), child: Text(_t[tab], key: ValueKey(tab), style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800))), const Spacer(), IconButton(icon: const Icon(Icons.search_rounded, size: 22, color: Colors.white), onPressed: () {}), PopupMenuButton<String>(icon: const Icon(Icons.more_vert_rounded, size: 22, color: Colors.white), color: dark?Gx.d4:Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), onSelected: (v){if(v=='auto')tc.setAuto(!tc.auto); if(v=='th')tc.setDark(!tc.isDarkNow); if(v=='lg')_gaxDialog(ctx,title:'Sign Out',body:'Session clears securely.',confirmLabel:'Sign Out',confirmClr:Gx.rose,onConfirm:()=>FirebaseAuth.instance.signOut());}, itemBuilder: (_)=>[PopupMenuItem(value: 'auto', child: Text(tc.auto?'Auto Theme: ON':'Auto Theme: OFF', style: TextStyle(color: dark?Gx.tx1:Gx.tx1L, fontSize: 14))), PopupMenuItem(value: 'th', child: Text(tc.isDarkNow?'Light Mode':'Dark Mode', style: TextStyle(color: dark?Gx.tx1:Gx.tx1L, fontSize: 14))), PopupMenuItem(value: 'lg', child: Text('Sign Out', style: TextStyle(color: Gx.rose, fontSize: 14)))])])))));
}

class ChatsTab extends StatelessWidget {
  final String myId; const ChatsTab({super.key, required this.myId});
  @override Widget build(BuildContext ctx) => StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue, builder: (_, snap) {
    final ids = (snap.data?.snapshot.value as Map?)?.keys.map((k)=>k.toString()).toList() ??[];
    return ids.isEmpty ? _emp(Icons.chat_bubble_outline_rounded, 'No Conversations', 'Find friends & chat') : _SortedChatList(myId: myId, fIds: ids);
  });
}

class _SortedChatList extends StatefulWidget {
  final String myId; final List<String> fIds; const _SortedChatList({required this.myId, required this.fIds});
  @override State<_SortedChatList> createState() => _SortedChatListState();
}
class _SortedChatListState extends State<_SortedChatList> {
  final _ts=<String,int>{}, _unr=<String,int>{}, _subs=<String,StreamSubscription>{};
  @override void initState() { super.initState(); for (var id in widget.fIds) _sub(id); }
  @override void didUpdateWidget(old) { super.didUpdateWidget(old); final n=widget.fIds.toSet(), o=old.fIds.toSet(); for (var id in n.difference(o)) _sub(id); for (var id in o.difference(n)) { _subs[id]?.cancel(); _subs.remove(id); } }
  void _sub(String id) {
    _subs[id]?.cancel();
    _subs[id] = FirebaseDatabase.instance.ref('chats/${[widget.myId, id]..sort().join('_')}').onValue.listen((e) {
      if(!mounted) return;
      final d=(e.snapshot.value as Map?) ?? {};
      setState(() { _ts[id] = d['lastTs'] as int? ?? 0; _unr[id] = (d['unread'] as Map?)?[widget.myId] as int? ?? 0; });
    });
  }
  @override void dispose() { for(var s in _subs.values)s.cancel(); super.dispose(); }
  @override Widget build(BuildContext ctx) {
    final s = List.from(widget.fIds)..sort((a,b)=>(_ts[b]??0).compareTo(_ts[a]??0));
    return ListView.builder(itemCount: s.length+1, itemBuilder: (_,i) => i==s.length ? const Padding(padding: EdgeInsets.symmetric(vertical: 32), child: Center(child: Text('all caught up', style: TextStyle(fontSize: 11.5, color: Gx.tx2)))) : _AniItem(i, Dismissible(key: Key('conv_${s[i]}'), direction: DismissDirection.endToStart, confirmDismiss: (_) async { bool r=false; await _gaxDialog(ctx,title:'Delete Chat',body:'Removes from list, messages not deleted.',confirmLabel:'Delete',confirmClr:Gx.rose,onConfirm:(){r=true;Navigator.pop(ctx);}); return r; }, onDismissed: (_) => FirebaseDatabase.instance.ref("users/${widget.myId}/friends/${s[i]}").remove().catchError((_){}), background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right:24), color: Gx.rose, child: const Icon(Icons.delete, color: Colors.white)), child: _ConvRow(myId: widget.myId, fid: s[i], unr: _unr[s[i]]??0))));
  }
}

class _ConvRow extends StatelessWidget {
  final String myId, fid; final int unr; const _ConvRow({required this.myId, required this.fid, required this.unr});
  @override Widget build(BuildContext ctx) {
    final chId = ([myId, fid]..sort()).join('_'), d=Theme.of(ctx).brightness==Brightness.dark;
    return StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$fid').onValue, builder: (_, us) {
      final u = Map.from(us.data?.snapshot.value as Map? ?? {});
      if(u.isEmpty) return const SizedBox.shrink();
      return StreamBuilder(stream: FirebaseDatabase.instance.ref('chats/$chId').onValue, builder: (_, cs) {
        final c = cs.data?.snapshot.value as Map? ?? {};
        final rawTxt = c['lastMsg']?.toString() ?? '', lst = rawTxt.isNotEmpty?rawTxt:'Start chatting';
        return _TapScale(onTap: () => _gaxPush(ctx, ChatRoom(target: u)), child: Container(color: unr>0?Gx.violet.withOpacity(0.05):Colors.transparent, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children:[_Avi(pfp: u['pfp']??'', online: u['status']=='online', radius: 27), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Row(children:[Expanded(child: Text(u['name']??'', style: TextStyle(fontWeight: unr>0?FontWeight.w800:FontWeight.w700, fontSize: 15.5, color: d?Gx.tx1:Gx.tx1L))), if(c['lastTs']!=null)Text(_tStr(DateTime.fromMillisecondsSinceEpoch(c['lastTs'])), style: TextStyle(fontSize: 11.5, color: unr>0?Gx.violet:(d?Gx.tx2:Gx.tx2L), fontWeight: unr>0?FontWeight.w700:FontWeight.normal))]), const SizedBox(height: 4), Row(children:[if(c['lastMsgSender']==myId)Icon(Icons.done_all_rounded, size: 14, color: d?Gx.tx2:Gx.tx2L), Expanded(child: StreamBuilder(stream: FirebaseDatabase.instance.ref('typing/$chId/$fid').onValue, builder: (_, ts) => AnimatedSwitcher(duration: const Duration(milliseconds: 200), layoutBuilder:(c,p)=>Stack(alignment:Alignment.centerLeft,children:[...p,if(c!=null)c]), child: (ts.data?.snapshot.value == true) ? const Row(key: ValueKey(1), mainAxisSize: MainAxisSize.min, children:[_DotsLoader(small:true), SizedBox(width: 6), Text('typing…', style: TextStyle(color: Gx.cyan, fontSize: 12, fontStyle: FontStyle.italic))]) : Text(lst, key: const ValueKey(2), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: d?Gx.tx2:Gx.tx2L, fontWeight: unr>0?FontWeight.w600:FontWeight.normal))))), if(unr>0) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(9)), child: Text('$unr', style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800)))])]))])));
      });
    });
  }
}

class FindTab extends StatefulWidget { const FindTab({super.key}); @override State<FindTab> createState() => _FindState(); }
class _FindState extends State<FindTab> {
  String _q=''; final _c=TextEditingController();
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) {
    final id=FirebaseAuth.instance.currentUser!.uid, d=Theme.of(ctx).brightness==Brightness.dark;
    return Column(children:[Container(padding: const EdgeInsets.all(12), color: d?Gx.d2:Gx.l1, child: TextField(controller: _c, onChanged: (v)=>setState(()=>_q=v.toLowerCase()), style: TextStyle(color: d?Gx.tx1:Gx.tx1L), decoration: InputDecoration(hintText: 'Search username...', prefixIcon: Icon(Icons.search, color: _q.isEmpty?Gx.tx2:Gx.violet), suffixIcon: _q.isNotEmpty ? IconButton(icon: const Icon(Icons.cancel, size: 18), onPressed: ()=>setState((){_q='';_c.clear();})) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))), Expanded(child: _q.isEmpty ? Center(child: Text('Type to discover peers', style: TextStyle(color: d?Gx.tx2:Gx.tx2L))) : StreamBuilder(stream: FirebaseDatabase.instance.ref('users').orderByChild('username').startAt(_q).endAt('$_q').onValue, builder: (_, snap) {
      if(!snap.hasData) return const Center(child: _GaxSpinner());
      return StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$id').onValue, builder: (_, pSn) {
        final fId=(((pSn.data?.snapshot.value as Map?)?['friends'] as Map?)?.keys??[]).map((e)=>e.toString()).toSet();
        final rId=(((pSn.data?.snapshot.value as Map?)?['req'] as Map?)?.keys??[]).map((e)=>e.toString()).toSet();
        final l=<Map>[]; (snap.data?.snapshot.value as Map?)?.forEach((_, v) { if(v['uid']!=id && !fId.contains(v['uid'])) l.add(Map.from(v)); });
        return l.isEmpty ? _emp(Icons.search_off, 'No Results', 'Try again') : ListView.builder(itemCount: l.length, itemBuilder: (_, i) => _CRw(l[i], trailing: rId.contains(l[i]['uid']) ? const Text('Sent', style: TextStyle(color: Gx.violet)) : _GaxBtn(onTap:()=>FirebaseDatabase.instance.ref("users/${l[i]['uid']}/req/$id").set(true).catchError((_){}), child: const Text('Add', style: TextStyle(color: Colors.white, fontSize: 13))), padRight: true));
      });
    }))]);
  }
}

class SocialTab extends StatefulWidget { final String myId; const SocialTab({super.key, required this.myId}); @override State<SocialTab> createState() => _SocialState(); }
class _SocialState extends State<SocialTab> {
  String _f='';
  @override Widget build(BuildContext ctx) {
    return CustomScrollView(physics: const BouncingScrollPhysics(), slivers:[SliverToBoxAdapter(child: StreamBuilder(stream: FirebaseDatabase.instance.ref('users/${widget.myId}/req').onValue, builder: (_, s) {
      final ids=(s.data?.snapshot.value as Map?)?.keys.map((k)=>k.toString()).toList()??[];
      if(ids.isEmpty) return const SizedBox();
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Padding(padding: const EdgeInsets.fromLTRB(16,20,16,6), child: Text('REQUESTS · ${ids.length}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Gx.violet))), ...ids.map((id)=>StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$id').onValue, builder: (_, uS) => (uS.data?.snapshot.value==null) ? const SizedBox() : _CRw(Map.from(uS.data!.snapshot.value as Map), trailing: Row(mainAxisSize: MainAxisSize.min, children:[IconButton(icon: const Icon(Icons.close, color: Gx.rose), onPressed: ()=>FirebaseDatabase.instance.ref('users/${widget.myId}/req/$id').remove()), IconButton(icon: const Icon(Icons.check, color: Gx.mint), onPressed: (){ FirebaseDatabase.instance.ref('users/${widget.myId}/friends/$id').set(true); FirebaseDatabase.instance.ref('users/$id/friends/${widget.myId}').set(true); FirebaseDatabase.instance.ref('users/${widget.myId}/req/$id').remove();})]))))]);
    })), SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), child: _GaxField(hint: 'Search friends', icon: Icons.search, dark: Theme.of(ctx).brightness==Brightness.dark, onChanged: (v)=>setState(()=>_f=v.toLowerCase())))), SliverToBoxAdapter(child: StreamBuilder(stream: FirebaseDatabase.instance.ref('users/${widget.myId}/friends').onValue, builder: (ctx, snap) {
      final ids=(snap.data?.snapshot.value as Map?)?.keys.map((k)=>k.toString()).toList()??[];
      return ids.isEmpty ? _emp(Icons.people, 'No Friends Yet', 'Head to Discover') : Column(children:[_OnlineStrip(ids, widget.myId, Theme.of(ctx).brightness==Brightness.dark), ...ids.map((id)=>StreamBuilder(stream: FirebaseDatabase.instance.ref('users/$id').onValue, builder: (_, uS) {
        final u = Map.from(uS.data?.snapshot.value as Map? ?? {});
        if(_f.isNotEmpty && !u['name'].toString().toLowerCase().contains(_f)) return const SizedBox();
        return u.isEmpty ? const SizedBox() : _CRw(u, onTap: ()=>_gaxPush(ctx, ChatRoom(target: u)), trailing: Row(mainAxisSize: MainAxisSize.min, children:[IconButton(icon: const Icon(Icons.chat_bubble_outline, color: Gx.violet), onPressed: ()=>_gaxPush(ctx, ChatRoom(target: u))), IconButton(icon: const Icon(Icons.person_remove, color: Gx.tx2), onPressed: ()=>_gaxDialog(ctx,title:'Unfriend',body:'Remove ${u['name']}?',confirmLabel:'Yes',confirmClr:Gx.rose,onConfirm:(){FirebaseDatabase.instance.ref('users/${widget.myId}/friends/$id').remove();FirebaseDatabase.instance.ref('users/$id/friends/${widget.myId}').remove();Navigator.pop(ctx);}))]));
      }))]);
    }))]);
  }
}

class _OnlineStrip extends StatefulWidget {
  final List<String> fIds; final String myId; final bool d; const _OnlineStrip(this.fIds, this.myId, this.d);
  @override State<_OnlineStrip> createState() => _OStripSt();
}
class _OStripSt extends State<_OnlineStrip> {
  final _on=<String,bool>{}; final _s=<StreamSubscription>[];
  @override void initState() { super.initState(); _lis(); }
  @override void didUpdateWidget(old) { super.didUpdateWidget(old); if(old.fIds.length!=widget.fIds.length)_lis(); }
  void _lis() { for(var s in _s){s.cancel();} _s.clear(); for(var i in widget.fIds){ _s.add(FirebaseDatabase.instance.ref('users/$i/status').onValue.listen((e){if(mounted)setState(()=>_on[i]=e.snapshot.value=='online');}));} }
  @override void dispose() { for(var s in _s){s.cancel();} super.dispose(); }
  @override Widget build(BuildContext ctx) {
    final live = _on.entries.where((e)=>e.value).map((e)=>e.key).toList();
    if(live.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[const Padding(padding: EdgeInsets.fromLTRB(16,16,16,4), child: Text('ONLINE NOW', style: TextStyle(color: Gx.live, fontSize: 10, fontWeight: FontWeight.bold))), SizedBox(height: 85, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 14), itemCount: live.length, itemBuilder: (_,i)=>StreamBuilder(stream: FirebaseDatabase.instance.ref('users/${live[i]}').onValue, builder: (_,sn){ final u=Map.from(sn.data?.snapshot.value as Map? ?? {}); return u.isEmpty?const SizedBox():_TapScale(onTap: ()=>_gaxPush(ctx,ChatRoom(target:u)), child: Padding(padding: const EdgeInsets.only(right: 14), child: Column(mainAxisSize: MainAxisSize.min, children:[_Avi(pfp: u['pfp']??'', online: true, radius: 26), const SizedBox(height: 5), SizedBox(width: 55, child: Text(u['name']??'', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: widget.d?Gx.tx1:Gx.tx1L)))]))); })))]);
  }
}

class ProfileTab extends StatelessWidget {
  final ThemeCtrl tc; const ProfileTab({super.key, required this.tc});
  @override Widget build(BuildContext ctx) {
    final d=Theme.of(ctx).brightness==Brightness.dark;
    return StreamBuilder(stream: FirebaseDatabase.instance.ref('users/${FirebaseAuth.instance.currentUser!.uid}').onValue, builder: (_, sn) {
      final m=Map.from(sn.data?.snapshot.value as Map? ?? {}); if(m.isEmpty)return const SizedBox();
      return ListView(children:[Container(decoration: BoxDecoration(gradient: d?Gx.gHdr:Gx.gLHdr), child: SafeArea(bottom: false, child: Column(children:[const SizedBox(height: 32), GestureDetector(onTap:()=>showModalBottomSheet(context: ctx, isScrollControlled: true, backgroundColor: d?Gx.d4:Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))), builder: (c)=>_EditProfileSheet(m)), child: _Avi(pfp: m['pfp']??'', online: m['status']=='online', radius: 46)), const SizedBox(height: 14), Text(m['name']??'', style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)), Text('@${m['username']}', style: const TextStyle(color: Colors.white70)), Padding(padding: const EdgeInsets.symmetric(vertical: 18), child: Text(m['bio']??'', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white))) ]))), ListTile(leading: const Icon(Icons.dark_mode), title: const Text('Theme Selection'), trailing: DropdownButtonHideUnderline(child: DropdownButton<int>(value: tc.auto?1:0, items: const[DropdownMenuItem(value:1,child:Text('Auto')),DropdownMenuItem(value:0,child:Text('Manual'))], onChanged: (v){if(v==1)tc.setAuto(true); else {tc.setAuto(false); tc.setDark(d);}})), contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8)), if(!tc.auto) SwitchListTile(value: d, onChanged: (v)=>tc.setDark(v), title: const Text('Force Dark Mode'), secondary: const Icon(Icons.nights_stay), contentPadding: const EdgeInsets.symmetric(horizontal: 24)), ListTile(leading: const Icon(Icons.logout, color: Gx.rose), title: const Text('Log Out', style: TextStyle(color: Gx.rose)), onTap: ()=>FirebaseAuth.instance.signOut(), contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8))]);
    });
  }
}

class _EditProfileSheet extends StatefulWidget { final Map d; const _EditProfileSheet(this.d); @override State<_EditProfileSheet> createState()=>_EPS();}
class _EPS extends State<_EditProfileSheet> {
  late final n=TextEditingController(text:widget.d['name']), u=TextEditingController(text:widget.d['username']), b=TextEditingController(text:widget.d['bio']), p=TextEditingController(text:widget.d['pfp']);
  @override Widget build(BuildContext c) => Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(c).viewInsets.bottom + 20), child: Column(mainAxisSize: MainAxisSize.min, children:[_GaxField(ctrl: n, hint: 'Name', dark: Theme.of(c).brightness==Brightness.dark), const SizedBox(height: 10), _GaxField(ctrl: u, hint: 'Username', dark: Theme.of(c).brightness==Brightness.dark), const SizedBox(height: 10), _GaxField(ctrl: b, hint: 'Bio', maxLines: 3, dark: Theme.of(c).brightness==Brightness.dark), const SizedBox(height: 10), _GaxField(ctrl: p, hint: 'PFP Link', dark: Theme.of(c).brightness==Brightness.dark), const SizedBox(height: 16), _GaxBtn(onTap: (){FirebaseDatabase.instance.ref('users/${widget.d['uid']}').update({'name':n.text, 'username':u.text, 'bio':b.text, 'pfp':p.text}); Navigator.pop(c);}, child: const Text('Save Changes', style: TextStyle(color: Colors.white)))]));
}

class ChatRoom extends StatefulWidget { final Map target; const ChatRoom({super.key, required this.target}); @override State<ChatRoom> createState() => _ChatState(); }
class _ChatState extends State<ChatRoom> with TickerProviderStateMixin {
  final _msgC=TextEditingController(), _scr=ScrollController(); late final String cId, myId=FirebaseAuth.instance.currentUser!.uid;
  Timer? _tTimer; Map? _reply, _pin; bool _h=false;
  @override void initState() {
    super.initState(); cId=([myId, widget.target['uid']]..sort()).join('_');
    final ref = FirebaseDatabase.instance.ref; ref.child('chats/$cId/members').update({myId:true, widget.target['uid'].toString():true});
    ref.child('typing/$cId/$myId').onDisconnect().set(false); ref.child('chats/$cId/pinned').onValue.listen((e){if(!mounted)return;final pk=e.snapshot.value; if(pk!=null)ref.child('messages/$cId/$pk').get().then((s){if(mounted)setState(()=>_pin=s.value as Map?);});else if(mounted)setState(()=>_pin=null);});
    _msgC.addListener((){if(_h!=_msgC.text.trim().isNotEmpty)setState(()=>_h=_msgC.text.trim().isNotEmpty);}); _mrk();
  }
  @override void dispose() { _msgC.dispose(); _scr.dispose(); _tTimer?.cancel(); FirebaseDatabase.instance.ref('typing/$cId/$myId').set(false); super.dispose(); }
  void _mrk()=>FirebaseDatabase.instance.ref('messages/$cId').get().then((s){final m=s.value as Map?;if(m!=null){m.forEach((k,v){if(v['senderId']!=myId && v['read']!=true) FirebaseDatabase.instance.ref('messages/$cId/$k/read').set(true);});FirebaseDatabase.instance.ref('chats/$cId/unread/$myId').set(0);}});
  void _tP(_) { FirebaseDatabase.instance.ref('typing/$cId/$myId').set(true); _tTimer?.cancel(); _tTimer=Timer(const Duration(seconds:2),()=>FirebaseDatabase.instance.ref('typing/$cId/$myId').set(false)); }
  void _btm() => WidgetsBinding.instance.addPostFrameCallback((_) { if(mounted&&_scr.hasClients)_scr.jumpTo(_scr.position.maxScrollExtent); });
  Future<void> _snd(String t, String tp) async {
    if(t.trim().isEmpty)return; final r=FirebaseDatabase.instance.ref, py={'senderId':myId, 'text':t, 'timestamp':ServerValue.timestamp, 'read':false, 'type':tp};
    if(_reply!=null){ py['replyTo']={'text':_reply!['text'], 'senderId':_reply!['senderId'], 'type':_reply!['type']??'text'}; setState(()=>_reply=null); }
    _msgC.clear(); _tTimer?.cancel(); r.child('typing/$cId/$myId').set(false);
    await r.child('messages/$cId').push().set(py);
    await r.child('chats/$cId').update({'lastMsg': tp=='image'?'📷 Image':(t.length>40?'${t.substring(0,40)}...':t), 'lastMsgType': tp, 'lastMsgSender': myId, 'lastTs': ServerValue.timestamp});
    await r.child('chats/$cId/unread/${widget.target['uid']}').set(ServerValue.increment(1));
    _mrk(); _btm();
  }
  @override Widget build(BuildContext ctx) {
    final d = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(appBar: AppBar(titleSpacing: 0, title: Row(children:[_Avi(pfp: widget.target['pfp']??'', online: widget.target['status']=='online', radius: 18), const SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text(widget.target['name'], style: const TextStyle(fontSize: 16)), StreamBuilder(stream: FirebaseDatabase.instance.ref('typing/$cId/${widget.target['uid']}').onValue, builder: (_, ts)=>Text((ts.data?.snapshot.value==true)?'typing...':'@${widget.target['username']}', style: const TextStyle(fontSize: 11, color: Colors.white70)))])])), body: Column(children:[
      if(_pin!=null) Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), color: d?Gx.d2:Gx.l2, child: Row(children:[const Icon(Icons.push_pin, size: 14, color: Gx.violet), const SizedBox(width: 8), Expanded(child: Text(_pin!['text']??'', maxLines: 1, overflow: TextOverflow.ellipsis)), IconButton(icon: const Icon(Icons.close, size: 14), onPressed: ()=>FirebaseDatabase.instance.ref('chats/$cId/pinned').remove())])),
      Expanded(child: StreamBuilder(stream: FirebaseDatabase.instance.ref('messages/$cId').onValue, builder: (_, s) {
        if(!s.hasData) return const Center(child: CircularProgressIndicator());
        final lst=(s.data!.snapshot.value as Map? ?? {}).entries.map((e)=>Map<String,dynamic>.from(e.value)..['_key']=e.key).toList()..sort((a,b)=>((a['timestamp']??0)as num).compareTo((b['timestamp']??0)as num));
        WidgetsBinding.instance.addPostFrameCallback((_) => _btm());
        return ListView.builder(controller: _scr, padding: const EdgeInsets.all(12), itemCount: lst.length, itemBuilder: (_, i) {
          final m=lst[i], me=m['senderId']==myId;
          return Align(alignment: me?Alignment.centerRight:Alignment.centerLeft, child: GestureDetector(onLongPress: ()=>_acts(m, me), onDoubleTap: (){FirebaseDatabase.instance.ref('messages/$cId/${m['_key']}/reactions/$myId').set('❤️');}, child: Container(margin: const EdgeInsets.symmetric(vertical: 2), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: me?(d?Gx.d4:Gx.violet.withOpacity(0.1)):(d?Gx.d2:Colors.white), borderRadius: BorderRadius.circular(16).copyWith(bottomRight: me?Radius.zero:null, bottomLeft: me?null:Radius.zero)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[if(m['replyTo']!=null) Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(border: Border(left: BorderSide(color: Gx.violet, width: 2)), color: Colors.black12), child: Text(m['replyTo']['text']??'', maxLines: 1, style: const TextStyle(fontSize: 12))), m['type']=='image' ? Image.network(m['text'], width: 200, fit: BoxFit.cover) : m['type']=='link' ? _LnkWdg(url: m['text']) : Text(m['text'], style: TextStyle(color: d?Colors.white:Colors.black87)), const SizedBox(height: 2), Text(_tStr(DateTime.fromMillisecondsSinceEpoch(m['timestamp'])), style: TextStyle(fontSize: 9, color: d?Colors.white38:Colors.black38))]))));
        });
      })),
      if(_reply!=null) Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), color: d?Gx.d3:Gx.l2, child: Row(children:[Expanded(child: Text('Replying to: ${_reply!['text']}', maxLines: 1)), IconButton(icon: const Icon(Icons.close), onPressed: ()=>setState(()=>_reply=null))])),
      SafeArea(child: Container(padding: const EdgeInsets.all(8), color: d?Gx.d2:Colors.white, child: Row(children:[IconButton(icon: const Icon(Icons.image), onPressed: (){showModalBottomSheet(context: ctx, builder: (c)=>_LinkSheetUI((u){Navigator.pop(c);_snd(u, 'image');}, 'Image URL'));}), IconButton(icon: const Icon(Icons.link), onPressed: (){showModalBottomSheet(context: ctx, builder: (c)=>_LinkSheetUI((u){Navigator.pop(c);_snd(u, 'link');}, 'Web Link'));}), Expanded(child: TextField(controller: _msgC, onChanged: _tP, decoration: const InputDecoration(hintText: 'Message...', border: InputBorder.none, contentPadding: EdgeInsets.all(12)))), IconButton(icon: Icon(Icons.send, color: _h?Gx.violet:Gx.tx2), onPressed: _h?()=>_snd(_msgC.text,'text'):null)])))
    ]));
  }

  void _acts(Map m, bool me) => showModalBottomSheet(context: context, builder: (c)=>Column(mainAxisSize: MainAxisSize.min, children:[ListTile(leading: const Icon(Icons.reply), title: const Text('Reply'), onTap: (){setState(()=>_reply=m);Navigator.pop(c);}), if(me) ListTile(leading: const Icon(Icons.push_pin), title: const Text('Pin'), onTap: (){FirebaseDatabase.instance.ref('chats/$cId/pinned').set(m['_key']);Navigator.pop(c);}), if(me) ListTile(leading: const Icon(Icons.delete, color: Gx.rose), title: const Text('Delete'), onTap: (){FirebaseDatabase.instance.ref('messages/$cId/${m['_key']}').remove();Navigator.pop(c);})]));
}

class _LinkSheetUI extends StatefulWidget { final void Function(String) onS; final String hint; const _LinkSheetUI(this.onS, this.hint); @override State<_LinkSheetUI> createState() => _LSSt(); }
class _LSSt extends State<_LinkSheetUI> { final _c=TextEditingController(); @override Widget build(BuildContext c)=>Padding(padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(c).viewInsets.bottom+16), child: Row(children:[Expanded(child: TextField(controller: _c, decoration: InputDecoration(hintText: widget.hint))), IconButton(icon: const Icon(Icons.send), onPressed: ()=>widget.onS(_c.text.trim()))])); }
class _LnkWdg extends StatelessWidget { final String url; const _LnkWdg({required this.url}); @override Widget build(BuildContext ctx) => GestureDetector(onTap: ()=>_openUrl(url), child: Text(url, style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline))); }

Widget _emp(IconData ic, String t, String s) => Center(child: Column(mainAxisSize: MainAxisSize.min, children:[Icon(ic, size: 54, color: Gx.violet), const SizedBox(height: 14), Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(s, style: const TextStyle(color: Gx.tx2))]));
String _tStr(DateTime d){ final n=DateTime.now(); if(n.difference(d).inDays==0&&n.day==d.day)return DateFormat('hh:mm a').format(d); if(n.difference(d).inDays<=1)return 'Yesterday'; return DateFormat('dd/MM/yy').format(d); }
void _gaxPush(BuildContext c, Widget p)=>Navigator.push(c,PageRouteBuilder(pageBuilder:(_,__,___)=>p, transitionsBuilder: (_,a,__,ch)=>SlideTransition(position: Tween(begin:const Offset(1,0),end:Offset.zero).animate(a),child:ch)));
void _gaxDialog(BuildContext ctx, {required String title, required String body, required String confirmLabel, required Color confirmClr, required VoidCallback onConfirm})=>showDialog(context:ctx, builder:(c)=>AlertDialog(title:Text(title), content:Text(body), actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')), TextButton(onPressed:onConfirm, child:Text(confirmLabel,style:TextStyle(color:confirmClr)))]));
class _DotsLoader extends StatelessWidget { final bool small; const _DotsLoader({this.small=false}); @override Widget build(BuildContext c)=>SizedBox(width:small?14:30,height:small?14:30, child:const CircularProgressIndicator(strokeWidth:2)); }
class _GaxLogo extends StatelessWidget { final double size; const _GaxLogo({required this.size}); @override Widget build(BuildContext c)=>Icon(Icons.flash_on_rounded, size:size, color:Gx.violet); }
class _BrandText extends StatelessWidget { final String text; final double size, spacing; const _BrandText(this.text, {required this.size, required this.spacing}); @override Widget build(BuildContext ctx)=>Text(text, style: TextStyle(color: Gx.violet, fontSize: size, fontWeight: FontWeight.bold, letterSpacing: spacing)); }
class _GaxSpinner extends StatelessWidget { const _GaxSpinner(); @override Widget build(BuildContext ctx)=>const SizedBox(width:20,height:20,child:CircularProgressIndicator(strokeWidth:2)); }
class _GlassCard extends StatelessWidget { final Widget child; const _GlassCard({required this.child}); @override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.all(22), decoration:BoxDecoration(color:Gx.d3.withOpacity(0.9), borderRadius:BorderRadius.circular(20), border:Border.all(color:Gx.violet)), child:child); }
class _GaxField extends StatelessWidget { final TextEditingController? ctrl; final String hint; final IconData? icon; final TextInputType? type; final bool obscure, dark; final Widget? suffix; final int? maxLines; final ValueChanged<String>? onChanged; const _GaxField({this.ctrl, required this.hint, this.icon, this.type, this.obscure=false, this.dark=true, this.suffix, this.maxLines, this.onChanged}); @override Widget build(BuildContext ctx)=>TextField(controller:ctrl, keyboardType:type, obscureText:obscure, maxLines:obscure?1:maxLines??1, onChanged:onChanged, decoration:InputDecoration(hintText:hint, prefixIcon:icon!=null?Icon(icon):null, suffixIcon:suffix)); }
class _GaxBtn extends StatelessWidget { final Widget child; final VoidCallback? onTap; const _GaxBtn({required this.child, this.onTap}); @override Widget build(BuildContext ctx)=>GestureDetector(onTap:onTap, child:Container(height:50, decoration:BoxDecoration(gradient:Gx.gBrand, borderRadius:BorderRadius.circular(15)), child:Center(child:child))); }
class _AniItem extends StatelessWidget { final Widget child; final int index; const _AniItem(this.index, this.child); @override Widget build(BuildContext c)=>child; }
class _TapScale extends StatelessWidget { final Widget child; final VoidCallback? onTap; const _TapScale({required this.child, this.onTap}); @override Widget build(BuildContext ctx)=>InkWell(onTap:onTap, child:child); }
class _Avi extends StatelessWidget { final String pfp; final bool online; final double radius; const _Avi({required this.pfp, required this.online, required this.radius}); @override Widget build(BuildContext c)=>Stack(children:[CircleAvatar(radius:radius, backgroundImage:(pfp.isNotEmpty)?NetworkImage(pfp):null, backgroundColor:Gx.violet), if(online)Positioned(right:0,bottom:0,child:Container(width:12,height:12,decoration:BoxDecoration(color:Gx.live,shape:BoxShape.circle,border:Border.all(color:Colors.white))))]); }
class _CRw extends StatelessWidget { final Map u; final Widget? trailing; final VoidCallback? onTap; final bool padRight; const _CRw(this.u, {this.trailing, this.onTap, this.padRight=false}); @override Widget build(BuildContext c)=>ListTile(onTap:onTap, leading:_Avi(pfp:u['pfp']??'',online:u['status']=='online',radius:22), title:Text(u['name']??''), subtitle:Text('@${u['username']??''}'), trailing:trailing); }