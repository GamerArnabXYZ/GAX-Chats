import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
Future<void> _openUrl(String raw) async {
  final url = raw.trim().startsWith('http') ? raw.trim() : 'https://${raw.trim()}';
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasAbsolutePath) return;
  if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
}
class Gx {
  static const d0 = Color(0xFF05050E);
  static const d1 = Color(0xFF080916);
  static const d2 = Color(0xFF0C0D1E);
  static const d3 = Color(0xFF111228);
  static const d4 = Color(0xFF171933);
  static const d5 = Color(0xFF1F2142);
  static const d6 = Color(0xFF262950);
  static const l0 = Color(0xFFF7F7FF);
  static const l1 = Color(0xFFFFFFFF);
  static const l2 = Color(0xFFEEEEFB);
  static const l3 = Color(0xFFE4E4F6);
  static const l4 = Color(0xFFD8D8F0);
  static const violet = Color(0xFF7C5CFC);
  static const cyan   = Color(0xFF00D4FF);
  static const indigo = Color(0xFF4535CC);
  static const mint   = Color(0xFF00E5A0);
  static const rose   = Color(0xFFFF4D80);
  static const amber  = Color(0xFFFFB340);
  static const sentD  = Color(0xFF1A1650);
  static const recvD  = Color(0xFF0F1024);
  static const sentL  = Color(0xFFEDE8FF);
  static const recvL  = Color(0xFFFFFFFF);
  static const tx1  = Color(0xFFF0F0FF);
  static const tx2  = Color(0xFF7878A8);
  static const tx3  = Color(0xFF3C3D62);
  static const tx1L = Color(0xFF080916);
  static const tx2L = Color(0xFF5A5A88);
  static const tx3L = Color(0xFF9090C0);
  static const live    = Color(0xFF2EFF9A);
  static const away    = Color(0xFF3A3D60);
  static const readClr = Color(0xFF00D4FF);
  static const err     = Color(0xFFFF4D80);
  static const divD = Color(0xFF141630);
  static const divL = Color(0xFFDDDDF4);
  static const navL = Color(0xFFFFFFFF);
  static const navD = Color(0xFF0C0D1E);
  static const gBrand = LinearGradient(colors: [violet, cyan],   begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gBrand2 = LinearGradient(colors: [violet, Color(0xFFB044FF)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gDeep  = LinearGradient(colors: [Color(0xFF080916), Color(0xFF05050E)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const gHdr   = LinearGradient(colors: [Color(0xFF130F40), Color(0xFF080916)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gLHdr  = LinearGradient(colors: [Color(0xFF6040E8), Color(0xFF8560FF)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gCard  = LinearGradient(colors: [Color(0xFF1F2142), Color(0xFF171933)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static List<BoxShadow> glow(Color c, {double b = 20, double s = -2}) => [BoxShadow(color: c.withOpacity(0.30), blurRadius: b, spreadRadius: s)];
  static List<BoxShadow> glow2(Color c) => [BoxShadow(color: c.withOpacity(0.18), blurRadius: 28, spreadRadius: -4, offset: const Offset(0, 8))];
  static List<BoxShadow> softShadow(bool dark) => [BoxShadow(color: Colors.black.withOpacity(dark ? 0.30 : 0.10), blurRadius: 12, offset: const Offset(0, 3))];
}
ThemeData gaxTheme(bool dark) {
  final bg   = dark ? Gx.d1 : Gx.l0;
  final surf = dark ? Gx.d3 : Gx.l1;
  final fill = dark ? Gx.d4 : Gx.l2;
  final tx1  = dark ? Gx.tx1 : Gx.tx1L;
  final tx2  = dark ? Gx.tx2 : Gx.tx2L;
  return ThemeData(
    useMaterial3: true,
    brightness: dark ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: bg,
    colorScheme: ColorScheme.fromSeed(seedColor: Gx.violet, brightness: dark ? Brightness.dark : Brightness.light)
        .copyWith(primary: Gx.violet, secondary: Gx.cyan, surface: surf, error: Gx.err),
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? Gx.d3 : Gx.violet,
      foregroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0, centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: dark ? Gx.navD : Gx.navL,
        systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      ),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.1),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: fill,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Gx.violet, width: 1.6)),
      hintStyle: TextStyle(color: tx2, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    ),
    listTileTheme: ListTileThemeData(textColor: tx1, iconColor: tx2),
    dividerTheme: DividerThemeData(color: dark ? Gx.divD : Gx.divL, thickness: 0.6),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Gx.violet : Colors.grey),
      trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Gx.violet.withOpacity(0.4) : Colors.grey.withOpacity(0.3)),
    ),
  );
}
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
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onSystemBrightnessChanged;
    _startAutoCheck();
  }
  void _onSystemBrightnessChanged() {
    if (!_auto || _autoMode == AutoThemeMode.timeBased) return;
    notifyListeners();
  }
  void setAuto(bool v) {
    _auto = v;
    if (v) { _autoMode = AutoThemeMode.system; _mode = ThemeMode.system; _applyAuto(); }
    notifyListeners();
  }
  void setAutoMode(AutoThemeMode m) {
    _auto = true; _autoMode = m;
    if (m == AutoThemeMode.timeBased) _applyTimeTheme(); else _mode = ThemeMode.system;
    notifyListeners();
  }
  void setDark(bool v) { _auto = false; _mode = v ? ThemeMode.dark : ThemeMode.light; notifyListeners(); }
  void _applyAuto() {
    if (!_auto) return;
    if (_autoMode == AutoThemeMode.timeBased) _applyTimeTheme(); else _mode = ThemeMode.system;
  }
  void _applyTimeTheme() {
    if (!_auto) return;
    final h = DateTime.now().hour;
    final newMode = (h < 6 || h >= 19) ? ThemeMode.dark : ThemeMode.light;
    if (newMode != _mode) { _mode = newMode; notifyListeners(); }
  }
  void _startAutoCheck() {
    _applyAuto();
    _autoTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      if (_auto && _autoMode == AutoThemeMode.timeBased) _applyTimeTheme();
    });
  }
  @override
  void dispose() {
    _autoTimer?.cancel();
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
    super.dispose();
  }
}
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
  final _tc = ThemeCtrl();
  @override void dispose() { _tc.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) => ListenableBuilder(
    listenable: _tc,
    builder: (_, __) {
      _updateSystemUI(_tc.isDarkNow);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: gaxTheme(false), darkTheme: gaxTheme(true), themeMode: _tc.mode,
        home: _AuthGate(tc: _tc),
      );
    },
  );
  void _updateSystemUI(bool dark) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: dark ? Brightness.dark : Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: dark ? Gx.navD : Gx.navL,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark,
  ));
}
class _AuthGate extends StatefulWidget {
  final ThemeCtrl tc;
  const _AuthGate({required this.tc});
  @override State<_AuthGate> createState() => _AuthGateState();
}
class _AuthGateState extends State<_AuthGate> {
  // _screen: null=loading, 0=login, 1=profileSetup, 2=main
  int? _screen;
  String? _uid;
  StreamSubscription? _authSub;

  @override
  void initState() {
    super.initState();
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (mounted) setState(() { _screen = 0; _uid = null; });
      } else {
        _uid = user.uid;
        _checkProfile(user.uid);
      }
    });
  }

  Future<void> _checkProfile(String uid) async {
    if (mounted) setState(() => _screen = null);
    try {
      final snap = await FirebaseDatabase.instance.ref('users/$uid').get();
      if (!mounted) return;
      if (!snap.exists || snap.value == null) {
        setState(() => _screen = 1);
        return;
      }
      final map = Map<String, dynamic>.from(snap.value as Map);
      final username = map['username']?.toString().trim() ?? '';
      if (username.isEmpty) {
        setState(() => _screen = 1);
        return;
      }
      _setPresence(uid);
      _migrateMissingMembers(uid);
      setState(() => _screen = 2);
    } catch (e) {
      debugPrint('Profile check: $e');
      if (mounted) setState(() => _screen = 1);
    }
  }

  void _setPresence(String uid) {
    final db = FirebaseDatabase.instance;
    db.ref('users/$uid/status').set('online').catchError((e) => debugPrint('Presence: $e'));
    db.ref('users/$uid/status').onDisconnect().set('offline').catchError((e) => debugPrint('Presence dc: $e'));
    db.ref('users/$uid/lastSeen').onDisconnect().set(ServerValue.timestamp).catchError((e) => debugPrint('LastSeen dc: $e'));
  }

  Future<void> _migrateMissingMembers(String myId) async {
    try {
      final snap = await FirebaseDatabase.instance.ref('users/$myId/friends').get();
      if (!snap.exists || snap.value == null) return;
      final friends = (snap.value as Map).keys.map((k) => k.toString()).toList();
      final db = FirebaseDatabase.instance;
      for (final fid in friends) {
        final chatId = ([myId, fid]..sort()).join('_');
        final m = await db.ref('chats/$chatId/members/$myId').get();
        if (!m.exists) {
          await db.ref('chats/$chatId/members').update({myId: true, fid: true})
              .catchError((e) => debugPrint('Migrate $chatId: $e'));
        }
      }
    } catch (e) { debugPrint('Migration: $e'); }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    if (_screen == null) return const _Splash();
    if (_screen == 0)    return const LoginScreen();
    if (_screen == 1)    return ProfileSetup(onComplete: () => _checkProfile(_uid!));
    return MainScreen(tc: widget.tc);
  }
}
void _showErrorSnackbar(BuildContext ctx, String msg) {
  if (!ctx.mounted) return;
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating, backgroundColor: Gx.rose));
}
Function(Object) _showError(BuildContext ctx, String msg) => (e) {
  debugPrint('$msg: $e');
  if (ctx.mounted) _showErrorSnackbar(ctx, msg);
};
class _Splash extends StatefulWidget {
  const _Splash();
  @override State<_Splash> createState() => _SplashState();
}
class _SplashState extends State<_Splash> with TickerProviderStateMixin {
  late final _ac    = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
  late final _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);
  late final _ring  = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat();
  late final _fade  = CurvedAnimation(parent: _ac, curve: const Interval(0, .6, curve: Curves.easeOut));
  late final _rise  = Tween<Offset>(begin: const Offset(0, .12), end: Offset.zero).animate(CurvedAnimation(parent: _ac, curve: const Interval(0, .7, curve: Curves.easeOutCubic)));
  late final _scalePulse = Tween(begin: 0.95, end: 1.05).animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  @override void dispose() { _ac.dispose(); _pulse.dispose(); _ring.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: Gx.d0,
    body: Center(child: FadeTransition(opacity: _fade, child: SlideTransition(position: _rise,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ScaleTransition(scale: _scalePulse, child: Stack(alignment: Alignment.center, children: [
          AnimatedBuilder(animation: _ring, builder: (_, __) => Transform.rotate(
            angle: _ring.value * 2 * math.pi,
            child: Container(width: 116, height: 116, decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: SweepGradient(colors: [Gx.violet.withOpacity(0.55), Colors.transparent, Gx.cyan.withOpacity(0.45), Colors.transparent]))),
          )),
          Container(width: 100, height: 100, decoration: const BoxDecoration(shape: BoxShape.circle, color: Gx.d0)),
          _GaxLogo(size: 82),
        ])),
        const SizedBox(height: 24),
        _BrandText('GAX', size: 38, spacing: 9),
        const SizedBox(height: 7),
        const Text('Messaging · Reimagined', style: TextStyle(color: Gx.tx2, fontSize: 13, letterSpacing: 0.8)),
        const SizedBox(height: 36),
        _DotsLoader(),
      ]),
    ))),
  );
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginState();
}
class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  final _emailC = TextEditingController();
  final _passC  = TextEditingController();
  bool _busy = false, _hide = true;
  String? _err;
  late final _bgAc  = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(reverse: true);
  late final _entAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
  late final _fadeA = CurvedAnimation(parent: _entAc, curve: Curves.easeOut);
  late final _slideA = Tween<Offset>(begin: const Offset(0, .16), end: Offset.zero).animate(CurvedAnimation(parent: _entAc, curve: Curves.easeOutCubic));
  @override void dispose() { _emailC.dispose(); _passC.dispose(); _bgAc.dispose(); _entAc.dispose(); super.dispose(); }
  Future<void> _auth() async {
    if (_emailC.text.trim().isEmpty || _passC.text.trim().isEmpty) {
      if (mounted) setState(() => _err = 'Enter email and password');
      return;
    }
    if (mounted) setState(() { _busy = true; _err = null; });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailC.text.trim(), password: _passC.text.trim());
    } catch (_) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailC.text.trim(), password: _passC.text.trim());
      } catch (e) {
        if (mounted) setState(() => _err = 'Invalid credentials or weak password (min 6 chars)');
      }
    }
    if (mounted) setState(() => _busy = false);
  }
  @override
  Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height;
    return Scaffold(
      backgroundColor: Gx.d0, resizeToAvoidBottomInset: true,
      body: Stack(children: [
        AnimatedBuilder(animation: _bgAc, builder: (_, __) => CustomPaint(painter: _NebulaPainter(_bgAc.value), size: MediaQuery.of(ctx).size)),
        SafeArea(child: FadeTransition(opacity: _fadeA, child: SlideTransition(position: _slideA,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: h - MediaQuery.of(ctx).padding.top),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(height: h * .09),
                _GaxLogo(size: 70), const SizedBox(height: 18),
                _BrandText('GAX CHATS', size: 23, spacing: 5),
                const SizedBox(height: 7),
                const Text('Sign in · account is auto-created', style: TextStyle(color: Gx.tx2, fontSize: 12.5, letterSpacing: 0.2)),
                SizedBox(height: h * .06),
                _GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _GradientBar(),
                  const SizedBox(height: 16),
                  const Text('Welcome to GAX', style: TextStyle(color: Gx.tx1, fontSize: 21, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 3),
                  const Text('Connect with people around you', style: TextStyle(color: Gx.tx2, fontSize: 12.5)),
                  const SizedBox(height: 22),
                  _GaxField(ctrl: _emailC, hint: 'Email address', icon: Icons.mail_outline_rounded, type: TextInputType.emailAddress, dark: true),
                  const SizedBox(height: 12),
                  _GaxField(ctrl: _passC, hint: 'Password', icon: Icons.shield_outlined, obscure: _hide, dark: true,
                    suffix: GestureDetector(
                      onTap: () => setState(() => _hide = !_hide),
                      child: Icon(_hide ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18, color: Gx.tx2),
                    )),
                  if (_err != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      decoration: BoxDecoration(color: Gx.err.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: Gx.err.withOpacity(0.3))),
                      child: Row(children: [
                        const Icon(Icons.warning_amber_rounded, size: 14, color: Gx.err), const SizedBox(width: 8),
                        Expanded(child: Text(_err!, style: const TextStyle(color: Gx.err, fontSize: 12))),
                      ]),
                    ),
                  ],
                  const SizedBox(height: 22),
                  _GaxBtn(onTap: _busy ? null : _auth, child: _busy
                    ? const _GaxSpinner()
                    : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                      ])),
                ])),
                SizedBox(height: h * .06),
              ]),
            ),
          ),
        ))),
      ]),
    );
  }
}
class _NebulaPainter extends CustomPainter {
  final double t;
  _NebulaPainter(this.t);
  @override
  void paint(Canvas canvas, Size s) {
    for (final b in [
      [0.14, 0.18, 240.0, Gx.violet], [0.84, 0.14, 180.0, Gx.cyan],
      [0.76, 0.82, 200.0, Gx.indigo], [0.08, 0.78, 150.0, Gx.violet], [0.5, 0.5, 130.0, Gx.cyan],
    ]) {
      final dx = math.sin(t * math.pi * 2 + (b[0] as double) * 7) * 32;
      final dy = math.cos(t * math.pi * 2 + (b[1] as double) * 5) * 32;
      final cx = s.width * (b[0] as double) + dx;
      final cy = s.height * (b[1] as double) + dy;
      final r  = b[2] as double;
      canvas.drawCircle(Offset(cx, cy), r, Paint()..shader =
        RadialGradient(colors: [(b[3] as Color).withOpacity(0.12), Colors.transparent]).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)));
    }
  }
  @override bool shouldRepaint(_NebulaPainter o) => o.t != t;
}
class ProfileSetup extends StatefulWidget {
  final VoidCallback? onComplete;
  const ProfileSetup({super.key, this.onComplete});
  @override State<ProfileSetup> createState() => _PSState();
}
class _PSState extends State<ProfileSetup> {
  final _n = TextEditingController(), _u = TextEditingController(), _b = TextEditingController();
  bool _busy = false;
  String? _err;
  @override void dispose() { _n.dispose(); _u.dispose(); _b.dispose(); super.dispose(); }
  Future<void> _save() async {
    if (_n.text.trim().isEmpty || _u.text.trim().isEmpty) {
      if (mounted) setState(() => _err = 'Name & username required');
      return;
    }
    final username = _u.text.trim().toLowerCase();
    if (!RegExp(r'^[a-z0-9_]{3,20}$').hasMatch(username)) {
      if (mounted) setState(() => _err = 'Username: 3-20 chars, only a-z 0-9 _');
      return;
    }
    if (!mounted) return;
    setState(() { _busy = true; _err = null; });
    try {
      final uid  = FirebaseAuth.instance.currentUser!.uid;
      final name = _n.text.trim();
      await FirebaseDatabase.instance.ref('users/$uid').set({
        'uid': uid,
        'name': name,
        'username': username,
        'bio': _b.text.trim(),
        'pfp': 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0C0D1E&color=7C5CFC&bold=true&size=200',
        'createdAt': ServerValue.timestamp,
      });
      // Wait for Firebase to confirm write before releasing busy state
      // This prevents the StreamBuilder from flickering
    } catch (e) {
      debugPrint('Profile save error: $e');
      if (mounted) setState(() { _busy = false; _err = 'Failed to save. Check connection.'; });
      return;
    }
    if (mounted) {
      setState(() => _busy = false);
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: dark ? Gx.d3 : Gx.violet, elevation: 0,
        leading: const SizedBox.shrink(),
        title: Row(children: [_GaxLogo(size: 28), const SizedBox(width: 10), const Text('Create Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))]),
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const SizedBox(height: 8),
        Center(child: _GaxLogo(size: 64)),
        const SizedBox(height: 10),
        Center(child: Text('Set up your GAX identity', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13))),
        const SizedBox(height: 32),
        _GaxField(ctrl: _n, hint: 'Full Name *', icon: Icons.person_outline_rounded, dark: dark),
        const SizedBox(height: 12),
        _GaxField(ctrl: _u, hint: 'Username *', icon: Icons.alternate_email_rounded, dark: dark),
        const SizedBox(height: 12),
        _GaxField(ctrl: _b, hint: 'Bio (optional)', icon: Icons.notes_rounded, maxLines: 2, dark: dark),
        if (_err != null) ...[const SizedBox(height: 10), Text(_err!, style: const TextStyle(color: Gx.err, fontSize: 12))],
        const SizedBox(height: 28),
        _GaxBtn(onTap: _busy ? null : _save, child: _busy
          ? const _GaxSpinner()
          : const Text('Get Started', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))),
      ]),
    );
  }
}
class MainScreen extends StatefulWidget {
  final ThemeCtrl tc;
  const MainScreen({super.key, required this.tc});
  @override State<MainScreen> createState() => _MainState();
}
class _MainState extends State<MainScreen> {
  int _tab = 0;
  late final _pc = PageController();
  @override void dispose() { _pc.dispose(); super.dispose(); }
  void _goTab(int i) {
    if (i == _tab) return;
    HapticFeedback.selectionClick();
    setState(() => _tab = i);
    _pc.jumpToPage(i);
  }
  @override
  Widget build(BuildContext ctx) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final dark  = Theme.of(ctx).brightness == Brightness.dark;
    final bg    = dark ? const Color(0xFF0C0D1E) : Colors.white;
    return Scaffold(
      backgroundColor: dark ? Gx.d1 : Gx.l0,
      resizeToAvoidBottomInset: false,
      appBar: _GaxAppBar(tab: _tab, dark: dark, tc: widget.tc, myId: myId),
      bottomNavigationBar: _buildNavBar(ctx, myId, dark, bg),
      body: PageView(
        controller: _pc, physics: const NeverScrollableScrollPhysics(),
        children: [ChatsTab(myId: myId), const FindTab(), SocialTab(myId: myId), ProfileTab(tc: widget.tc)],
      ),
    );
  }
  Widget _buildNavBar(BuildContext ctx, String myId, bool dark, Color bg) {
    const icons = [
      [Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded],
      [Icons.explore_outlined, Icons.explore_rounded],
      [Icons.people_outline_rounded, Icons.people_rounded],
      [Icons.person_outline_rounded, Icons.person_rounded],
    ];
    const labels = ['Chats', 'Find', 'Social', 'Profile'];
    final inactiveClr = dark ? const Color(0xFF4A4B6A) : const Color(0xFF9999BB);
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue,
      builder: (_, snap) {
        final reqCnt = (snap.hasData && snap.data!.snapshot.value != null)
            ? (snap.data!.snapshot.value as Map? ?? {}).length : 0;
        return Theme(
          data: Theme.of(ctx).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: bg,
              indicatorColor: Gx.violet.withOpacity(0.18),
              indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(
                color: s.contains(WidgetState.selected) ? Gx.violet : inactiveClr, size: 24)),
              labelTextStyle: WidgetStateProperty.resolveWith((s) {
                final active = s.contains(WidgetState.selected);
                return TextStyle(fontSize: 10.5, fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? Gx.violet : inactiveClr, letterSpacing: 0.1);
              }),
              elevation: 0, shadowColor: Colors.transparent, surfaceTintColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow, height: 64,
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Divider(height: 1, thickness: 0.8, color: dark ? const Color(0xFF1E1F38) : const Color(0xFFE0E0EE)),
            NavigationBar(
              selectedIndex: _tab, onDestinationSelected: _goTab,
              animationDuration: const Duration(milliseconds: 300),
              destinations: List.generate(4, (i) {
                final hasReq = i == 2 && reqCnt > 0;
                final badge = hasReq ? Text(reqCnt > 9 ? '9+' : '$reqCnt', style: const TextStyle(fontSize: 8, color: Colors.white)) : null;
                return NavigationDestination(
                  icon: Badge(isLabelVisible: hasReq, label: badge, backgroundColor: Gx.violet, child: Icon(icons[i][0] as IconData)),
                  selectedIcon: Badge(isLabelVisible: hasReq, label: badge, backgroundColor: Gx.violet, child: Icon(icons[i][1] as IconData)),
                  label: labels[i],
                );
              }),
            ),
          ]),
        );
      },
    );
  }
}
class _GaxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int tab; final bool dark; final ThemeCtrl tc; final String myId;
  const _GaxAppBar({required this.tab, required this.dark, required this.tc, required this.myId});
  static const _titles = ['Chats', 'Discover', 'Social', 'Profile'];
  @override Size get preferredSize => const Size.fromHeight(58);
  @override
  Widget build(BuildContext ctx) => Container(
    color: dark ? Gx.d3 : Gx.violet,
    child: SafeArea(bottom: false, child: SizedBox(height: 58, child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(children: [
        const SizedBox(width: 6),
        _GaxLogo(size: 32), const SizedBox(width: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          transitionBuilder: (c, a) => FadeTransition(opacity: a, child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(a), child: c)),
          child: Text(_titles[tab], key: ValueKey(tab),
            style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: 0.1)),
        ),
        const Spacer(),
        IconButton(icon: const Icon(Icons.search_rounded, size: 22, color: Colors.white), onPressed: () {}),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded, size: 22, color: Colors.white),
          color: dark ? Gx.d4 : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onSelected: (v) {
            if (v == 'auto') tc.setAuto(!tc.auto);
            if (v == 'theme') tc.setDark(!tc.isDarkNow);
            if (v == 'logout') _gaxDialog(ctx, title: 'Sign Out', body: "You'll need to sign in again.",
              confirmLabel: 'Sign Out', confirmClr: Gx.rose,
              onConfirm: () { Navigator.pop(ctx); FirebaseAuth.instance.signOut(); });
          },
          itemBuilder: (_) => [
            _mi('auto',  tc.auto ? Icons.brightness_auto : Icons.brightness_auto_outlined, tc.auto ? 'Auto Theme: ON' : 'Auto Theme: OFF', dark),
            _mi('theme', tc.isDarkNow ? Icons.light_mode_rounded : Icons.dark_mode_rounded, tc.isDarkNow ? 'Light Mode' : 'Dark Mode', dark),
            _mi('logout', Icons.logout_rounded, 'Sign Out', dark, clr: Gx.rose),
          ],
        ),
        const SizedBox(width: 2),
      ]),
    ))),
  );
  PopupMenuItem<String> _mi(String val, IconData icon, String label, bool dark, {Color? clr}) =>
      PopupMenuItem(value: val, child: Row(children: [
        Icon(icon, size: 17, color: clr ?? (dark ? Gx.tx2 : Gx.tx2L)), const SizedBox(width: 10),
        Text(label, style: TextStyle(color: clr ?? (dark ? Gx.tx1 : Gx.tx1L), fontSize: 14)),
      ]));
}
class ChatsTab extends StatelessWidget {
  final String myId;
  const ChatsTab({super.key, required this.myId});
  @override
  Widget build(BuildContext ctx) => StreamBuilder(
    stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
    builder: (ctx, snap) {
      if (!snap.hasData || snap.data!.snapshot.value == null)
        return _emptyView(Icons.chat_bubble_outline_rounded, 'No Conversations', 'Find friends and start chatting');
      final ids = (snap.data!.snapshot.value as Map? ?? {}).keys.map((k) => k.toString()).toList();
      if (ids.isEmpty) return _emptyView(Icons.chat_bubble_outline_rounded, 'No Conversations', 'Find friends and start chatting');
      return _SortedChatList(myId: myId, friendIds: ids);
    },
  );
}
class _SortedChatList extends StatefulWidget {
  final String myId;
  final List<String> friendIds;
  const _SortedChatList({required this.myId, required this.friendIds});
  @override State<_SortedChatList> createState() => _SortedChatListState();
}
class _SortedChatListState extends State<_SortedChatList> {
  final Map<String, int> _lastTs   = {};
  final Map<String, int> _unread   = {};
  final Map<String, String> _lastMsg = {};
  final Map<String, String> _lastSender = {};
  final Map<String, StreamSubscription> _subs = {};
  @override void initState()  { super.initState(); _subscribeAll(widget.friendIds); }
  @override void dispose()    { for (final s in _subs.values) s.cancel(); super.dispose(); }
  @override
  void didUpdateWidget(_SortedChatList old) {
    super.didUpdateWidget(old);
    final newIds = widget.friendIds.toSet();
    final oldIds = old.friendIds.toSet();
    for (final id in newIds.difference(oldIds)) _subscribeSingle(id);
    for (final id in oldIds.difference(newIds)) { _subs[id]?.cancel(); _subs.remove(id); }
  }
  void _subscribeAll(List<String> ids) { for (final id in ids) _subscribeSingle(id); }
  void _subscribeSingle(String fid) {
    final chatId = ([widget.myId, fid]..sort()).join('_');
    _subs[fid]?.cancel();
    _subs[fid] = FirebaseDatabase.instance.ref('chats/$chatId').onValue.listen((e) {
      if (!mounted) return;
      final d = e.snapshot.value is Map ? Map<String, dynamic>.from(e.snapshot.value as Map) : <String, dynamic>{};
      setState(() {
        _lastTs[fid]     = d['lastTs'] is int ? d['lastTs'] as int : 0;
        _lastMsg[fid]    = d['lastMsg']?.toString() ?? '';
        _lastSender[fid] = d['lastMsgSender']?.toString() ?? '';
        final unreadMap  = d['unread'] is Map ? d['unread'] as Map : {};
        _unread[fid]     = unreadMap[widget.myId] is int ? unreadMap[widget.myId] as int : 0;
      });
    });
  }
  @override
  Widget build(BuildContext ctx) {
    final sorted = List<String>.from(widget.friendIds)
      ..sort((a, b) => (_lastTs[b] ?? 0).compareTo(_lastTs[a] ?? 0));
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: sorted.length + 1,
      itemBuilder: (ctx, i) {
        if (i == sorted.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(child: Divider(color: dark ? Gx.divD : Gx.divL, indent: 32, endIndent: 12)),
              Text('all caught up', style: TextStyle(color: dark ? Gx.tx3 : Gx.tx3L, fontSize: 11.5, fontWeight: FontWeight.w500, letterSpacing: 0.4)),
              Expanded(child: Divider(color: dark ? Gx.divD : Gx.divL, indent: 12, endIndent: 32)),
            ]),
          );
        }
        final fid    = sorted[i];
        final unread = _unread[fid] ?? 0;
        final lastMsg = _lastMsg[fid] ?? '';
        final lastSender = _lastSender[fid] ?? '';
        final lastTs  = _lastTs[fid] ?? 0;
        return _AnimatedListItem(
          index: i,
          child: Dismissible(
            key: Key('conv_$fid'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (_) async {
              bool confirmed = false;
              await showDialog(context: ctx, builder: (dCtx) => _GaxAlertDialog(
                title: 'Delete Conversation',
                body: 'This will remove the chat from your list. Messages are not deleted.',
                confirmLabel: 'Delete', confirmClr: Gx.rose,
                onConfirm: () { confirmed = true; Navigator.pop(dCtx); },
              ));
              return confirmed;
            },
            onDismissed: (_) => FirebaseDatabase.instance.ref('users/${widget.myId}/friends/$fid').remove()
                .catchError(_showError(ctx, 'Failed to remove friend')),
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(gradient: LinearGradient(
                colors: [Colors.transparent, Gx.rose.withOpacity(0.85)],
                begin: Alignment.centerLeft, end: Alignment.centerRight)),
              child: const Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
                SizedBox(height: 4),
                Text('Delete', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ]),
            ),
            child: _ConvRow(
              myId: widget.myId, fid: fid, unread: unread,
              lastMsg: lastMsg, lastSender: lastSender, lastTs: lastTs,
            ),
          ),
        );
      },
    );
  }
}
class _ConvRow extends StatelessWidget {
  final String myId, fid, lastMsg, lastSender;
  final int unread, lastTs;
  const _ConvRow({required this.myId, required this.fid, required this.unread,
    required this.lastMsg, required this.lastSender, required this.lastTs});
  @override
  Widget build(BuildContext ctx) {
    final dark   = Theme.of(ctx).brightness == Brightness.dark;
    final chatId = ([myId, fid]..sort()).join('_');
    final hasUnread = unread > 0;
    final mine = lastSender == myId;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$fid').onValue,
      builder: (_, uSnap) {
        if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
        final u = Map<String, dynamic>.from(uSnap.data!.snapshot.value as Map? ?? {});
        final displayMsg = lastMsg.isNotEmpty ? lastMsg : 'Tap to start chatting';
        return _TapScale(
          onTap: () { HapticFeedback.lightImpact(); _gaxPush(ctx, ChatRoom(target: u)); },
          child: Container(
            color: hasUnread ? Gx.violet.withOpacity(dark ? 0.05 : 0.04) : Colors.transparent,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(children: [
                  _Avi(pfp: u['pfp'] ?? '', online: u['status'] == 'online', radius: 27),
                  const SizedBox(width: 13),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Expanded(child: Text(u['name'] ?? '',
                        style: TextStyle(fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w700,
                          fontSize: 15.5, color: dark ? Gx.tx1 : Gx.tx1L))),
                      if (lastTs > 0) Text(_timeStr(DateTime.fromMillisecondsSinceEpoch(lastTs)),
                        style: TextStyle(fontSize: 11.5,
                          color: hasUnread ? Gx.violet : (dark ? Gx.tx2 : Gx.tx2L),
                          fontWeight: hasUnread ? FontWeight.w700 : FontWeight.normal)),
                    ]),
                    const SizedBox(height: 4),
                    Row(children: [
                      if (mine) ...[Icon(Icons.done_all_rounded, size: 14, color: dark ? Gx.tx2 : Gx.tx2L), const SizedBox(width: 3)],
                      Expanded(child: StreamBuilder(
                        stream: FirebaseDatabase.instance.ref('typing/$chatId/$fid').onValue,
                        builder: (_, tSnap) {
                          final typing = tSnap.hasData && tSnap.data!.snapshot.value == true;
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            layoutBuilder: (cur, prev) => Stack(alignment: Alignment.centerLeft,
                              children: [...prev, if (cur != null) cur]),
                            child: typing
                              ? Row(key: const ValueKey('t'), mainAxisSize: MainAxisSize.min, children: [
                                  _DotsLoader(small: true), const SizedBox(width: 6),
                                  Text('typing…', style: TextStyle(color: Gx.cyan, fontSize: 12, fontStyle: FontStyle.italic)),
                                ])
                              : Text(displayMsg, key: const ValueKey('m'), maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, color: dark ? Gx.tx2 : Gx.tx2L,
                                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal)),
                          );
                        },
                      )),
                      if (hasUnread) _UnreadBadge(count: unread),
                    ]),
                  ])),
                ]),
              ),
              Padding(padding: const EdgeInsets.only(left: 72),
                child: Divider(height: 1, thickness: 0.5, color: dark ? Gx.divD : Gx.divL)),
            ]),
          ),
        );
      },
    );
  }
}
class _UnreadBadge extends StatelessWidget {
  final int count;
  const _UnreadBadge({this.count = 1});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(99), boxShadow: Gx.glow(Gx.violet, b: 8)),
    child: Text(count > 99 ? '99+' : '$count', style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800)),
  );
}
class FindTab extends StatefulWidget {
  const FindTab({super.key});
  @override State<FindTab> createState() => _FindState();
}
class _FindState extends State<FindTab> {
  String _q = '';
  final _ctrl = TextEditingController();
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final dark  = Theme.of(ctx).brightness == Brightness.dark;
    return Column(children: [
      Container(
        color: dark ? Gx.d2 : Gx.l1,
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        child: Container(
          decoration: BoxDecoration(
            color: dark ? Gx.d4 : Gx.l2, borderRadius: BorderRadius.circular(14),
            border: _q.isNotEmpty ? Border.all(color: Gx.violet.withOpacity(0.3)) : null,
          ),
          child: Row(children: [
            const SizedBox(width: 12),
            Icon(Icons.search_rounded, size: 20, color: _q.isNotEmpty ? Gx.violet : Gx.tx2),
            const SizedBox(width: 8),
            Expanded(child: TextField(
              controller: _ctrl, onChanged: (v) => setState(() => _q = v),
              style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Search by @username…',
                border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none,
                filled: false, contentPadding: const EdgeInsets.symmetric(vertical: 13),
                hintStyle: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L),
              ),
            )),
            if (_q.isNotEmpty) GestureDetector(
              onTap: () { _ctrl.clear(); setState(() => _q = ''); },
              child: Padding(padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.cancel_rounded, size: 18, color: dark ? Gx.tx2 : Gx.tx2L)),
            ),
          ]),
        ),
      ),
      Expanded(child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _q.isEmpty
          ? _FindEmptyView(myId: myId)
          : StreamBuilder(
              stream: FirebaseDatabase.instance.ref('users').orderByChild('username')
                  .startAt(_q.toLowerCase()).endAt('${_q.toLowerCase()}\uf8ff').onValue,
              builder: (ctx, snap) {
                if (!snap.hasData) return const Center(child: _GaxSpinner());
                return StreamBuilder(
                  stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
                  builder: (ctx, friendSnap) {
                    final friendIds = <String>{};
                    if (friendSnap.hasData && friendSnap.data!.snapshot.value != null)
                      (friendSnap.data!.snapshot.value as Map? ?? {}).forEach((k, _) => friendIds.add(k.toString()));
                    return StreamBuilder(
                      stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue,
                      builder: (ctx, reqSnap) {
                        final list = <Map>[];
                        (snap.data!.snapshot.value as Map?)?.forEach((k, v) {
                          if (v is Map) {
                            final uid = v['uid']?.toString() ?? '';
                            if (uid != myId && !friendIds.contains(uid)) list.add(Map<String, dynamic>.from(v));
                          }
                        });
                        if (list.isEmpty) return _emptyView(Icons.search_off_rounded, 'No Results', 'Try a different username');
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (ctx, i) {
                            final uid    = list[i]['uid']?.toString() ?? '';
                            final reqSent = reqSnap.hasData && reqSnap.data!.snapshot.value != null
                                && (reqSnap.data!.snapshot.value as Map? ?? {}).containsKey(uid);
                            return _AnimatedListItem(index: i, child: _ContactRow(
                              u: list[i],
                              trailing: reqSent
                                ? Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(color: Gx.violet.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                                      Icon(Icons.check_rounded, size: 14, color: Gx.violet), const SizedBox(width: 4),
                                      Text('Sent', style: TextStyle(color: Gx.violet, fontSize: 12, fontWeight: FontWeight.w600)),
                                    ]),
                                  )
                                : _GaxChip(label: 'Add', icon: Icons.person_add_alt_1_rounded,
                                    onTap: () {
                                      HapticFeedback.mediumImpact();
                                      FirebaseDatabase.instance.ref('users/$uid/req/$myId').set(true)
                                          .catchError(_showError(ctx, 'Failed to send request'));
                                    }),
                            ));
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
      )),
    ]);
  }
}
class SocialTab extends StatefulWidget {
  final String myId;
  const SocialTab({super.key, required this.myId});
  @override State<SocialTab> createState() => _SocialState();
}
class _SocialState extends State<SocialTab> {
  String _filter = '';
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('users/${widget.myId}/req').onValue,
          builder: (_, snap) {
            if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();
            final ids = (snap.data!.snapshot.value as Map? ?? {}).keys.map((k) => k.toString()).toList();
            if (ids.isEmpty) return const SizedBox();
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _SectionLabel('REQUESTS  ·  ${ids.length}'),
              ...ids.asMap().entries.map((e) => StreamBuilder(
                stream: FirebaseDatabase.instance.ref('users/${e.value}').onValue,
                builder: (_, uSnap) {
                  if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
                  final u = Map.from(uSnap.data!.snapshot.value as Map? ?? {});
                  return _AnimatedListItem(index: e.key, child: _ContactRow(u: u,
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      _RoundBtn(icon: Icons.close_rounded, color: Gx.rose,
                        onTap: () {
                          HapticFeedback.lightImpact();
                          FirebaseDatabase.instance.ref('users/${widget.myId}/req/${e.value}').remove()
                              .catchError(_showError(ctx, 'Failed to decline request'));
                        }),
                      const SizedBox(width: 8),
                      _RoundBtn(icon: Icons.check_rounded, color: Gx.mint,
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          FirebaseDatabase.instance.ref().update({
                            'users/${widget.myId}/friends/${e.value}': true,
                            'users/${e.value}/friends/${widget.myId}': true,
                            'users/${widget.myId}/req/${e.value}': null,
                          }).catchError(_showError(ctx, 'Failed to accept request'));
                        }),
                    ]),
                  ));
                },
              )),
            ]);
          },
        )),
        SliverToBoxAdapter(child: Column(children: [
          _SectionLabel('FRIENDS'),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 8),
            child: _GaxField(hint: 'Search friends…', icon: Icons.search_rounded, dark: dark,
              onChanged: (v) => setState(() => _filter = v.toLowerCase())),
          ),
        ])),
        SliverToBoxAdapter(child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('users/${widget.myId}/friends').onValue,
          builder: (ctx, snap) {
            if (!snap.hasData || snap.data!.snapshot.value == null)
              return _emptyView(Icons.people_outline_rounded, 'No Friends Yet', 'Start adding people from Find tab');
            final ids = (snap.data!.snapshot.value as Map? ?? {}).keys.map((k) => k.toString()).toList();
            return Column(children: [
              _OnlineFriendsStrip(friendIds: ids, myId: widget.myId, dark: dark),
              ...ids.asMap().entries.map((e) => StreamBuilder(
                stream: FirebaseDatabase.instance.ref('users/${e.value}').onValue,
                builder: (_, uSnap) {
                  if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
                  final u = Map.from(uSnap.data!.snapshot.value as Map? ?? {});
                  if (_filter.isNotEmpty && !(u['name'] ?? '').toString().toLowerCase().contains(_filter)) return const SizedBox();
                  return _AnimatedListItem(index: e.key, child: _ContactRow(u: u,
                    onTap: () => _gaxPush(ctx, ChatRoom(target: u)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      _RoundBtn(icon: Icons.chat_bubble_outline_rounded, color: Gx.violet,
                        onTap: () => _gaxPush(ctx, ChatRoom(target: u))),
                      const SizedBox(width: 8),
                      _RoundBtn(icon: Icons.person_remove_outlined, color: Gx.rose,
                        onTap: () => _gaxDialog(ctx,
                          title: 'Remove Friend', body: 'Remove ${u['name']} from your friends?',
                          confirmLabel: 'Remove', confirmClr: Gx.rose,
                          onConfirm: () {
                            FirebaseDatabase.instance.ref().update({
                              'users/${widget.myId}/friends/${e.value}': null,
                              'users/${e.value}/friends/${widget.myId}': null,
                            }).catchError(_showError(ctx, 'Failed to remove friend'));
                            Navigator.pop(ctx);
                          })),
                    ]),
                  ));
                },
              )).toList(),
            ]);
          },
        )),
      ],
    );
  }
}
class ProfileTab extends StatefulWidget {
  final ThemeCtrl tc;
  const ProfileTab({super.key, required this.tc});
  @override State<ProfileTab> createState() => _ProfileTabState();
}
class _ProfileTabState extends State<ProfileTab> {
  bool _isAdmin = false;
  @override
  void initState() {
    super.initState();
    final myId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance.ref('admins/$myId').get().then((snap) {
      if (mounted && snap.exists) setState(() => _isAdmin = true);
    });
  }
  @override
  Widget build(BuildContext ctx) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final dark  = Theme.of(ctx).brightness == Brightness.dark;
    final tc = widget.tc;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$myId').onValue,
      builder: (_, snap) {
        if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();
        final d = Map.from(snap.data!.snapshot.value as Map? ?? {});
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(child: _ProfileHeader(d: d, dark: dark, onEdit: () {
            showModalBottomSheet(context: ctx, isScrollControlled: true, useSafeArea: true,
              backgroundColor: dark ? Gx.d4 : Colors.white,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
              builder: (c) => _EditProfileSheet(d: d));
          })),
          SliverToBoxAdapter(child: Column(children: [
            const SizedBox(height: 12),
            _SectionLabel('APPEARANCE'),
            _PrefRow(
              icon: Icons.brightness_auto, dark: dark,
              iconGrad: const LinearGradient(colors: [Color(0xFF4B3ECC), Gx.violet]),
              title: 'Auto Theme',
              subtitle: tc.auto
                ? (tc.autoMode == AutoThemeMode.system ? "Follows phone's dark mode" : "Changes by time of day")
                : 'Manual',
              trailing: Switch.adaptive(value: tc.auto, onChanged: tc.setAuto, activeColor: Gx.violet,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
            ),
            AnimatedCrossFade(
              crossFadeState: tc.auto ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 220),
              firstChild: Column(children: [
                _PrefRow(icon: Icons.phone_android_rounded, dark: dark,
                  iconGrad: const LinearGradient(colors: [Color(0xFF00509D), Color(0xFF00AAFF)]),
                  title: "Follow Phone's Mode", subtitle: "Uses your phone's dark/light setting",
                  trailing: _RadioDot(selected: tc.autoMode == AutoThemeMode.system),
                  onTap: () => tc.setAutoMode(AutoThemeMode.system)),
                _PrefRow(icon: Icons.schedule_rounded, dark: dark,
                  iconGrad: const LinearGradient(colors: [Color(0xFF805000), Gx.amber]),
                  title: 'Time-Based', subtitle: 'Dark 7PM–6AM · Light otherwise',
                  trailing: _RadioDot(selected: tc.autoMode == AutoThemeMode.timeBased),
                  onTap: () => tc.setAutoMode(AutoThemeMode.timeBased)),
              ]),
              secondChild: _PrefRow(icon: Icons.dark_mode_rounded, dark: dark,
                iconGrad: const LinearGradient(colors: [Color(0xFF222260), Color(0xFF4B3ECC)]),
                title: 'Dark Mode',
                trailing: Switch.adaptive(value: tc.isDarkNow, onChanged: tc.setDark, activeColor: Gx.violet,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
            ),
            _SectionLabel('ACCOUNT'),
            _PrefRow(icon: Icons.manage_accounts_outlined, dark: dark,
              iconGrad: const LinearGradient(colors: [Color(0xFF0080CC), Gx.cyan]),
              title: 'Edit Profile', onTap: () {
                showModalBottomSheet(context: ctx, isScrollControlled: true, useSafeArea: true,
                  backgroundColor: dark ? Gx.d4 : Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
                  builder: (c) => _EditProfileSheet(d: d));
              }),
            _PrefRow(icon: Icons.support_agent_rounded, dark: dark,
              iconGrad: const LinearGradient(colors: [Color(0xFF005B9F), Gx.cyan]),
              title: 'Support & Feedback',
              onTap: () => _gaxPush(ctx, const SupportEntryPoint())),
            if (_isAdmin) ...[
              _SectionLabel('ADMIN'),
              _PrefRow(icon: Icons.dashboard_outlined, dark: dark,
                iconGrad: const LinearGradient(colors: [Color(0xFF5B0090), Gx.violet]),
                title: 'Feedback Dashboard',
                subtitle: 'View all user bug reports & feedback',
                onTap: () => _gaxPush(ctx, const FeedbackDashboard())),
            ],
            _PrefRow(icon: Icons.notifications_outlined, dark: dark,
              iconGrad: const LinearGradient(colors: [Color(0xFF7B4F00), Gx.amber]),
              title: 'Notifications', subtitle: 'Message sounds & vibration',
              trailing: Switch.adaptive(value: true, onChanged: (_) {}, activeColor: Gx.violet,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
            _PrefRow(icon: Icons.info_outline_rounded, dark: dark,
              iconGrad: const LinearGradient(colors: [Color(0xFF1E7D32), Gx.mint]),
              title: 'About GAX', onTap: () => _showAbout(ctx)),
            _PrefRow(icon: Icons.logout_rounded, dark: dark,
              iconGrad: LinearGradient(colors: [Color(0xFF8B0020), Gx.rose]),
              title: 'Sign Out', titleColor: Gx.rose,
              onTap: () => _gaxDialog(ctx, title: 'Sign Out', body: 'Sign out from GAX Chats?',
                confirmLabel: 'Sign Out', confirmClr: Gx.rose,
                onConfirm: () { Navigator.pop(ctx); FirebaseAuth.instance.signOut(); })),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Gx.violet.withOpacity(0.22))),
              child: Center(child: ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
                child: const Text('GAX  ·  v1.0  ·  GamerArnabXYZ',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)))),
            ),
            const SizedBox(height: 40),
          ])),
        ]);
      },
    );
  }
  void _showAbout(BuildContext ctx) => showDialog(context: ctx, builder: (c) => _GaxAlertDialog(
    title: 'About GAX',
    body: 'GAX Chats — real-time messaging.\nFast. Secure. Yours.\n\nv1.0  ·  Built by GamerArnabXYZ\nArnabLabZ Studio\n\n✨ Features: Emoji reactions, message forward, URL sharing, online friends, real-time presence, smart unread counts, support chat.',
    confirmLabel: 'Close', confirmClr: Gx.violet, onConfirm: () => Navigator.pop(c),
  ));
}
class _EditProfileSheet extends StatefulWidget {
  final Map d;
  const _EditProfileSheet({required this.d});
  @override State<_EditProfileSheet> createState() => _EditProfileSheetState();
}
class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController n, u, b, p;
  @override void initState() {
    super.initState();
    n = TextEditingController(text: widget.d['name']);
    u = TextEditingController(text: widget.d['username']);
    b = TextEditingController(text: widget.d['bio'] ?? '');
    p = TextEditingController(text: widget.d['pfp'] ?? '');
  }
  @override void dispose() { n.dispose(); u.dispose(); b.dispose(); p.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext c) {
    final dark = Theme.of(c).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom + 24, left: 22, right: 22, top: 14),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _SheetHandle(), const SizedBox(height: 16),
        ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
          child: const Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))),
        const SizedBox(height: 20),
        _GaxField(ctrl: n, hint: 'Name', icon: Icons.person_outline_rounded, dark: dark),
        const SizedBox(height: 10),
        _GaxField(ctrl: u, hint: 'Username', icon: Icons.alternate_email_rounded, dark: dark),
        const SizedBox(height: 10),
        _GaxField(ctrl: b, hint: 'Bio', icon: Icons.notes_rounded, maxLines: 2, dark: dark),
        const SizedBox(height: 10),
        _GaxField(ctrl: p, hint: 'Avatar URL', icon: Icons.image_outlined, dark: dark),
        const SizedBox(height: 22),
        _GaxBtn(onTap: () {
          if (n.text.trim().isEmpty || u.text.trim().isEmpty) return;
          FirebaseDatabase.instance.ref('users/${widget.d['uid']}').update({
            'name': n.text.trim(), 'username': u.text.trim().toLowerCase(),
            'pfp': p.text.trim().isEmpty ? (widget.d['pfp'] ?? '') : p.text.trim(),
            'bio': b.text.trim(),
          }).catchError(_showError(c, 'Failed to update profile'));
          Navigator.pop(c);
        }, child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
      ]),
    );
  }
}
class _ProfileHeader extends StatelessWidget {
  final Map d; final bool dark; final VoidCallback onEdit;
  const _ProfileHeader({required this.d, required this.dark, required this.onEdit});
  @override
  Widget build(BuildContext ctx) => Container(
    decoration: BoxDecoration(gradient: dark ? Gx.gHdr : Gx.gLHdr),
    child: SafeArea(bottom: false, child: Column(children: [
      const SizedBox(height: 28),
      GestureDetector(onTap: onEdit, child: Stack(alignment: Alignment.bottomRight, children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: Gx.gBrand, boxShadow: Gx.glow(Gx.violet, b: 26)),
          child: CircleAvatar(radius: 42, backgroundColor: Gx.d3,
            backgroundImage: NetworkImage(d['pfp'] ?? ''), onBackgroundImageError: (_, __) {}),
        ),
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(gradient: Gx.gBrand, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.3), width: 2)),
          child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
        ),
      ])),
      const SizedBox(height: 14),
      Text(d['name'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      ShaderMask(shaderCallback: (r) => const LinearGradient(colors: [Colors.white, Color(0xFFBBAAFF)]).createShader(r),
        child: Text('@${d['username'] ?? ''}', style: const TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w600))),
      if ((d['bio'] ?? '').isNotEmpty) ...[
        const SizedBox(height: 8),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(d['bio'].toString(), textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 13))),
      ],
      const SizedBox(height: 16),
      StreamBuilder(
        stream: FirebaseDatabase.instance.ref('users/${d['uid']}/friends').onValue,
        builder: (_, snap) {
          final count = (snap.hasData && snap.data!.snapshot.value != null)
              ? (snap.data!.snapshot.value as Map? ?? {}).length : 0;
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _StatPill(label: 'Friends', value: '$count'),
            const SizedBox(width: 12),
            _StatPill(label: 'Status', value: d['status'] == 'online' ? '🟢 Online' : '⚫ Offline'),
          ]);
        },
      ),
      const SizedBox(height: 24),
    ])),
  );
}
class _StatPill extends StatelessWidget {
  final String label, value;
  const _StatPill({required this.label, required this.value});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.18))),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10.5, fontWeight: FontWeight.w500)),
    ]),
  );
}
class ProfileDialog extends StatelessWidget {
  final Map user;
  const ProfileDialog({super.key, required this.user});
  @override
  Widget build(BuildContext ctx) {
    final dark   = Theme.of(ctx).brightness == Brightness.dark;
    final online = user['status'] == 'online';
    return Dialog(
      backgroundColor: Colors.transparent,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.82, end: 1.0),
        duration: const Duration(milliseconds: 300), curve: Curves.easeOutBack,
        builder: (_, v, child) => Transform.scale(scale: v, child: child),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: dark ? Gx.d3 : Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Gx.violet.withOpacity(0.22)),
            boxShadow: Gx.glow2(Gx.violet),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Stack(alignment: Alignment.bottomRight, children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: Gx.gBrand, boxShadow: Gx.glow(Gx.violet, b: 22)),
                child: CircleAvatar(radius: 44, backgroundColor: Gx.d3,
                  backgroundImage: NetworkImage(user['pfp'] ?? ''), onBackgroundImageError: (_, __) {}),
              ),
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(color: online ? Gx.live : Gx.away, shape: BoxShape.circle,
                  border: Border.all(color: dark ? Gx.d3 : Colors.white, width: 2.5),
                  boxShadow: online ? Gx.glow(Gx.live, b: 8) : []),
              ),
            ]),
            const SizedBox(height: 16),
            Text(user['name'] ?? '', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 3),
            ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
              child: Text('@${user['username'] ?? ''}', style: const TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w600))),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: online ? Gx.live.withOpacity(0.12) : (dark ? Gx.d4 : Gx.l2), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 7, height: 7, decoration: BoxDecoration(color: online ? Gx.live : Gx.tx2, shape: BoxShape.circle)),
                const SizedBox(width: 5),
                Text(online ? 'Online' : 'Offline',
                  style: TextStyle(color: online ? Gx.live : (dark ? Gx.tx2 : Gx.tx2L), fontSize: 12, fontWeight: FontWeight.w600)),
              ]),
            ),
            if ((user['bio'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(user['bio'], textAlign: TextAlign.center, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13)),
            ],
            const SizedBox(height: 22),
            _GaxBtn(
              onTap: () { Navigator.pop(ctx); _gaxPush(ctx, ChatRoom(target: user)); },
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.chat_bubble_outline_rounded, size: 16, color: Colors.white), SizedBox(width: 8),
                Text('Send Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
enum FeedbackTag { bug, feature, feedback }
extension FeedbackTagExt on FeedbackTag {
  String get value => const ['bug', 'feature', 'feedback'][index];
  String get label => const ['🐛 Bug Report', '💡 Feature Request', '💬 Feedback'][index];
  Color  get color => const [Gx.rose, Gx.amber, Gx.mint][index];
}
Future<void> writeFeedbackTag({required String chatId, required String msgId, required FeedbackTag tag, required String senderUid}) async {
  try {
    await FirebaseDatabase.instance.ref('feedback_tags/$chatId/$msgId').set({
      'type': tag.value, 'uid': senderUid, 'ts': ServerValue.timestamp, 'resolved': false,
    });
  } catch (e) { debugPrint('FeedbackTag write: $e'); }
}
class ChatRoom extends StatefulWidget {
  final Map target;
  final FeedbackTag? initialFeedbackTag;
  const ChatRoom({super.key, required this.target, this.initialFeedbackTag});
  @override State<ChatRoom> createState() => _ChatState();
}
class _ChatState extends State<ChatRoom> with TickerProviderStateMixin {
  bool get dark => Theme.of(context).brightness == Brightness.dark;
  final _msgC  = TextEditingController();
  final _imgC  = TextEditingController();
  final _srcC  = TextEditingController();
  final _scroll = ScrollController();
  late final String chatId;
  final myId = FirebaseAuth.instance.currentUser!.uid;
  Timer? _typingTimer;
  late final _sendAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  Map? _replyMsg;
  bool _searching = false;
  String _srchQ = '';
  int _lastMsgCount = 0;
  Map? _pinMsg; String? _pinKey;
  bool _hasText = false;
  FeedbackTag? _pendingTag;
  @override
  void initState() {
    super.initState();
    final ids = [myId, widget.target['uid']]..sort();
    chatId = ids.join('_');
    _pendingTag = widget.initialFeedbackTag;
    final db = FirebaseDatabase.instance;
    db.ref('typing/$chatId/$myId').onDisconnect().set(false).catchError((e) => debugPrint('Typing dc: $e'));
    db.ref('chats/$chatId/unread/$myId').set(0).catchError((e) => debugPrint('Unread reset: $e'));
    _loadPin();
    _initChatMeta();
    _msgC.addListener(_msgListener);
  }
  void _msgListener() {
    if (!mounted) return;
    final has = _msgC.text.trim().isNotEmpty;
    if (has != _hasText) setState(() => _hasText = has);
  }
  @override
  void dispose() {
    _msgC.removeListener(_msgListener);
    _msgC.dispose(); _imgC.dispose(); _srcC.dispose(); _scroll.dispose();
    _typingTimer?.cancel(); _sendAc.dispose();
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((e) => debugPrint('Dispose typing: $e'));
    FirebaseDatabase.instance.ref('users/$myId/lastSeen').set(ServerValue.timestamp).catchError((e) => debugPrint('Dispose lastSeen: $e'));
    super.dispose();
  }
  void _loadPin() => FirebaseDatabase.instance.ref('chats/$chatId/pinned').get().then((s) {
    if (!mounted || s.value == null) return;
    final key = s.value.toString();
    FirebaseDatabase.instance.ref('messages/$chatId/$key').get().then((ms) {
      if (!mounted || ms.value == null || ms.value is! Map) return;
      setState(() { _pinKey = key; _pinMsg = Map.from(ms.value as Map); });
    });
  });
  void _onTyping(String v) {
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(true).catchError((e) => debugPrint('Typing: $e'));
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () =>
      FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((e) => debugPrint('Typing off: $e')));
  }
  void _toBottom() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 100)
        _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
    });
  }
  Future<void> _send() async {
    final txt = _msgC.text.trim();
    if (txt.isEmpty) return;
    HapticFeedback.lightImpact();
    _msgC.clear(); _sendAc.forward(from: 0);
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((e) => debugPrint('Send typing off: $e'));
    final payload = <String, dynamic>{
      'senderId': myId, 'text': txt, 'timestamp': ServerValue.timestamp, 'read': false, 'type': 'text',
    };
    if (_replyMsg != null) {
      payload['replyTo'] = {'text': _replyMsg!['text'], 'senderId': _replyMsg!['senderId'], 'type': _replyMsg!['type'] ?? 'text'};
      if (mounted) setState(() => _replyMsg = null);
    }
    final ref = await FirebaseDatabase.instance.ref('messages/$chatId').push().set(payload).then((_) =>
        FirebaseDatabase.instance.ref('messages/$chatId').limitToLast(1).get()).catchError((e) { debugPrint('Send: $e'); return null; });
    if (_pendingTag != null) {
      final lastSnap = await FirebaseDatabase.instance.ref('messages/$chatId').orderByKey().limitToLast(1).get();
      if (lastSnap.exists && lastSnap.value is Map) {
        final msgId = (lastSnap.value as Map).keys.last.toString();
        await writeFeedbackTag(chatId: chatId, msgId: msgId, tag: _pendingTag!, senderUid: myId);
      }
      if (mounted) setState(() => _pendingTag = null);
    }
    await _saveChatMeta('text', txt);
    if (!mounted) return;
    _toBottom();
  }
  Future<void> _sendImg() async {
    final url = _imgC.text.trim();
    if (url.isEmpty) return;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid image URL (http/https)'), behavior: SnackBarBehavior.floating));
      return;
    }
    _imgC.clear();
    if (!mounted) return;
    Navigator.pop(context);
    await FirebaseDatabase.instance.ref('messages/$chatId').push().set({
      'senderId': myId, 'text': url, 'timestamp': ServerValue.timestamp, 'read': false, 'type': 'image',
    }).catchError((e) => debugPrint('Send img: $e'));
    await _saveChatMeta('image', url);
    if (!mounted) return;
    _toBottom();
  }
  Future<void> _sendLink(String url) async {
    if (url.isEmpty) return;
    if (!url.startsWith('http://') && !url.startsWith('https://')) return;
    HapticFeedback.lightImpact();
    await FirebaseDatabase.instance.ref('messages/$chatId').push().set({
      'senderId': myId, 'text': url, 'timestamp': ServerValue.timestamp, 'read': false, 'type': 'link',
    }).catchError((e) => debugPrint('Send link: $e'));
    await _saveChatMeta('link', '🔗 $url');
    if (!mounted) return;
    _toBottom();
  }
  Future<void> _saveChatMeta(String type, String text) async {
    final raw     = type == 'image' ? '📷 Image' : type == 'link' ? '🔗 Link' : text.trim();
    final preview = raw.length > 80 ? '${raw.substring(0, 80)}…' : raw;
    final other   = widget.target['uid'].toString();
    await FirebaseDatabase.instance.ref().update({
      'chats/$chatId/members/$myId': true,
      'chats/$chatId/members/$other': true,
      'chats/$chatId/lastMsg': preview,
      'chats/$chatId/lastMsgType': type,
      'chats/$chatId/lastMsgSender': myId,
      'chats/$chatId/lastTs': ServerValue.timestamp,
      'chats/$chatId/updatedAt': ServerValue.timestamp,
    }).catchError((e) => debugPrint('Meta save: $e'));
    FirebaseDatabase.instance.ref('chats/$chatId/unread/$other')
        .set(ServerValue.increment(1)).catchError((e) => debugPrint('Unread inc: $e'));
  }
  void _initChatMeta() => FirebaseDatabase.instance.ref('chats/$chatId/members').update({
    myId: true, widget.target['uid'].toString(): true,
  }).catchError((e) => debugPrint('Init meta: $e'));
  void _quickReact(String key) {
    HapticFeedback.mediumImpact();
    FirebaseDatabase.instance.ref('messages/$chatId/$key/reactions/$myId').set('❤️').catchError((e) => debugPrint('React: $e'));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❤️ Reacted!'), behavior: SnackBarBehavior.floating, duration: Duration(milliseconds: 800)));
  }
  void _msgActions(String key, Map msg, bool isMe) {
    HapticFeedback.mediumImpact();
    const emojis = ['❤️', '😂', '👍', '😮', '😢', '🔥'];
    showModalBottomSheet(
      context: context, backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: emojis.map((e) => _TapScale(
            onTap: () {
              HapticFeedback.lightImpact();
              FirebaseDatabase.instance.ref('messages/$chatId/$key/reactions/$myId').set(e).catchError((err) => debugPrint('React: $err'));
              Navigator.pop(c);
            },
            child: Container(width: 50, height: 50,
              decoration: BoxDecoration(color: dark ? Gx.d5 : Gx.l2, borderRadius: BorderRadius.circular(14), border: Border.all(color: Gx.violet.withOpacity(0.15))),
              child: Center(child: Text(e, style: const TextStyle(fontSize: 24)))),
          )).toList()),
          const SizedBox(height: 8), Divider(color: dark ? Gx.divD : Gx.divL),
          _ActionRow(icon: Icons.reply_rounded, color: Gx.violet, label: 'Reply',
            onTap: () { setState(() => _replyMsg = msg); Navigator.pop(c); }, dark: dark),
          _ActionRow(icon: Icons.forward_rounded, color: Gx.mint, label: 'Forward',
            onTap: () { Navigator.pop(c); _showForwardSheet(msg); }, dark: dark),
          _ActionRow(icon: Icons.copy_rounded, color: Gx.cyan, label: 'Copy Text',
            onTap: () {
              Clipboard.setData(ClipboardData(text: msg['text'] ?? '')); Navigator.pop(c);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard'), behavior: SnackBarBehavior.floating, duration: Duration(seconds: 1)));
            }, dark: dark),
          if (isMe) _ActionRow(icon: Icons.push_pin_outlined, color: Gx.indigo, label: 'Pin Message',
            onTap: () {
              FirebaseDatabase.instance.ref('chats/$chatId/pinned').set(key).catchError((e) => debugPrint('Pin: $e'));
              setState(() { _pinKey = key; _pinMsg = msg; }); Navigator.pop(c);
            }, dark: dark),
          if (isMe) _ActionRow(icon: Icons.delete_outline_rounded, color: Gx.rose, label: 'Delete',
            onTap: () async {
              final dbRef = FirebaseDatabase.instance.ref;
              await dbRef('messages/$chatId/$key').remove().catchError((e) => debugPrint('Delete: $e'));
              if (_pinKey == key) {
                dbRef('chats/$chatId/pinned').remove().catchError((e) => debugPrint('Unpin: $e'));
                setState(() { _pinKey = null; _pinMsg = null; });
              }
              if (mounted) Navigator.pop(c);
              final lastCheck = await dbRef('messages/$chatId').orderByKey().limitToLast(1).get();
              if (lastCheck.exists && lastCheck.value != null) {
                final v = (lastCheck.value as Map).values.first as Map;
                final type = v['type'] ?? 'text'; final textStr = v['text'] ?? '';
                final t = type == 'image' ? '📷 Image' : type == 'link' ? '🔗 Link' : textStr;
                final preview = t.length > 80 ? '${t.substring(0, 80)}…' : t;
                await dbRef('chats/$chatId').update({'lastMsg': preview, 'lastMsgType': type, 'lastMsgSender': v['senderId'], 'lastTs': v['timestamp']})
                    .catchError((e) => debugPrint('Meta update: $e'));
              } else {
                await dbRef('chats/$chatId').update({'lastMsg': 'No messages', 'lastMsgType': 'text', 'lastMsgSender': ''})
                    .catchError((e) => debugPrint('Meta clear: $e'));
              }
            }, dark: dark),
        ]),
      )),
    );
  }
  void _chatMoreMenu() {
    showModalBottomSheet(
      context: context, backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 8),
          _ActionRow(icon: Icons.person_outline_rounded, color: Gx.violet, label: 'View Profile',
            onTap: () { Navigator.pop(c); showDialog(context: context, builder: (_) => ProfileDialog(user: widget.target)); }, dark: dark),
          _ActionRow(icon: Icons.push_pin_outlined, color: Gx.indigo,
            label: _pinMsg != null ? 'Unpin Message' : 'No Pinned Message',
            onTap: _pinMsg != null ? () {
              FirebaseDatabase.instance.ref('chats/$chatId/pinned').remove().catchError((e) => debugPrint('Unpin: $e'));
              setState(() { _pinKey = null; _pinMsg = null; }); Navigator.pop(c);
            } : null, dark: dark),
          _ActionRow(icon: Icons.cleaning_services_outlined, color: Gx.amber, label: 'Clear Chat',
            onTap: () {
              Navigator.pop(c);
              _gaxDialog(context, title: 'Clear Chat', body: 'Delete all messages? This cannot be undone.',
                confirmLabel: 'Clear', confirmClr: Gx.rose,
                onConfirm: () {
                  FirebaseDatabase.instance.ref('messages/$chatId').remove().catchError((e) => debugPrint('Clear: $e'));
                  FirebaseDatabase.instance.ref('chats/$chatId').update({'lastMsg': '', 'lastMsgType': 'text', 'lastMsgSender': ''})
                      .catchError((e) => debugPrint('Clear meta: $e'));
                  Navigator.pop(context);
                });
            }, dark: dark),
          _ActionRow(icon: Icons.block_rounded, color: Gx.rose, label: 'Unfriend & Remove',
            onTap: () {
              Navigator.pop(c);
              _gaxDialog(context, title: 'Unfriend', body: 'Remove ${widget.target['name']} from friends?',
                confirmLabel: 'Remove', confirmClr: Gx.rose,
                onConfirm: () {
                  final other = widget.target['uid'].toString();
                  FirebaseDatabase.instance.ref().update({
                    'users/$myId/friends/$other': null,
                    'users/$other/friends/$myId': null,
                  }).catchError(_showError(context, 'Failed to unfriend'));
                  Navigator.pop(context); Navigator.pop(context);
                });
            }, dark: dark),
        ]),
      )),
    );
  }
  void _linkSheet() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => _LinkSheetUI(onSend: (url) { Navigator.pop(c); _sendLink(url); }),
    );
  }
  void _imgSheet() {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom + 20, left: 20, right: 20, top: 14),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 14),
          Text('Share Image', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          _GaxField(ctrl: _imgC, hint: 'Paste image URL…', icon: Icons.link_rounded, dark: dark),
          const SizedBox(height: 16),
          _GaxBtn(onTap: _sendImg, child: const Text('Send Image', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
        ]),
      ),
    );
  }
  void _emojiSheet() {
    const emojis = ['😀','😂','🥰','😎','🤔','😭','🙏','🔥','💯','❤️','💜','💙','✨','🎉','👏','👀','😅','🤣','😍','🥺','😤','😴','🤗','😇','💪','🫡','🙌','🫶','🤝','👋','✌️','🤙','🍕','🎮','🚀','💎','🏆','🎯','⚡','🌟'];
    showModalBottomSheet(
      context: context, backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 10),
          Text('Emoji', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(spacing: 6, runSpacing: 6, children: emojis.map((e) => _TapScale(
            onTap: () {
              Navigator.pop(c);
              _msgC.text = _msgC.text + e;
              _msgC.selection = TextSelection.collapsed(offset: _msgC.text.length);
            },
            child: Container(width: 46, height: 46,
              decoration: BoxDecoration(color: dark ? Gx.d5 : Gx.l2, borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(e, style: const TextStyle(fontSize: 22)))),
          )).toList()),
          const SizedBox(height: 8),
        ]),
      )),
    );
  }
  void _showForwardSheet(Map msg) {
    final fwdText = msg['text'] ?? '';
    final fwdType = msg['type'] ?? 'text';
    showModalBottomSheet(
      context: context, backgroundColor: dark ? Gx.d4 : Colors.white, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 10),
          Text('Forward to…', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          SizedBox(height: 280, child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
            builder: (_, snap) {
              if (!snap.hasData || snap.data!.snapshot.value == null)
                return Center(child: Text('No friends yet', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L)));
              final ids = (snap.data!.snapshot.value as Map? ?? {}).keys.map((k) => k.toString()).toList();
              return ListView.builder(itemCount: ids.length, itemBuilder: (_, i) => StreamBuilder(
                stream: FirebaseDatabase.instance.ref('users/${ids[i]}').onValue,
                builder: (_, uSnap) {
                  if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
                  final u = Map<String, dynamic>.from(uSnap.data!.snapshot.value as Map? ?? {});
                  final toChatId = ([myId, ids[i]]..sort()).join('_');
                  return _TapScale(onTap: () async {
                    HapticFeedback.mediumImpact();
                    await FirebaseDatabase.instance.ref('messages/$toChatId').push().set({
                      'senderId': myId, 'text': fwdText, 'timestamp': ServerValue.timestamp,
                      'read': false, 'type': fwdType, 'forwarded': true,
                    }).catchError((e) => debugPrint('Fwd: $e'));
                    await FirebaseDatabase.instance.ref('chats/$toChatId/members').update({myId: true, ids[i]: true}).catchError((e) => debugPrint('Fwd mem: $e'));
                    await FirebaseDatabase.instance.ref('chats/$toChatId').update({
                      'lastMsg': fwdType == 'image' ? '📷 Image' : (fwdText.length > 80 ? '${fwdText.substring(0, 80)}…' : fwdText),
                      'lastMsgType': fwdType, 'lastMsgSender': myId,
                      'lastTs': ServerValue.timestamp, 'updatedAt': ServerValue.timestamp,
                    }).catchError((e) => debugPrint('Fwd meta: $e'));
                    await FirebaseDatabase.instance.ref('chats/$toChatId/unread/${ids[i]}')
                        .set(ServerValue.increment(1)).catchError((e) => debugPrint('Fwd unread: $e'));
                    if (mounted) Navigator.pop(c);
                    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Forwarded to ${u['name']}'), behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)));
                  }, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Row(children: [
                      _Avi(pfp: u['pfp'] ?? '', online: u['status'] == 'online', radius: 22), const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(u['name'] ?? '', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontWeight: FontWeight.w700, fontSize: 14)),
                        Text('@${u['username'] ?? ''}', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12)),
                      ])),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(20)),
                        child: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
                    ])));
                },
              ));
            },
          )),
        ]),
      )),
    );
  }
  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: dark ? Gx.d1 : const Color(0xFFEDEEFA),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: dark ? Gx.d3 : Gx.violet,
        leadingWidth: 30, titleSpacing: 0,
        title: GestureDetector(
          onTap: () => showDialog(context: ctx, builder: (_) => ProfileDialog(user: widget.target)),
          child: Row(children: [
            _Avi(pfp: widget.target['pfp'] ?? '', online: widget.target['status'] == 'online', radius: 20),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.target['name'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
              StreamBuilder(
                stream: FirebaseDatabase.instance.ref('typing/$chatId/${widget.target['uid']}').onValue,
                builder: (_, tSnap) {
                  if (tSnap.hasData && tSnap.data!.snapshot.value == true)
                    return Row(children: [
                      const Text('typing', style: TextStyle(color: Colors.white60, fontSize: 11, fontStyle: FontStyle.italic)),
                      const SizedBox(width: 4), _DotsLoader(small: true, color: Colors.white60),
                    ]);
                  return StreamBuilder(
                    stream: FirebaseDatabase.instance.ref('users/${widget.target['uid']}').onValue,
                    builder: (_, stSnap) {
                      final d = stSnap.hasData && stSnap.data!.snapshot.value != null
                          ? Map<String, dynamic>.from(stSnap.data!.snapshot.value as Map? ?? {}) : <String, dynamic>{};
                      final online = d['status']?.toString() == 'online';
                      String subtitle;
                      if (online) {
                        subtitle = '● online';
                      } else {
                        final lsRaw = d['lastSeen'];
                        if (lsRaw != null) {
                          final lsDt = DateTime.fromMillisecondsSinceEpoch(lsRaw is int ? lsRaw : int.tryParse(lsRaw.toString()) ?? 0);
                          final diff = DateTime.now().difference(lsDt);
                          if (diff.inMinutes < 1)       subtitle = 'last seen just now';
                          else if (diff.inMinutes < 60) subtitle = 'last seen ${diff.inMinutes}m ago';
                          else if (diff.inHours < 24)   subtitle = 'last seen ${diff.inHours}h ago';
                          else if (diff.inDays == 1)    subtitle = 'last seen yesterday';
                          else                           subtitle = 'last seen ${diff.inDays}d ago';
                        } else { subtitle = 'offline'; }
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(subtitle, key: ValueKey(subtitle),
                          style: TextStyle(color: online ? Gx.live.withOpacity(0.9) : Colors.white54, fontSize: 11.5)),
                      );
                    },
                  );
                },
              ),
            ])),
          ]),
        ),
        actions: [
          if (_searching) SizedBox(width: 160, child: TextField(
            controller: _srcC, autofocus: true, onChanged: (v) => setState(() => _srchQ = v.toLowerCase()),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: const InputDecoration(hintText: 'Search…', hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none, filled: false, contentPadding: EdgeInsets.symmetric(vertical: 8)),
          )),
          IconButton(
            icon: AnimatedSwitcher(duration: const Duration(milliseconds: 200),
              child: Icon(_searching ? Icons.close_rounded : Icons.search_rounded, key: ValueKey(_searching), color: Colors.white, size: 21)),
            onPressed: () => setState(() { _searching = !_searching; _srchQ = ''; _srcC.clear(); }),
          ),
          IconButton(icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 21), onPressed: _chatMoreMenu),
        ],
      ),
      body: Column(children: [
        if (_pinMsg != null) _PinBanner(
          text: _pinMsg!['type'] == 'image' ? '📷 Image' : (_pinMsg!['text'] ?? ''),
          onDismiss: () {
            FirebaseDatabase.instance.ref('chats/$chatId/pinned').remove().catchError((e) => debugPrint('Pin dismiss: $e'));
            setState(() { _pinKey = null; _pinMsg = null; });
          }, dark: dark),
        Expanded(child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('messages/$chatId').limitToLast(100).onValue,
          builder: (ctx, snap) {
            if (!snap.hasData || snap.data!.snapshot.value == null)
              return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600), curve: Curves.elasticOut,
                  builder: (_, v, child) => Transform.scale(scale: v, child: child),
                  child: const Text('⚡', style: TextStyle(fontSize: 52))),
                const SizedBox(height: 12),
                Text('Start chatting with ${widget.target['name']}', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 14)),
              ]));
            final rawMsgs = snap.data!.snapshot.value as Map? ?? {};
            var msgs = rawMsgs.entries.where((e) => e.value is Map).map((e) => {
              '_key': e.key.toString(), ...Map<String, dynamic>.from(e.value as Map),
            }).toList();
            msgs.sort((a, b) => ((a['timestamp'] ?? 0) as num).compareTo((b['timestamp'] ?? 0) as num));
            if (_srchQ.isNotEmpty) msgs = msgs.where((m) => (m['text'] ?? '').toString().toLowerCase().contains(_srchQ)).toList();
            if (msgs.length != _lastMsgCount) { _lastMsgCount = msgs.length; _toBottom(); }
            return ListView.builder(
              controller: _scroll,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: msgs.length,
              itemBuilder: (ctx, i) {
                final m  = msgs[i]; final isMe = m['senderId'] == myId;
                final ts = m['timestamp'] is int ? DateTime.fromMillisecondsSinceEpoch(m['timestamp'] as int) : DateTime.now();
                final prevTs = i > 0 && msgs[i-1]['timestamp'] is int ? DateTime.fromMillisecondsSinceEpoch(msgs[i-1]['timestamp'] as int) : null;
                return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  if (prevTs == null || !_sameDay(prevTs, ts)) _DateChip(ts, dark),
                  _BubbleEntry(isMe: isMe, child: _BubbleWidget(msg: m, isMe: isMe, ts: ts, myId: myId, dark: dark,
                    onLongPress: () => _msgActions(m['_key'] as String, m, isMe),
                    onDoubleTap: () => _quickReact(m['_key'] as String))),
                ]);
              },
            );
          },
        )),
        if (_replyMsg != null) _ReplyBar(msg: _replyMsg!, myId: myId, onCancel: () => setState(() => _replyMsg = null), dark: dark),
        if (_pendingTag != null) TagBanner(tag: _pendingTag!, onClear: () => setState(() => _pendingTag = null)),
        _MsgInput(ctrl: _msgC, hasText: _hasText, dark: dark, sendAc: _sendAc, onTyping: _onTyping, onSend: _send, onImage: _imgSheet, onLink: _linkSheet, onEmoji: _emojiSheet),
      ]),
    );
  }
}
class _LinkSheetUI extends StatefulWidget {
  final ValueChanged<String> onSend;
  const _LinkSheetUI({required this.onSend});
  @override State<_LinkSheetUI> createState() => _LinkSheetUIState();
}
class _LinkSheetUIState extends State<_LinkSheetUI> {
  final _lctrl = TextEditingController();
  @override void dispose() { _lctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext c) {
    final dark = Theme.of(c).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom + 20, left: 20, right: 20, top: 14),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _SheetHandle(), const SizedBox(height: 14),
        Text('Share a Link', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        _GaxField(ctrl: _lctrl, hint: 'Paste URL here…', icon: Icons.link_rounded, type: TextInputType.url, dark: dark),
        const SizedBox(height: 16),
        _GaxBtn(onTap: () {
          final url = _lctrl.text.trim();
          if (url.isEmpty) return; // FIX: guard
          widget.onSend(url);
        }, child: const Text('Send Link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
      ]),
    );
  }
}
class TagBanner extends StatelessWidget {
  final FeedbackTag tag;
  final VoidCallback onClear;
  const TagBanner({super.key, required this.tag, required this.onClear});
  @override
  Widget build(BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: tag.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tag.color.withOpacity(0.35)),
      ),
      child: Row(children: [
        Icon(Icons.label_outline_rounded, size: 15, color: tag.color),
        const SizedBox(width: 8),
        Expanded(child: Text('Sending as: ${tag.label}',
          style: TextStyle(color: tag.color, fontSize: 12.5, fontWeight: FontWeight.w600))),
        GestureDetector(
          onTap: onClear,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: tag.color.withOpacity(0.15), shape: BoxShape.circle),
            child: Icon(Icons.close_rounded, size: 13, color: tag.color),
          ),
        ),
      ]),
    );
  }
}
class _BubbleEntry extends StatefulWidget {
  final Widget child; final bool isMe;
  const _BubbleEntry({required this.child, required this.isMe});
  @override State<_BubbleEntry> createState() => _BubbleEntryState();
}
class _BubbleEntryState extends State<_BubbleEntry> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 280))..forward();
  late final _fade  = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  late final _slide = Tween<Offset>(begin: Offset(widget.isMe ? 0.25 : -0.25, 0), end: Offset.zero)
      .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
  @override void dispose() { _ac.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) => FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: widget.child));
}
class _BubbleWidget extends StatelessWidget {
  final Map msg; final bool isMe, dark; final DateTime ts;
  final String myId; final VoidCallback onLongPress, onDoubleTap;
  const _BubbleWidget({required this.msg, required this.isMe, required this.dark,
    required this.ts, required this.myId, required this.onLongPress, required this.onDoubleTap});
  @override
  Widget build(BuildContext ctx) {
    final bg   = isMe ? (dark ? Gx.sentD : Gx.sentL) : (dark ? Gx.recvD : Gx.recvL);
    final tx   = isMe ? (dark ? Gx.tx1 : const Color(0xFF1A0E60)) : (dark ? Gx.tx1 : Gx.tx1L);
    final tsTx = isMe ? (dark ? Gx.tx2 : const Color(0xFF6050A0)) : (dark ? Gx.tx2 : Gx.tx2L);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress, onDoubleTap: onDoubleTap,
        child: RepaintBoundary(child: Container(
          margin: EdgeInsets.only(bottom: 3, top: 3, left: isMe ? 64 : 0, right: isMe ? 0 : 64),
          child: Column(crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18), topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isMe ? 18 : 5), bottomRight: Radius.circular(isMe ? 5 : 18),
                ),
                boxShadow: Gx.softShadow(dark),
                border: isMe ? Border(left: BorderSide(color: Gx.violet.withOpacity(dark ? 0.55 : 0.35), width: 2.5)) : null,
              ),
              child: _BubbleBody(msg: msg, isMe: isMe, tx: tx, tsTx: tsTx, myId: myId, dark: dark),
            ),
            if (msg['reactions'] is Map) _Reactions(r: Map<String, dynamic>.from(msg['reactions'] as Map)),
          ]),
        )),
      ),
    );
  }
}
class _BubbleBody extends StatelessWidget {
  final Map msg; final bool isMe, dark; final Color tx, tsTx; final String myId;
  const _BubbleBody({required this.msg, required this.isMe, required this.dark,
    required this.tx, required this.tsTx, required this.myId});
  @override
  Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isMe ? 16 : 5), bottomRight: Radius.circular(isMe ? 5 : 16),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (msg['replyTo'] is Map) _ReplyPreview(reply: Map<String, dynamic>.from(msg['replyTo'] as Map), myId: myId, isMe: isMe, dark: dark),
      if (msg['forwarded'] == true)
        Padding(padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.forward_rounded, size: 12, color: isMe ? Colors.white54 : Gx.tx2), const SizedBox(width: 3),
            Text('Forwarded', style: TextStyle(fontSize: 10.5, color: isMe ? Colors.white54 : Gx.tx2, fontStyle: FontStyle.italic)),
          ])),
      if (msg['type'] == 'image')
        _ImgContent(url: msg['text'])
      else if (msg['type'] == 'link')
        Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
          child: _LinkEmbed(url: msg['text'] ?? '', isMe: isMe, dark: dark))
      else
        Padding(padding: const EdgeInsets.fromLTRB(13, 10, 13, 4),
          child: _AutoContent(text: msg['text'] ?? '', tx: tx, isMe: isMe, dark: dark)),
      Padding(padding: const EdgeInsets.fromLTRB(12, 0, 10, 7),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(msg['timestamp'] is int ? msg['timestamp'] as int : 0)),
            style: TextStyle(fontSize: 10.5, color: tsTx)),
          if (isMe) ...[
            const SizedBox(width: 4),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Icon(msg['read'] == true ? Icons.done_all_rounded : Icons.done_rounded,
                key: ValueKey(msg['read']), size: 14,
                color: msg['read'] == true ? Gx.readClr : Gx.tx2),
            ),
          ],
        ])),
    ]),
  );
}
class _ReplyPreview extends StatelessWidget {
  final Map reply; final String myId; final bool isMe, dark;
  const _ReplyPreview({required this.reply, required this.myId, required this.isMe, required this.dark});
  @override
  Widget build(BuildContext ctx) => Container(
    margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
    padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
    decoration: BoxDecoration(
      color: isMe ? Colors.black.withOpacity(0.18) : (dark ? Gx.d5 : Gx.l3),
      borderRadius: BorderRadius.circular(10),
      border: const Border(left: BorderSide(color: Gx.violet, width: 3)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(reply['senderId'] == myId ? 'You' : 'Them',
        style: const TextStyle(color: Gx.violet, fontSize: 11.5, fontWeight: FontWeight.w700)),
      Builder(builder: (ctx) {
        final rt = reply['text']?.toString() ?? '';
        final preview = reply['type'] == 'image' ? '📷 Image'
            : reply['type'] == 'link' ? '🔗 Link'
            : (rt.startsWith('http') || rt.startsWith('www')) ? '🔗 ${rt.length > 35 ? '${rt.substring(0, 35)}…' : rt}'
            : rt;
        return Text(preview, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: TextStyle(color: isMe ? Colors.white70 : (dark ? Gx.tx2 : Gx.tx2L), fontSize: 12.5));
      }),
    ]),
  );
}
class _ImgContent extends StatelessWidget {
  final String url;
  const _ImgContent({required this.url});
  @override
  Widget build(BuildContext ctx) => ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    child: Image.network(url, width: 230, height: 195, fit: BoxFit.cover, cacheWidth: 460,
      loadingBuilder: (c, ch, p) => p == null ? ch : const SizedBox(width: 230, height: 195, child: Center(child: _GaxSpinner())),
      errorBuilder: (c, e, s) => const SizedBox(width: 230, height: 80, child: Center(child: Icon(Icons.broken_image_outlined, color: Gx.tx2)))),
  );
}
class _Reactions extends StatelessWidget {
  final Map r;
  const _Reactions({required this.r});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    final counts = <String, int>{};
    r.forEach((_, v) { final e = v?.toString() ?? '?'; counts[e] = (counts[e] ?? 0) + 1; });
    return Padding(padding: const EdgeInsets.only(top: 3),
      child: Wrap(spacing: 4, runSpacing: 4, children: counts.entries.map((e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: dark ? Gx.d5 : Gx.l2, borderRadius: BorderRadius.circular(12), border: Border.all(color: Gx.violet.withOpacity(0.22))),
        child: Text('${e.key} ${e.value}', style: const TextStyle(fontSize: 12)),
      )).toList()));
  }
}
class _PinBanner extends StatelessWidget {
  final String text; final VoidCallback onDismiss; final bool dark;
  const _PinBanner({required this.text, required this.onDismiss, required this.dark});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
    decoration: BoxDecoration(
      color: dark ? Gx.d4 : Gx.l2,
      border: Border(bottom: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6), left: const BorderSide(color: Gx.violet, width: 3)),
    ),
    child: Row(children: [
      ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r), child: const Icon(Icons.push_pin_rounded, size: 13, color: Colors.white)),
      const SizedBox(width: 8),
      Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5))),
      GestureDetector(onTap: onDismiss, child: Icon(Icons.close_rounded, size: 15, color: dark ? Gx.tx2 : Gx.tx2L)),
    ]),
  );
}
class _ReplyBar extends StatelessWidget {
  final Map msg; final String myId; final VoidCallback onCancel; final bool dark;
  const _ReplyBar({required this.msg, required this.myId, required this.onCancel, required this.dark});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.fromLTRB(16, 9, 8, 9),
    decoration: BoxDecoration(color: dark ? Gx.d3 : Gx.l2, border: Border(top: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6))),
    child: Row(children: [
      Container(width: 3, height: 36, margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(2))),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(msg['senderId'] == myId ? 'Replying to yourself' : 'Replying',
          style: const TextStyle(color: Gx.violet, fontSize: 12, fontWeight: FontWeight.w700)),
        Builder(builder: (ctx) {
          final pt = msg['text']?.toString() ?? '';
          final ap = msg['type'] == 'image' ? '📷 Image'
              : msg['type'] == 'link' ? '🔗 Link'
              : (pt.startsWith('http') || pt.startsWith('www')) ? '🔗 Link' : pt;
          return Text(ap, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12));
        }),
      ])),
      IconButton(icon: Icon(Icons.close_rounded, size: 18, color: dark ? Gx.tx2 : Gx.tx2L), onPressed: onCancel),
    ]),
  );
}
class _MsgInput extends StatelessWidget {
  final TextEditingController ctrl;
  final bool hasText, dark;
  final AnimationController sendAc;
  final ValueChanged<String> onTyping;
  final VoidCallback onSend, onImage, onLink, onEmoji;
  const _MsgInput({required this.ctrl, required this.hasText, required this.dark,
    required this.sendAc, required this.onTyping, required this.onSend,
    required this.onImage, required this.onLink, required this.onEmoji});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
    decoration: BoxDecoration(color: dark ? Gx.d2 : Colors.white, border: Border(top: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6))),
    child: SafeArea(top: false, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      _iconBtn(Icons.image_outlined, onImage, dark),
      const SizedBox(width: 6),
      _iconBtn(null, onEmoji, dark, emoji: '😊'),
      const SizedBox(width: 6),
      _iconBtn(Icons.link_rounded, onLink, dark),
      const SizedBox(width: 8),
      Expanded(child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        decoration: BoxDecoration(color: dark ? Gx.d4 : Gx.l2, borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Gx.violet.withOpacity(dark ? 0.20 : 0.15))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const SizedBox(width: 14),
          Expanded(child: TextField(
            controller: ctrl, onChanged: onTyping, maxLines: 5, minLines: 1,
            style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 15),
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(hintText: 'Message…', border: InputBorder.none,
              enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, filled: false,
              contentPadding: const EdgeInsets.symmetric(vertical: 11),
              hintStyle: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L)),
          )),
          const SizedBox(width: 10),
        ]),
      )),
      const SizedBox(width: 8),
      AnimatedBuilder(
        animation: sendAc,
        builder: (_, child) {
          final b = sendAc.value < 0.5 ? sendAc.value * 2 : (1 - sendAc.value) * 2;
          return Transform.scale(scale: 1.0 + b * 0.22, child: child);
        },
        child: _TapScale(
          onTap: hasText ? onSend : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 230), curve: Curves.easeOutBack,
            width: hasText ? 46 : 44, height: hasText ? 46 : 44,
            decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: hasText ? Gx.gBrand : null,
              color: hasText ? null : (dark ? Gx.d4 : Gx.l2),
              boxShadow: hasText ? Gx.glow(Gx.violet, b: 16) : []),
            child: Icon(hasText ? Icons.send_rounded : Icons.mic_rounded, size: 20,
              color: hasText ? Colors.white : (dark ? Gx.tx2 : Gx.tx2L)),
          ),
        ),
      ),
    ])),
  );
  Widget _iconBtn(IconData? icon, VoidCallback onTap, bool dark, {String? emoji}) => _TapScale(
    onTap: onTap,
    child: Container(
      width: 40, height: 40, margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(shape: BoxShape.circle, color: dark ? Gx.d4 : Gx.l2,
        border: Border.all(color: dark ? Gx.divD : Gx.divL, width: 0.8)),
      child: emoji != null ? Center(child: Text(emoji, style: const TextStyle(fontSize: 20))) : Icon(icon, size: 19, color: dark ? Gx.tx2 : Gx.tx2L),
    ),
  );
}
class _DateChip extends StatelessWidget {
  final DateTime dt; final bool dark;
  const _DateChip(this.dt, this.dark);
  String _label() {
    final n = DateTime.now();
    if (_sd(dt, n)) return 'Today';
    if (_sd(dt, n.subtract(const Duration(days: 1)))) return 'Yesterday';
    return DateFormat('MMMM d, yyyy').format(dt);
  }
  bool _sd(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  @override
  Widget build(BuildContext ctx) => Center(child: Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    decoration: BoxDecoration(
      color: dark ? Gx.d5.withOpacity(0.9) : Gx.l3, borderRadius: BorderRadius.circular(20),
      border: Border.all(color: dark ? Gx.violet.withOpacity(0.18) : Gx.divL)),
    child: Text(_label(), style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11.5, fontWeight: FontWeight.w500)),
  ));
}
class _ActionRow extends StatelessWidget {
  final IconData icon; final Color color; final String label; final VoidCallback? onTap; final bool dark;
  const _ActionRow({required this.icon, required this.color, required this.label, this.onTap, required this.dark});
  @override
  Widget build(BuildContext ctx) => ListTile(
    dense: true, onTap: onTap,
    leading: Container(width: 32, height: 32,
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: color, size: 17)),
    title: Text(label, style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 14, fontWeight: FontWeight.w500)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
class _AutoContent extends StatelessWidget {
  final String text; final Color tx; final bool isMe, dark;
  const _AutoContent({required this.text, required this.tx, required this.isMe, required this.dark});
  static const _imgExts = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.svg'];
  static final _urlRx = RegExp(r'(https?://[^\s]+|www\.[^\s]+)', caseSensitive: false);
  bool _isImg(String url) => _imgExts.any((e) => url.toLowerCase().split('?').first.endsWith(e));
  String _scheme(String url) => url.startsWith('http') ? url : 'https://$url';
  @override
  Widget build(BuildContext ctx) {
    if (!_urlRx.hasMatch(text)) return Text(text, style: TextStyle(color: tx, fontSize: 15.5, height: 1.45));
    final segs = <_Segment>[];
    int last = 0;
    for (final m in _urlRx.allMatches(text)) {
      if (m.start > last) segs.add(_Segment(text.substring(last, m.start), _SegT.text));
      final url = _scheme(m.group(0)!);
      segs.add(_Segment(url, _isImg(url) ? _SegT.image : _SegT.link));
      last = m.end;
    }
    if (last < text.length) segs.add(_Segment(text.substring(last), _SegT.text));
    if (segs.length == 1 && segs.first.type == _SegT.image) return _AutoImageEmbed(url: segs.first.content, isMe: isMe, dark: dark);
    if (segs.length == 1 && segs.first.type == _SegT.link)  return _LinkEmbed(url: segs.first.content, isMe: isMe, dark: dark);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: segs.map((s) {
      switch (s.type) {
        case _SegT.text:
          final t = s.content.trim(); if (t.isEmpty) return const SizedBox.shrink();
          return Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(t, style: TextStyle(color: tx, fontSize: 15.5, height: 1.45)));
        case _SegT.image: return Padding(padding: const EdgeInsets.only(bottom: 6), child: _AutoImageEmbed(url: s.content, isMe: isMe, dark: dark));
        case _SegT.link:  return Padding(padding: const EdgeInsets.only(bottom: 6), child: _LinkEmbed(url: s.content, isMe: isMe, dark: dark));
      }
    }).toList());
  }
}
enum _SegT { text, image, link }
class _Segment { final String content; final _SegT type; const _Segment(this.content, this.type); }
class _AutoImageEmbed extends StatelessWidget {
  final String url; final bool isMe, dark;
  const _AutoImageEmbed({required this.url, required this.isMe, required this.dark});
  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTap: () => _openUrl(url),
    child: ClipRRect(borderRadius: BorderRadius.circular(12),
      child: Stack(alignment: Alignment.bottomLeft, children: [
        Image.network(url, width: 220, height: 180, fit: BoxFit.cover, cacheWidth: 440,
          loadingBuilder: (c, ch, p) => p == null ? ch : Container(width: 220, height: 180,
            decoration: BoxDecoration(color: isMe ? Colors.white.withOpacity(0.08) : (dark ? Gx.d4 : Gx.l2), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [_GaxSpinner(), const SizedBox(height: 6), Text('Loading…', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11))]))),
          errorBuilder: (c, e, s) => Container(width: 220, height: 70,
            decoration: BoxDecoration(color: isMe ? Colors.white.withOpacity(0.08) : (dark ? Gx.d4 : Gx.l2), borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.broken_image_outlined, color: Gx.tx2, size: 26), const SizedBox(height: 4),
              Text('Could not load image', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11)),
            ]))),
        Container(margin: const EdgeInsets.all(5), padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.45), borderRadius: BorderRadius.circular(6)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.auto_awesome_rounded, size: 10, color: Colors.white70), SizedBox(width: 3),
            Text('Auto', style: TextStyle(color: Colors.white70, fontSize: 9.5, fontWeight: FontWeight.w600)),
          ])),
      ])),
  );
}
class _LinkEmbed extends StatelessWidget {
  final String url; final bool isMe, dark;
  const _LinkEmbed({required this.url, required this.isMe, required this.dark});
  String get _domain { try { return Uri.parse(url).host.replaceFirst('www.', ''); } catch (_) { return url; } }
  @override
  Widget build(BuildContext ctx) {
    final bubbleBg = isMe ? Colors.white.withOpacity(0.12) : (dark ? Gx.d3 : Gx.l2);
    final tx2 = isMe ? Colors.white70 : (dark ? Gx.tx2 : Gx.tx2L);
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240), margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(color: bubbleBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: Gx.violet.withOpacity(0.3))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Gx.violet.withOpacity(0.25), Gx.cyan.withOpacity(0.10)]),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12))),
            child: Row(children: [
              const Icon(Icons.link_rounded, size: 14, color: Gx.violet), const SizedBox(width: 6),
              Expanded(child: Text(_domain, style: const TextStyle(fontSize: 11, color: Gx.violet, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis)),
            ])),
          Padding(padding: const EdgeInsets.fromLTRB(10, 7, 10, 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(url, style: TextStyle(fontSize: 12, color: tx2, decoration: TextDecoration.underline, decorationColor: tx2), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(8)),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.open_in_new_rounded, size: 11, color: Colors.white), SizedBox(width: 4),
                Text('Tap to open', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
              ])),
          ])),
        ]),
      ),
    );
  }
}
class _AnimatedListItem extends StatefulWidget {
  final Widget child; final int index;
  const _AnimatedListItem({required this.child, required this.index});
  @override State<_AnimatedListItem> createState() => _AnimatedListItemState();
}
class _AnimatedListItemState extends State<_AnimatedListItem> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 340))..forward();
  late final _fade  = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  late final _slide = Tween<Offset>(begin: const Offset(0, 0.13), end: Offset.zero).animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
  @override void dispose() { _ac.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) => FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: widget.child));
}
class _TapScale extends StatefulWidget {
  final Widget child; final VoidCallback? onTap;
  const _TapScale({required this.child, this.onTap});
  @override State<_TapScale> createState() => _TapScaleState();
}
class _TapScaleState extends State<_TapScale> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 90), lowerBound: 0.93, upperBound: 1.0)..value = 1.0;
  @override void dispose() { _ac.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) => GestureDetector(
    onTapDown: (_) => _ac.reverse(),
    onTapUp:   (_) { _ac.forward(); widget.onTap?.call(); },
    onTapCancel: () => _ac.forward(),
    child: ScaleTransition(scale: _ac, child: widget.child),
  );
}
class _DotsLoader extends StatefulWidget {
  final bool small; final Color? color;
  const _DotsLoader({this.small = false, this.color});
  @override State<_DotsLoader> createState() => _DotsLoaderState();
}
class _DotsLoaderState extends State<_DotsLoader> with TickerProviderStateMixin {
  late final List<AnimationController> _acs = List.generate(3, (i) =>
    AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat(reverse: true));
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 3; i++) Future.delayed(Duration(milliseconds: i * 160), () { if (mounted) _acs[i].forward(); });
  }
  @override void dispose() { for (final ac in _acs) ac.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) {
    final sz  = widget.small ? 4.0 : 7.0;
    final clr = widget.color ?? Gx.violet;
    return Row(mainAxisSize: MainAxisSize.min, children: List.generate(3, (i) => Padding(
      padding: EdgeInsets.symmetric(horizontal: sz * 0.5),
      child: AnimatedBuilder(animation: _acs[i], builder: (_, __) => Transform.translate(
        offset: Offset(0, -3.5 * _acs[i].value),
        child: Container(width: sz, height: sz, decoration: BoxDecoration(color: clr, shape: BoxShape.circle)),
      )),
    )));
  }
}
class _Avi extends StatelessWidget {
  final String pfp; final bool online; final double radius;
  const _Avi({required this.pfp, required this.online, required this.radius});
  @override
  Widget build(BuildContext ctx) {
    final bg      = Theme.of(ctx).scaffoldBackgroundColor;
    final hasPfp  = pfp.isNotEmpty && (pfp.startsWith('http://') || pfp.startsWith('https://'));
    final imgProv = hasPfp ? NetworkImage(pfp) as ImageProvider : null;
    final fallback = Icon(Icons.person_rounded, size: radius * 0.9, color: Gx.tx2);
    return Stack(clipBehavior: Clip.none, children: [
      if (online) Container(
        width: radius * 2 + 4, height: radius * 2 + 4,
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: Gx.gBrand, boxShadow: Gx.glow(Gx.violet, b: 10, s: -2)),
        child: Padding(padding: const EdgeInsets.all(2),
          child: CircleAvatar(radius: radius, backgroundColor: Gx.d3,
            backgroundImage: imgProv, onBackgroundImageError: (_, __) {},
            child: imgProv == null ? fallback : null)),
      ) else CircleAvatar(radius: radius, backgroundColor: Gx.d3,
        backgroundImage: imgProv, onBackgroundImageError: (_, __) {},
        child: imgProv == null ? fallback : null),
      Positioned(right: 0, bottom: 0, child: Container(
        width: radius * 0.48, height: radius * 0.48,
        decoration: BoxDecoration(color: online ? Gx.live : Gx.away, shape: BoxShape.circle,
          border: Border.all(color: bg, width: 1.5),
          boxShadow: online ? Gx.glow(Gx.live, b: 6, s: -2) : []),
      )),
    ]);
  }
}
class _GaxLogo extends StatelessWidget {
  final double size;
  const _GaxLogo({required this.size});
  @override
  Widget build(BuildContext ctx) => SizedBox(width: size, height: size,
    child: ClipRRect(borderRadius: BorderRadius.circular(size * 0.26),
      child: Image.asset('assets/logo.png', width: size, height: size, fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size, height: size,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(size * 0.26), gradient: Gx.gBrand, boxShadow: Gx.glow(Gx.violet, b: 24)),
          child: Icon(Icons.bolt_rounded, size: size * 0.56, color: Colors.white)))));
}
class _BrandText extends StatelessWidget {
  final String text; final double size; final double spacing;
  const _BrandText(this.text, {required this.size, required this.spacing});
  @override
  Widget build(BuildContext ctx) => ShaderMask(
    shaderCallback: (r) => Gx.gBrand.createShader(r),
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: size, fontWeight: FontWeight.w900, letterSpacing: spacing)));
}
class _GaxField extends StatelessWidget {
  final TextEditingController? ctrl;
  final String hint; final IconData? icon;
  final TextInputType? type; final bool obscure, dark;
  final Widget? suffix; final int? maxLines; final ValueChanged<String>? onChanged;
  const _GaxField({this.ctrl, required this.hint, this.icon, this.type,
    this.obscure = false, this.suffix, this.maxLines, required this.dark, this.onChanged});
  @override
  Widget build(BuildContext ctx) => TextField(
    controller: ctrl, keyboardType: type,
    obscureText: obscure, maxLines: obscure ? 1 : (maxLines ?? 1),
    onChanged: onChanged, cursorColor: Gx.violet,
    style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 15, height: 1.4),
    decoration: InputDecoration(
      hintText: hint, hintStyle: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 14),
      filled: true, fillColor: dark ? Gx.d4 : Gx.l2,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Gx.violet, width: 1.6)),
      prefixIcon: icon != null ? Icon(icon, size: 18, color: dark ? Gx.tx2 : Gx.tx2L) : null,
      suffixIcon: suffix, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
class _GaxBtn extends StatelessWidget {
  final Widget child; final VoidCallback? onTap;
  const _GaxBtn({required this.child, this.onTap});
  @override
  Widget build(BuildContext ctx) => _TapScale(
    onTap: onTap,
    child: AnimatedOpacity(
      opacity: onTap == null ? 0.45 : 1.0, duration: const Duration(milliseconds: 180),
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(
          gradient: onTap != null ? Gx.gBrand : null,
          color: onTap == null ? Gx.d4 : null,
          borderRadius: BorderRadius.circular(15),
          boxShadow: onTap != null ? Gx.glow(Gx.violet, b: 18) : []),
        child: Center(child: child),
      ),
    ),
  );
}
class _GaxChip extends StatelessWidget {
  final String label; final IconData icon; final VoidCallback onTap;
  const _GaxChip({required this.label, required this.icon, required this.onTap});
  @override
  Widget build(BuildContext ctx) => _TapScale(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(20), boxShadow: Gx.glow(Gx.violet, b: 12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: Colors.white), const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
      ]),
    ),
  );
}
class _RoundBtn extends StatelessWidget {
  final IconData icon; final Color color; final VoidCallback onTap;
  const _RoundBtn({required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext ctx) => _TapScale(
    onTap: onTap,
    child: Container(width: 36, height: 36,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.12), border: Border.all(color: color.withOpacity(0.28))),
      child: Icon(icon, size: 17, color: color)),
  );
}
class _ContactRow extends StatelessWidget {
  final Map u; final Widget? trailing; final VoidCallback? onTap;
  const _ContactRow({required this.u, this.trailing, this.onTap});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap, splashColor: Gx.violet.withOpacity(0.07), highlightColor: Gx.violet.withOpacity(0.04),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(children: [
            _Avi(pfp: u['pfp'] ?? '', online: u['status'] == 'online', radius: 24), const SizedBox(width: 13),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(u['name'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5, color: dark ? Gx.tx1 : Gx.tx1L)),
              Text((u['bio'] ?? '').isNotEmpty ? u['bio'] : '@${u['username'] ?? ''}',
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5)),
            ])),
            if (trailing != null) trailing!,
          ])),
        Padding(padding: const EdgeInsets.only(left: 77),
          child: Divider(height: 1, thickness: 0.5, color: dark ? Gx.divD : Gx.divL)),
      ]),
    );
  }
}
class _PrefRow extends StatelessWidget {
  final IconData icon; final Gradient iconGrad; final String title;
  final String? subtitle; final Color? titleColor; final Widget? trailing; final VoidCallback? onTap; final bool dark;
  const _PrefRow({required this.icon, required this.iconGrad, required this.title, required this.dark,
    this.subtitle, this.titleColor, this.trailing, this.onTap});
  @override
  Widget build(BuildContext ctx) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    leading: Container(width: 38, height: 38,
      decoration: BoxDecoration(gradient: iconGrad, borderRadius: BorderRadius.circular(11), boxShadow: Gx.glow(Gx.violet, b: 8, s: -2)),
      child: Icon(icon, size: 19, color: Colors.white)),
    title: Text(title, style: TextStyle(color: titleColor ?? (dark ? Gx.tx1 : Gx.tx1L), fontSize: 15, fontWeight: FontWeight.w500)),
    subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5)) : null,
    trailing: trailing ?? (onTap != null ? Icon(Icons.chevron_right_rounded, size: 18, color: dark ? Gx.tx2 : Gx.tx2L) : null),
    onTap: onTap,
  );
}
class _RadioDot extends StatelessWidget {
  final bool selected;
  const _RadioDot({required this.selected});
  @override
  Widget build(BuildContext ctx) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: 22, height: 22,
    decoration: BoxDecoration(shape: BoxShape.circle,
      gradient: selected ? Gx.gBrand : null,
      border: Border.all(color: selected ? Colors.transparent : Gx.tx2, width: 2),
      boxShadow: selected ? Gx.glow(Gx.violet, b: 8, s: -2) : []),
    child: selected ? const Icon(Icons.check_rounded, size: 13, color: Colors.white) : null,
  );
}
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 22, 16, 6),
    child: ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w800, letterSpacing: 1.0))),
  );
}
class _GaxSpinner extends StatelessWidget {
  final double size;
  const _GaxSpinner({this.size = 22});
  @override
  Widget build(BuildContext ctx) => SizedBox(width: size, height: size,
    child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation(Gx.violet)));
}
class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
    decoration: BoxDecoration(color: Gx.d3.withOpacity(0.9), borderRadius: BorderRadius.circular(26),
      border: Border.all(color: Gx.violet.withOpacity(0.20), width: 1), boxShadow: Gx.glow(Gx.violet, b: 44, s: -6)),
    child: child,
  );
}
class _GradientBar extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(height: 3.5, width: 52, margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(2)));
}
class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Container(width: 42, height: 4, decoration: BoxDecoration(color: dark ? Gx.tx3 : Gx.tx3L, borderRadius: BorderRadius.circular(2)));
  }
}
class _OnlineFriendsStrip extends StatefulWidget {
  final List<String> friendIds; final String myId; final bool dark;
  const _OnlineFriendsStrip({required this.friendIds, required this.myId, required this.dark});
  @override State<_OnlineFriendsStrip> createState() => _OnlineFriendsStripState();
}
class _OnlineFriendsStripState extends State<_OnlineFriendsStrip> {
  final Map<String, bool> _online = {};
  final List<StreamSubscription> _subs = [];
  @override void initState() { super.initState(); _listenStatus(); }
  @override
  void didUpdateWidget(_OnlineFriendsStrip old) {
    super.didUpdateWidget(old);
    if (old.friendIds.length != widget.friendIds.length) _listenStatus();
  }
  void _listenStatus() {
    for (final s in _subs) s.cancel(); _subs.clear();
    for (final fid in widget.friendIds) {
      _subs.add(FirebaseDatabase.instance.ref('users/$fid/status').onValue.listen((e) {
        if (!mounted) return;
        setState(() => _online[fid] = e.snapshot.value?.toString() == 'online');
      }));
    }
  }
  @override void dispose() { for (final s in _subs) s.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) {
    final onlineIds = _online.entries.where((e) => e.value).map((e) => e.key).toList();
    if (onlineIds.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _SectionLabel('ONLINE NOW'),
      SizedBox(height: 90, child: ListView.builder(
        scrollDirection: Axis.horizontal, padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
        itemCount: onlineIds.length,
        itemBuilder: (_, i) => StreamBuilder(
          stream: FirebaseDatabase.instance.ref('users/${onlineIds[i]}').onValue,
          builder: (_, snap) {
            if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();
            final u = Map<String, dynamic>.from(snap.data!.snapshot.value as Map? ?? {});
            return _TapScale(
              onTap: () => _gaxPush(ctx, ChatRoom(target: u)),
              child: Padding(padding: const EdgeInsets.only(right: 16), child: Column(mainAxisSize: MainAxisSize.min, children: [
                _Avi(pfp: u['pfp'] ?? '', online: true, radius: 28), const SizedBox(height: 6),
                SizedBox(width: 62, child: Text(u['name'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: widget.dark ? Gx.tx1 : Gx.tx1L))),
              ])),
            );
          },
        ),
      )),
    ]);
  }
}
class _FindEmptyView extends StatelessWidget {
  final String myId;
  const _FindEmptyView({required this.myId});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$myId').onValue,
      builder: (_, snap) {
        final d = (snap.hasData && snap.data!.snapshot.value != null)
            ? Map<String, dynamic>.from(snap.data!.snapshot.value as Map? ?? {}) : <String, dynamic>{};
        final username = d['username'] ?? '';
        return Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 72, height: 72,
              decoration: BoxDecoration(gradient: Gx.gBrand2, borderRadius: BorderRadius.circular(22), boxShadow: Gx.glow(Gx.violet, b: 24)),
              child: const Icon(Icons.person_search_rounded, color: Colors.white, size: 36)),
            const SizedBox(height: 20),
            Text('Find People', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('Search by @username above to add friends', textAlign: TextAlign.center,
              style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13.5)),
            if (username.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Share your username', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12)),
              const SizedBox(height: 8),
              _TapScale(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '@$username'));
                  ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Username copied!'), behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2)));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(16), boxShadow: Gx.glow(Gx.violet, b: 14)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.alternate_email_rounded, color: Colors.white, size: 18), const SizedBox(width: 8),
                    Text('@$username', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy_rounded, color: Colors.white70, size: 14),
                  ]),
                ),
              ),
              const SizedBox(height: 8),
              Text('Tap to copy & share', style: TextStyle(color: dark ? Gx.tx3 : Gx.tx3L, fontSize: 11)),
            ],
          ])));
      },
    );
  }
}
Widget _emptyView(IconData icon, String title, String sub) => Center(
  child: Padding(padding: const EdgeInsets.all(36),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack,
        builder: (_, v, child) => Transform.scale(scale: v, child: child),
        child: Builder(builder: (ctx) {
          final dark = Theme.of(ctx).brightness == Brightness.dark;
          return Container(width: 80, height: 80,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24),
              color: dark ? Gx.d4 : const Color(0xFFE8E6FF),
              border: Border.all(color: Gx.violet.withOpacity(dark ? 0.22 : 0.35), width: 1.2),
              boxShadow: dark ? [] : [BoxShadow(color: Gx.violet.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 4))]),
            child: Icon(icon, size: 38, color: dark ? Gx.tx2 : Gx.indigo));
        })),
      const SizedBox(height: 20),
      Builder(builder: (ctx) {
        final dark = Theme.of(ctx).brightness == Brightness.dark;
        return Column(children: [
          Text(title, style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Text(sub, textAlign: TextAlign.center, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13.5, height: 1.4)),
        ]);
      }),
    ])),
);
String _timeStr(DateTime dt) {
  final n = DateTime.now();
  if (_sd(dt, n)) return 'Today';
  if (_sd(dt, n.subtract(const Duration(days: 1)))) return 'Yesterday';
  return DateFormat('dd/MM/yy').format(dt);
}
bool _sd(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
void _gaxPush(BuildContext ctx, Widget page) => Navigator.push(ctx, PageRouteBuilder(
  pageBuilder: (_, a1, a2) => page,
  transitionsBuilder: (_, a1, a2, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: a1, curve: Curves.easeOutCubic)),
    child: FadeTransition(opacity: CurvedAnimation(parent: a1, curve: const Interval(0, 0.6)), child: child)),
  transitionDuration: const Duration(milliseconds: 300),
));
void _gaxDialog(BuildContext ctx, {required String title, required String body, required String confirmLabel, required Color confirmClr, required VoidCallback onConfirm, VoidCallback? onCancel}) =>
    showDialog(context: ctx, builder: (c) => _GaxAlertDialog(title: title, body: body, confirmLabel: confirmLabel, confirmClr: confirmClr, onConfirm: onConfirm, onCancel: onCancel));
class _GaxAlertDialog extends StatelessWidget {
  final String title, body, confirmLabel; final Color confirmClr;
  final VoidCallback onConfirm; final VoidCallback? onCancel;
  const _GaxAlertDialog({required this.title, required this.body, required this.confirmLabel,
    required this.confirmClr, required this.onConfirm, this.onCancel});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return TweenAnimationBuilder<double>(tween: Tween(begin: 0.78, end: 1.0),
      duration: const Duration(milliseconds: 280), curve: Curves.easeOutBack,
      builder: (_, v, child) => Transform.scale(scale: v, child: child),
      child: AlertDialog(
        backgroundColor: dark ? Gx.d4 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Text(title, style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontWeight: FontWeight.w800, fontSize: 17)),
        content: Text(body, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 14)),
        actions: [
          if (onCancel != null) TextButton(onPressed: onCancel, child: Text('Cancel', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L))),
          TextButton(onPressed: onConfirm, child: Text(confirmLabel, style: TextStyle(color: confirmClr, fontWeight: FontWeight.w800))),
        ],
      ));
  }
}
class SupportEntryPoint extends StatefulWidget {
  const SupportEntryPoint({super.key});
  @override State<SupportEntryPoint> createState() => _SupportEntryPointState();
}
class _SupportEntryPointState extends State<SupportEntryPoint> {
  bool _loading = true; String? _error; Map<String, dynamic>? _ownerData;
  @override void initState() { super.initState(); _fetchOwner(); }
  Future<void> _fetchOwner() async {
    try {
      final configSnap = await FirebaseDatabase.instance.ref('config/ownerUid').get();
      if (!configSnap.exists || configSnap.value == null) { _fail('Support unavailable right now.'); return; }
      final ownerUid  = configSnap.value.toString();
      final ownerSnap = await FirebaseDatabase.instance.ref('users/$ownerUid').get();
      if (!ownerSnap.exists || ownerSnap.value == null) { _fail('Support unavailable right now.'); return; }
      if (!mounted) return;
      setState(() { _ownerData = Map<String, dynamic>.from(ownerSnap.value as Map); _loading = false; });
    } catch (e) { _fail('Failed to connect. Try again.'); }
  }
  void _fail(String msg) { if (!mounted) return; setState(() { _error = msg; _loading = false; }); }
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    if (_loading) return Scaffold(backgroundColor: dark ? Gx.d1 : Gx.l0, appBar: AppBar(title: const Text('Support')), body: const Center(child: _GaxSpinner()));
    if (_error != null) return Scaffold(
      backgroundColor: dark ? Gx.d1 : Gx.l0, appBar: AppBar(title: const Text('Support')),
      body: Center(child: Padding(padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Gx.rose), const SizedBox(height: 16),
          Text(_error!, textAlign: TextAlign.center, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 14)),
          const SizedBox(height: 24),
          _GaxBtn(onTap: () { setState(() { _loading = true; _error = null; }); _fetchOwner(); },
            child: const Text('Retry', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
        ]))),
    );
    return _SupportLanding(ownerData: _ownerData!);
  }
}
class _SupportLanding extends StatelessWidget {
  final Map<String, dynamic> ownerData;
  const _SupportLanding({required this.ownerData});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: dark ? Gx.d1 : Gx.l0,
      appBar: AppBar(backgroundColor: dark ? Gx.d3 : Gx.violet, title: const Text('Support & Feedback')),
      body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity, padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: dark ? Gx.gHdr : Gx.gLHdr, borderRadius: BorderRadius.circular(20), boxShadow: Gx.glow(Gx.violet, b: 20)),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(2.5),
              decoration: const BoxDecoration(shape: BoxShape.circle, gradient: Gx.gBrand),
              child: CircleAvatar(radius: 26, backgroundColor: Gx.d3,
                backgroundImage: (ownerData['pfp'] ?? '').isNotEmpty ? NetworkImage(ownerData['pfp']) : null,
                onBackgroundImageError: (_, __) {},
                child: (ownerData['pfp'] ?? '').isEmpty ? const Icon(Icons.person_rounded, color: Gx.tx2) : null)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Talk to us!', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
              const SizedBox(height: 3),
              Text('${ownerData['name'] ?? 'Support'} · GamerArnabXYZ',
                style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12.5)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: Gx.live.withOpacity(0.18), borderRadius: BorderRadius.circular(20), border: Border.all(color: Gx.live.withOpacity(0.5))),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.circle, size: 7, color: Gx.live), SizedBox(width: 5),
                  Text('We read every message', style: TextStyle(color: Gx.live, fontSize: 10.5, fontWeight: FontWeight.w600)),
                ])),
            ])),
          ]),
        ),
        const SizedBox(height: 28),
        ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
          child: const Text('WHAT WOULD YOU LIKE TO DO?', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.0))),
        const SizedBox(height: 14),
        _SupportCard(icon: Icons.bug_report_outlined,       color: Gx.rose,   title: 'Report a Bug',      subtitle: 'Something broken? Tell us exactly what happened.', tag: FeedbackTag.bug,      ownerData: ownerData, dark: dark),
        const SizedBox(height: 12),
        _SupportCard(icon: Icons.lightbulb_outline_rounded, color: Gx.amber,  title: 'Suggest a Feature', subtitle: "Got an idea? We'd love to hear it.",                tag: FeedbackTag.feature,  ownerData: ownerData, dark: dark),
        const SizedBox(height: 12),
        _SupportCard(icon: Icons.chat_bubble_outline_rounded, color: Gx.mint, title: 'General Feedback',  subtitle: "Anything on your mind — we're listening.",          tag: FeedbackTag.feedback, ownerData: ownerData, dark: dark),
        const SizedBox(height: 12),
        _SupportCard(icon: Icons.forum_outlined,             color: Gx.violet, title: 'Just Chat',        subtitle: 'Open a direct conversation without any tag.',        tag: null,                 ownerData: ownerData, dark: dark),
        const SizedBox(height: 32),
        Center(child: TextButton.icon(
          icon: Icon(Icons.history_rounded, size: 16, color: dark ? Gx.tx2 : Gx.tx2L),
          label: Text('View chat history', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13)),
          onPressed: () => _gaxPush(ctx, ChatRoom(target: ownerData)),
        )),
        const SizedBox(height: 20),
      ])),
    );
  }
}
class _SupportCard extends StatelessWidget {
  final IconData icon; final Color color; final String title, subtitle;
  final FeedbackTag? tag; final Map<String, dynamic> ownerData; final bool dark;
  const _SupportCard({required this.icon, required this.color, required this.title,
    required this.subtitle, required this.tag, required this.ownerData, required this.dark});
  @override
  Widget build(BuildContext ctx) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: () => _gaxPush(ctx, ChatRoom(target: ownerData, initialFeedbackTag: tag)),
      borderRadius: BorderRadius.circular(18),
      splashColor: color.withOpacity(0.08), highlightColor: color.withOpacity(0.04),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dark ? Gx.d3 : Colors.white, borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(dark ? 0.25 : 0.18), width: 1.2),
          boxShadow: [BoxShadow(color: color.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 3))]),
        child: Row(children: [
          Container(width: 46, height: 46,
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.25))),
            child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(subtitle, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5)),
          ])),
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: dark ? Gx.tx3 : Gx.tx3L),
        ]),
      ),
    ),
  );
}
class FeedbackDashboard extends StatefulWidget {
  const FeedbackDashboard({super.key});
  @override State<FeedbackDashboard> createState() => _FeedbackDashboardState();
}
class _FeedbackDashboardState extends State<FeedbackDashboard> with SingleTickerProviderStateMixin {
  late final TabController _tc = TabController(length: 4, vsync: this);
  String _filter = 'all';
  @override void dispose() { _tc.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: dark ? Gx.d1 : Gx.l0,
      appBar: AppBar(
        backgroundColor: dark ? Gx.d3 : Gx.violet,
        title: const Text('Feedback Dashboard'),
        bottom: TabBar(
          controller: _tc,
          onTap: (i) => setState(() => _filter = ['all', 'bug', 'feature', 'feedback'][i]),
          labelColor: Colors.white, unselectedLabelColor: Colors.white54, indicatorColor: Gx.cyan,
          tabs: const [Tab(text: 'All'), Tab(icon: Icon(Icons.bug_report_outlined, size: 18)),
            Tab(icon: Icon(Icons.lightbulb_outline_rounded, size: 18)), Tab(icon: Icon(Icons.chat_bubble_outline_rounded, size: 18))],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref('feedback_tags').onValue,
        builder: (ctx, snap) {
          if (!snap.hasData || snap.data!.snapshot.value == null)
            return Center(child: Text('No feedback yet!', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L)));
          final all = <_FeedbackEntry>[];
          (snap.data!.snapshot.value as Map).forEach((chatId, msgs) {
            if (msgs is! Map) return;
            msgs.forEach((msgId, data) {
              if (data is! Map) return;
              all.add(_FeedbackEntry(chatId: chatId.toString(), msgId: msgId.toString(),
                type: data['type']?.toString() ?? 'feedback', uid: data['uid']?.toString() ?? '',
                ts: data['ts'] is int ? data['ts'] as int : 0, resolved: data['resolved'] == true,
                adminReply: data['adminReply']?.toString()));
            });
          });
          final filtered = _filter == 'all' ? all : all.where((e) => e.type == _filter).toList();
          filtered.sort((a, b) { if (a.resolved != b.resolved) return a.resolved ? 1 : -1; return b.ts.compareTo(a.ts); });
          if (filtered.isEmpty) return Center(child: Text('No ${_filter == 'all' ? '' : _filter} feedback yet!', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L)));
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: filtered.length,
            itemBuilder: (ctx, i) => _FeedbackCard(entry: filtered[i], dark: dark),
          );
        },
      ),
    );
  }
}
class _FeedbackEntry {
  final String chatId, msgId, type, uid; final int ts; final bool resolved; final String? adminReply;
  const _FeedbackEntry({required this.chatId, required this.msgId, required this.type, required this.uid, required this.ts, required this.resolved, this.adminReply});
}
class _FeedbackCard extends StatelessWidget {
  final _FeedbackEntry entry; final bool dark;
  const _FeedbackCard({required this.entry, required this.dark});
  Color get _clr => entry.type == 'bug' ? Gx.rose : entry.type == 'feature' ? Gx.amber : Gx.mint;
  IconData get _ico => entry.type == 'bug' ? Icons.bug_report_outlined : entry.type == 'feature' ? Icons.lightbulb_outline_rounded : Icons.chat_bubble_outline_rounded;
  String get _lbl => entry.type == 'bug' ? 'Bug Report' : entry.type == 'feature' ? 'Feature Request' : 'Feedback';
  @override
  Widget build(BuildContext ctx) {
    final dt = DateTime.fromMillisecondsSinceEpoch(entry.ts);
    final time = '${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/${entry.uid}').onValue,
      builder: (_, uSnap) {
        final u = (uSnap.hasData && uSnap.data!.snapshot.value != null) ? Map<String,dynamic>.from(uSnap.data!.snapshot.value as Map? ?? {}) : <String,dynamic>{};
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(color: dark ? Gx.d3 : Colors.white, borderRadius: BorderRadius.circular(16),
            border: Border.all(color: entry.resolved ? (dark ? Gx.tx3 : Gx.tx3L) : _clr.withOpacity(0.3), width: 1.1)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              decoration: BoxDecoration(color: _clr.withOpacity(entry.resolved ? 0.04 : 0.09), borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
              child: Row(children: [
                Icon(_ico, size: 15, color: _clr), const SizedBox(width: 6),
                Text(_lbl, style: TextStyle(color: _clr, fontSize: 12, fontWeight: FontWeight.w700)), const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (entry.resolved ? Gx.mint : Gx.amber).withOpacity(0.15), borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: (entry.resolved ? Gx.mint : Gx.amber).withOpacity(0.4))),
                  child: Text(entry.resolved ? 'Resolved' : 'Pending',
                    style: TextStyle(color: entry.resolved ? Gx.mint : Gx.amber, fontSize: 10, fontWeight: FontWeight.w600))),
              ])),
            Padding(padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
              child: Row(children: [
                CircleAvatar(radius: 17, backgroundColor: Gx.d4,
                  backgroundImage: (u['pfp'] ?? '').isNotEmpty ? NetworkImage(u['pfp']) : null,
                  onBackgroundImageError: (_, __) {},
                  child: (u['pfp'] ?? '').isEmpty ? const Icon(Icons.person_rounded, size: 16, color: Gx.tx2) : null),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(u['name'] ?? 'Unknown', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 14, fontWeight: FontWeight.w700)),
                  Text('@${u['username'] ?? ''}', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11.5)),
                ])),
                Text(time, style: TextStyle(color: dark ? Gx.tx3 : Gx.tx3L, fontSize: 11)),
              ])),
            if (entry.adminReply != null && entry.adminReply!.isNotEmpty)
              Container(margin: const EdgeInsets.fromLTRB(14, 10, 14, 0), padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                decoration: BoxDecoration(color: Gx.violet.withOpacity(0.08), borderRadius: BorderRadius.circular(10),
                  border: const Border(left: BorderSide(color: Gx.violet, width: 3))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Admin reply', style: TextStyle(color: Gx.violet, fontSize: 10.5, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text(entry.adminReply!, style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5)),
                ])),
            Padding(padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(children: [
                Expanded(child: _DashBtn(icon: Icons.open_in_new_rounded, label: 'Open Chat', color: Gx.violet,
                  onTap: () async {
                    final snap = await FirebaseDatabase.instance.ref('users/${entry.uid}').get();
                    if (!snap.exists || !ctx.mounted) return;
                    _gaxPush(ctx, ChatRoom(target: Map<String, dynamic>.from(snap.value as Map? ?? {})));
                  })),
                const SizedBox(width: 8),
                Expanded(child: _DashBtn(
                  icon: entry.resolved ? Icons.replay_rounded : Icons.check_rounded,
                  label: entry.resolved ? 'Reopen' : 'Resolve',
                  color: entry.resolved ? Gx.tx2 : Gx.mint,
                  onTap: () => FirebaseDatabase.instance.ref('feedback_tags/${entry.chatId}/${entry.msgId}/resolved')
                      .set(!entry.resolved).catchError((e) => debugPrint('Resolve: $e')))),
              ])),
          ]),
        );
      },
    );
  }
}
class _DashBtn extends StatelessWidget {
  final IconData icon; final String label; final Color color; final VoidCallback onTap;
  const _DashBtn({required this.icon, required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext ctx) => Material(
    color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(10),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10),
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 14, color: color), const SizedBox(width: 5),
          Text(label, style: TextStyle(color: color, fontSize: 12.5, fontWeight: FontWeight.w700)),
        ]))),
  );
}