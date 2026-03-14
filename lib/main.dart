import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

// ═══════════════════════════════════════════════════
//  URL LAUNCHER HELPER
// ═══════════════════════════════════════════════════
Future<void> _openUrl(String raw) async {
  final url = raw.startsWith('http') ? raw : 'https://$raw';
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ═══════════════════════════════════════════════════
//  DESIGN TOKENS  —  GAX v9.0
// ═══════════════════════════════════════════════════
class Gx {
  // Dark palette
  static const d0 = Color(0xFF05050E);
  static const d1 = Color(0xFF080916);
  static const d2 = Color(0xFF0C0D1E);
  static const d3 = Color(0xFF111228);
  static const d4 = Color(0xFF171933);
  static const d5 = Color(0xFF1F2142);
  static const d6 = Color(0xFF262950);

  // Light palette  — warm ivory, not sterile white
  static const l0 = Color(0xFFF7F7FF);
  static const l1 = Color(0xFFFFFFFF);
  static const l2 = Color(0xFFEEEEFB);
  static const l3 = Color(0xFFE4E4F6);
  static const l4 = Color(0xFFD8D8F0);

  // Brand
  static const violet = Color(0xFF7C5CFC);
  static const cyan   = Color(0xFF00D4FF);
  static const indigo = Color(0xFF4535CC);
  static const mint   = Color(0xFF00E5A0);
  static const rose   = Color(0xFFFF4D80);
  static const amber  = Color(0xFFFFB340);

  // Bubbles dark
  static const sentD  = Color(0xFF1A1650);
  static const recvD  = Color(0xFF0F1024);
  // Bubbles light
  static const sentL  = Color(0xFFEDE8FF);
  static const recvL  = Color(0xFFFFFFFF);

  // Text dark
  static const tx1  = Color(0xFFF0F0FF);
  static const tx2  = Color(0xFF7878A8);
  static const tx3  = Color(0xFF3C3D62);
  // Text light
  static const tx1L = Color(0xFF080916);
  static const tx2L = Color(0xFF5A5A88);
  static const tx3L = Color(0xFF9090C0);

  // State
  static const live    = Color(0xFF2EFF9A);
  static const away    = Color(0xFF3A3D60);
  static const readClr = Color(0xFF00D4FF);
  static const err     = Color(0xFFFF4D80);

  // Dividers
  static const divD = Color(0xFF141630);
  static const divL = Color(0xFFDDDDF4);

  // Gradients
  static const gBrand = LinearGradient(colors: [violet, cyan], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gBrand2= LinearGradient(colors: [violet, Color(0xFFB044FF)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gDeep  = LinearGradient(colors: [Color(0xFF080916), Color(0xFF05050E)], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const gHdr   = LinearGradient(colors: [Color(0xFF130F40), Color(0xFF080916)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gLHdr  = LinearGradient(colors: [Color(0xFF6040E8), Color(0xFF8560FF)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const gCard  = LinearGradient(colors: [Color(0xFF1F2142), Color(0xFF171933)], begin: Alignment.topLeft, end: Alignment.bottomRight);

  // Nav bar light bg
  static const navL = Color(0xFFFFFFFF);
  static const navD = Color(0xFF0C0D1E);

  static List<BoxShadow> glow(Color c, {double b = 20, double s = -2}) =>
      [BoxShadow(color: c.withOpacity(0.30), blurRadius: b, spreadRadius: s)];
  static List<BoxShadow> glow2(Color c) =>
      [BoxShadow(color: c.withOpacity(0.18), blurRadius: 28, spreadRadius: -4, offset: const Offset(0, 8))];
  static List<BoxShadow> softShadow(bool dark) =>
      [BoxShadow(color: Colors.black.withOpacity(dark ? 0.30 : 0.10), blurRadius: 12, offset: const Offset(0, 3))];
}

// ═══════════════════════════════════════════════════
//  THEME
// ═══════════════════════════════════════════════════
ThemeData gaxTheme(bool dark) {
  final bg   = dark ? Gx.d1   : Gx.l0;
  final surf = dark ? Gx.d3   : Gx.l1;
  final fill = dark ? Gx.d4   : Gx.l2;
  final tx1  = dark ? Gx.tx1  : Gx.tx1L;
  final tx2  = dark ? Gx.tx2  : Gx.tx2L;
  return ThemeData(
    useMaterial3: true,
    brightness: dark ? Brightness.dark : Brightness.light,
    scaffoldBackgroundColor: bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Gx.violet,
      brightness: dark ? Brightness.dark : Brightness.light,
    ).copyWith(primary: Gx.violet, secondary: Gx.cyan, surface: surf, error: Gx.err),
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? Gx.d3 : Gx.violet,
      foregroundColor: Colors.white,
      elevation: 0, scrolledUnderElevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: dark ? Gx.navD : Gx.navL,
        systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      ),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 0.1),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: dark ? Gx.navD : Gx.navL,
      selectedItemColor: Gx.violet,
      unselectedItemColor: tx2,
      elevation: 0, type: BottomNavigationBarType.fixed,
      showSelectedLabels: false, showUnselectedLabels: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: fill,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Gx.violet, width: 1.6),
      ),
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

// ═══════════════════════════════════════════════════
//  THEME CONTROLLER  — auto + manual
// ═══════════════════════════════════════════════════
// Auto mode options
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
    // system mode - read actual platform brightness
    return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  ThemeCtrl() {
    // Listen to system brightness changes (phone night mode, auto-brightness)
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onSystemBrightnessChanged;
    _startAutoCheck();
  }

  void _onSystemBrightnessChanged() {
    if (!_auto || _autoMode == AutoThemeMode.timeBased) return;
    notifyListeners();
  }

  void setAuto(bool v) {
    _auto = v;
    if (v) {
      _autoMode = AutoThemeMode.system;
      _mode = ThemeMode.system;
      _applyAuto();
    }
    notifyListeners();
  }

  void setAutoMode(AutoThemeMode m) {
    _auto = true;
    _autoMode = m;
    if (m == AutoThemeMode.timeBased) {
      _applyTimeTheme();
    } else {
      _mode = ThemeMode.system;
    }
    notifyListeners();
  }

  void setDark(bool v) {
    _auto = false;
    _mode = v ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void _applyAuto() {
    if (!_auto) return;
    if (_autoMode == AutoThemeMode.timeBased) {
      _applyTimeTheme();
    } else {
      _mode = ThemeMode.system;
    }
  }

  void _applyTimeTheme() {
    if (!_auto) return;
    final h = DateTime.now().hour;
    final shouldDark = h < 6 || h >= 19;
    final newMode = shouldDark ? ThemeMode.dark : ThemeMode.light;
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

// ═══════════════════════════════════════════════════
//  MAIN
// ═══════════════════════════════════════════════════
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
        theme: gaxTheme(false),
        darkTheme: gaxTheme(true),
        themeMode: _tc.mode,
        home: _AuthGate(tc: _tc),
      );
    },
  );

  void _updateSystemUI(bool dark) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: dark ? Gx.navD : Gx.navL,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: dark ? Brightness.light : Brightness.dark,
    ));
  }
}

// ═══════════════════════════════════════════════════
//  AUTH GATE
// ═══════════════════════════════════════════════════
class _AuthGate extends StatelessWidget {
  final ThemeCtrl tc;
  const _AuthGate({required this.tc});
  @override
  Widget build(BuildContext ctx) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (ctx, snap) {
      if (snap.connectionState == ConnectionState.waiting) return const _Splash();
      if (!snap.hasData) return const LoginScreen();
      final uid = snap.data!.uid;
      FirebaseDatabase.instance.ref('users/$uid/status').set('online').catchError((_){});
      FirebaseDatabase.instance.ref('users/$uid/status').onDisconnect().set('offline').catchError((_){});
      FirebaseDatabase.instance.ref('users/$uid/lastSeen').onDisconnect().set(ServerValue.timestamp).catchError((_){});
      return StreamBuilder(
        stream: FirebaseDatabase.instance.ref('users/$uid').onValue,
        builder: (c, db) {
          if (db.connectionState == ConnectionState.waiting) return const _Splash();
          final d = db.data?.snapshot.value as Map?;
          if (d == null || d['username'] == null) return const ProfileSetup();
          return MainScreen(tc: tc);
        },
      );
    },
  );
}

// ═══════════════════════════════════════════════════
//  SPLASH
// ═══════════════════════════════════════════════════
class _Splash extends StatefulWidget {
  const _Splash();
  @override State<_Splash> createState() => _SplashState();
}
class _SplashState extends State<_Splash> with TickerProviderStateMixin {
  late final _ac    = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
  late final _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);
  late final _ring  = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat();
  late final _fade  = CurvedAnimation(parent: _ac, curve: const Interval(0, .6, curve: Curves.easeOut));
  late final _rise  = Tween<Offset>(begin: const Offset(0, .12), end: Offset.zero)
      .animate(CurvedAnimation(parent: _ac, curve: const Interval(0, .7, curve: Curves.easeOutCubic)));
  late final _scalePulse = Tween(begin: 0.95, end: 1.05)
      .animate(CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  @override void dispose() { _ac.dispose(); _pulse.dispose(); _ring.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext ctx) => Scaffold(
    backgroundColor: Gx.d0,
    body: Center(child: FadeTransition(opacity: _fade, child: SlideTransition(position: _rise,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ScaleTransition(scale: _scalePulse, child: Stack(alignment: Alignment.center, children: [
          AnimatedBuilder(animation: _ring, builder: (_, __) => Transform.rotate(
            angle: _ring.value * 2 * math.pi,
            child: Container(width: 116, height: 116, decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(colors: [
                Gx.violet.withOpacity(0.55), Colors.transparent,
                Gx.cyan.withOpacity(0.45), Colors.transparent,
              ]),
            )),
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

// ═══════════════════════════════════════════════════
//  LOGIN
// ═══════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginState();
}
class _LoginState extends State<LoginScreen> with TickerProviderStateMixin {
  final _emailC = TextEditingController();
  final _passC  = TextEditingController();
  bool _busy = false, _hide = true; String? _err;
  late final _bgAc  = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat(reverse: true);
  late final _entAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
  late final _fadeA = CurvedAnimation(parent: _entAc, curve: Curves.easeOut);
  late final _slideA= Tween<Offset>(begin: const Offset(0, .16), end: Offset.zero)
      .animate(CurvedAnimation(parent: _entAc, curve: Curves.easeOutCubic));
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
      } catch (e) { if (mounted) setState(() => _err = 'Invalid credentials or weak password (min 6 chars)'); }
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height;
    return Scaffold(
      backgroundColor: Gx.d0,
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        AnimatedBuilder(animation: _bgAc, builder: (_, __) => CustomPaint(painter: _NebulaPainter(_bgAc.value), size: MediaQuery.of(ctx).size)),
        SafeArea(child: FadeTransition(opacity: _fadeA, child: SlideTransition(position: _slideA,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: h - MediaQuery.of(ctx).padding.top),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(height: h * .09),
                _GaxLogo(size: 70),
                const SizedBox(height: 18),
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
                      decoration: BoxDecoration(color: Gx.err.withOpacity(0.1), borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Gx.err.withOpacity(0.3))),
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
      [0.14, 0.18, 240.0, Gx.violet],
      [0.84, 0.14, 180.0, Gx.cyan],
      [0.76, 0.82, 200.0, Gx.indigo],
      [0.08, 0.78, 150.0, Gx.violet],
      [0.5, 0.5, 130.0, Gx.cyan],
    ]) {
      final dx = math.sin(t * math.pi * 2 + (b[0] as double) * 7) * 32;
      final dy = math.cos(t * math.pi * 2 + (b[1] as double) * 5) * 32;
      final cx = s.width * (b[0] as double) + dx;
      final cy = s.height * (b[1] as double) + dy;
      final r  = b[2] as double;
      canvas.drawCircle(Offset(cx, cy), r, Paint()..shader =
        RadialGradient(colors: [(b[3] as Color).withOpacity(0.12), Colors.transparent])
          .createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)));
    }
  }
  @override bool shouldRepaint(_NebulaPainter o) => o.t != t;
}

// ═══════════════════════════════════════════════════
//  PROFILE SETUP
// ═══════════════════════════════════════════════════
class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});
  @override State<ProfileSetup> createState() => _PSState();
}
class _PSState extends State<ProfileSetup> {
  final _n = TextEditingController(), _u = TextEditingController(), _b = TextEditingController();
  bool _busy = false; String? _err;
  @override void dispose() { _n.dispose(); _u.dispose(); _b.dispose(); super.dispose(); }

  Future<void> _save() async {
    if (_n.text.trim().isEmpty || _u.text.trim().isEmpty) {
      if (mounted) setState(() => _err = 'Name & username required');
      return;
    }
    if (!mounted) return;
    setState(() { _busy = true; _err = null; });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final name = _n.text.trim();
    await FirebaseDatabase.instance.ref('users/$uid').update({
      'uid': uid, 'name': name, 'username': _u.text.trim().toLowerCase(),
      'bio': _b.text.trim(),
      'pfp': 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=0C0D1E&color=7C5CFC&bold=true&size=200',
      'status': 'online', 'createdAt': ServerValue.timestamp,
    });
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: dark ? Gx.d3 : Gx.violet,
        elevation: 0,
        leading: const SizedBox.shrink(),
        title: Row(children: [
          _GaxLogo(size: 28),
          const SizedBox(width: 10),
          const Text('Create Profile',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
        ]),
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const SizedBox(height: 8),
        Center(child: _GaxLogo(size: 64)),
        const SizedBox(height: 10),
        Builder(builder: (ctx) { final dark = Theme.of(ctx).brightness == Brightness.dark; return Center(child: Text('Set up your GAX identity', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13))); }),
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

// ═══════════════════════════════════════════════════
//  MAIN SCREEN — bottom nav
// ═══════════════════════════════════════════════════
class MainScreen extends StatefulWidget {
  final ThemeCtrl tc;
  const MainScreen({super.key, required this.tc});
  @override State<MainScreen> createState() => _MainState();
}

class _MainState extends State<MainScreen> {
  int _tab = 0;
  late final _pc = PageController();

  @override
  void dispose() { _pc.dispose(); super.dispose(); }

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

      // ── Flutter native NavigationBar — works on EVERY phone ──
      bottomNavigationBar: _buildNavBar(ctx, myId, dark, bg),

      body: PageView(
        controller: _pc,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ChatsTab(myId: myId),
          const FindTab(),
          SocialTab(myId: myId),
          ProfileTab(tc: widget.tc),
        ],
      ),
    );
  }

  NavigationDestination _navDest(int i, List icons, List labels, int reqCnt, Color activeClr, Color inactiveClr) {
    final hasReq = i == 2 && reqCnt > 0;
    final badge  = hasReq ? Text(reqCnt > 9 ? '9+' : '$reqCnt',
        style: const TextStyle(fontSize: 8, color: Colors.white)) : null;
    return NavigationDestination(
      icon: Badge(
        isLabelVisible: hasReq,
        label: badge,
        backgroundColor: Gx.violet,
        child: Icon(icons[i][0] as IconData),
      ),
      selectedIcon: Badge(
        isLabelVisible: hasReq,
        label: badge,
        backgroundColor: activeClr,
        child: Icon(icons[i][1] as IconData),
      ),
      label: labels[i],
    );
  }

  Widget _buildNavBar(BuildContext ctx, String myId, bool dark, Color bg) {
    const icons = [
      [Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded],
      [Icons.explore_outlined,             Icons.explore_rounded],
      [Icons.people_outline_rounded,       Icons.people_rounded],
      [Icons.person_outline_rounded,       Icons.person_rounded],
    ];
    const labels = ['Chats', 'Find', 'Social', 'Profile'];

    final inactiveClr = dark ? const Color(0xFF4A4B6A) : const Color(0xFF9999BB);
    final activeClr   = Gx.violet;

    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue,
      builder: (_, snap) {
        final reqCnt = (snap.hasData && snap.data!.snapshot.value != null)
            ? (snap.data!.snapshot.value as Map? ?? {}).length : 0;

        return Theme(
          data: Theme.of(ctx).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: bg,
              // Rounded pill indicator with gradient via ShaderMask trick
              indicatorColor: Gx.violet.withOpacity(0.18),
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                final active = states.contains(WidgetState.selected);
                return IconThemeData(
                  color: active ? activeClr : inactiveClr,
                  size: 24,
                );
              }),
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                final active = states.contains(WidgetState.selected);
                return TextStyle(
                  fontSize: 10.5,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? activeClr : inactiveClr,
                  letterSpacing: 0.1,
                );
              }),
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              height: 64,
            ),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Top divider line
            Divider(height: 1, thickness: 0.8,
              color: dark ? const Color(0xFF1E1F38) : const Color(0xFFE0E0EE)),
            NavigationBar(
              selectedIndex: _tab,
              onDestinationSelected: _goTab,
              animationDuration: const Duration(milliseconds: 300),
              destinations: [
                _navDest(0, icons, labels, reqCnt, activeClr, inactiveClr),
                _navDest(1, icons, labels, reqCnt, activeClr, inactiveClr),
                _navDest(2, icons, labels, reqCnt, activeClr, inactiveClr),
                _navDest(3, icons, labels, reqCnt, activeClr, inactiveClr),
              ],
            ),
          ]),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════
//  CUSTOM APP BAR
// ═══════════════════════════════════════════════════
class _GaxAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int tab; final bool dark; final ThemeCtrl tc; final String myId;
  const _GaxAppBar({required this.tab, required this.dark, required this.tc, required this.myId});

  static const _titles = ['Chats', 'Discover', 'Social', 'Profile'];

  @override Size get preferredSize => const Size.fromHeight(58);

  @override
  Widget build(BuildContext ctx) {
    final bg = dark ? Gx.d3 : Gx.violet;
    return Container(
      color: bg,
      child: SafeArea(bottom: false, child: SizedBox(height: 58, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(children: [
          const SizedBox(width: 6),
          _GaxLogo(size: 32),
          const SizedBox(width: 10),
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
              if (v == 'logout') _confirmLogout(ctx);
            },
            itemBuilder: (_) => [
              _mi('auto', tc.auto ? Icons.brightness_auto : Icons.brightness_auto_outlined,
                tc.auto ? 'Auto Theme: ON' : 'Auto Theme: OFF', dark),
              _mi('theme', tc.isDarkNow ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                tc.isDarkNow ? 'Light Mode' : 'Dark Mode', dark),
              _mi('logout', Icons.logout_rounded, 'Sign Out', dark, clr: Gx.rose),
            ],
          ),
          const SizedBox(width: 2),
        ]),
      ))),
    );
  }

  PopupMenuItem<String> _mi(String val, IconData icon, String label, bool dark, {Color? clr}) =>
      PopupMenuItem(value: val, child: Row(children: [
        Icon(icon, size: 17, color: clr ?? (dark ? Gx.tx2 : Gx.tx2L)),
        const SizedBox(width: 10),
        Text(label, style: TextStyle(color: clr ?? (dark ? Gx.tx1 : Gx.tx1L), fontSize: 14)),
      ]));

  void _confirmLogout(BuildContext ctx) => _gaxDialog(ctx,
    title: 'Sign Out', body: 'You\'ll need to sign in again to access your chats.',
    confirmLabel: 'Sign Out', confirmClr: Gx.rose,
    onConfirm: () { Navigator.pop(ctx); FirebaseAuth.instance.signOut(); });
}

// ═══════════════════════════════════════════════════
//  ANIMATED BOTTOM NAV BAR
// ═══════════════════════════════════════════════════

// ═══════════════════════════════════════════════════
//  CHATS TAB
// ═══════════════════════════════════════════════════
class ChatsTab extends StatelessWidget {
  final String myId;
  const ChatsTab({super.key, required this.myId});
  @override
  Widget build(BuildContext ctx) => StreamBuilder(
    stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
    builder: (ctx, snap) {
      if (!snap.hasData || snap.data!.snapshot.value == null)
        return _emptyView(Icons.chat_bubble_outline_rounded, 'No Conversations', 'Find friends and start chatting');
      final rawMap = snap.data!.snapshot.value as Map? ?? {};
      final ids = rawMap.keys.map((k) => k.toString()).toList();
      if (ids.isEmpty) return _emptyView(Icons.chat_bubble_outline_rounded, 'No Conversations', 'Find friends and start chatting');
      // Per-chatId streams — no root read needed
      return _SortedChatList(myId: myId, friendIds: ids);
    },
  );
}

// Streams each chatId individually, sorts by lastTs in memory
class _SortedChatList extends StatefulWidget {
  final String myId;
  final List<String> friendIds;
  const _SortedChatList({required this.myId, required this.friendIds});
  @override State<_SortedChatList> createState() => _SortedChatListState();
}
class _SortedChatListState extends State<_SortedChatList> {
  final Map<String,int> _lastTs = {};
  final Map<String,int> _unread = {};
  final Map<String,StreamSubscription> _subs = {};

  @override
  void initState() {
    super.initState();
    _subscribeAll(widget.friendIds);
  }

  @override
  void didUpdateWidget(_SortedChatList old) {
    super.didUpdateWidget(old);
    final newIds = widget.friendIds.toSet();
    final oldIds = old.friendIds.toSet();
    for (final id in newIds.difference(oldIds)) _subscribeSingle(id);
    for (final id in oldIds.difference(newIds)) { _subs[id]?.cancel(); _subs.remove(id); }
  }

  void _subscribeAll(List<String> ids) {
    for (final fid in ids) _subscribeSingle(fid);
  }

  void _subscribeSingle(String fid) {
    final chatId = ([widget.myId, fid]..sort()).join('_');
    _subs[fid]?.cancel();
    _subs[fid] = FirebaseDatabase.instance.ref('chats/$chatId').onValue.listen((event) {
      if (!mounted) return;
      final d = event.snapshot.value is Map
          ? Map<String,dynamic>.from(event.snapshot.value as Map? ?? {}) : <String,dynamic>{};
      final ts  = d['lastTs'] is int ? d['lastTs'] as int : 0;
      final unreadMap = d['unread'] is Map ? d['unread'] as Map : {};
      final unread = unreadMap[widget.myId] is int ? unreadMap[widget.myId] as int : 0;
      setState(() { _lastTs[fid] = ts; _unread[fid] = unread; });
    });
  }

  @override
  void dispose() {
    for (final s in _subs.values) s.cancel();
    super.dispose();
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
        // Footer item — removes the ugly empty gap at bottom
        if (i == sorted.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(child: Divider(color: dark ? Gx.divD : Gx.divL, indent: 32, endIndent: 12)),
                Text('all caught up', style: TextStyle(
                  color: dark ? Gx.tx3 : Gx.tx3L, fontSize: 11.5,
                  fontWeight: FontWeight.w500, letterSpacing: 0.4)),
                Expanded(child: Divider(color: dark ? Gx.divD : Gx.divL, indent: 12, endIndent: 32)),
              ]),
            ]),
          );
        }
        final fid    = sorted[i];
        final unread = _unread[fid] ?? 0;
        return _AnimatedListItem(
          index: i,
          child: Dismissible(
            key: Key('conv_$fid'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (_) async {
              bool confirmed = false;
              await showDialog(
                context: ctx,
                builder: (dCtx) => _GaxAlertDialog(
                  title: 'Delete Conversation',
                  body: 'This will remove the chat from your list. Messages are not deleted.',
                  confirmLabel: 'Delete',
                  confirmClr: Gx.rose,
                  onConfirm: () { confirmed = true; Navigator.pop(dCtx); },
                ),
              );
              return confirmed;
            },
            onDismissed: (_) {
              FirebaseDatabase.instance.ref("users/${widget.myId}/friends/$fid").remove().catchError((_){});
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Gx.rose.withOpacity(0.85)],
                  begin: Alignment.centerLeft, end: Alignment.centerRight,
                ),
              ),
              child: const Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
                SizedBox(height: 4),
                Text('Delete', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
              ]),
            ),
            child: _ConvRow(myId: widget.myId, fid: fid, unread: unread),
          ),
        );
      },
    );
  }
}

class _ConvRow extends StatelessWidget {
  final String myId, fid;
  const _ConvRow({required this.myId, required this.fid, this.unread = 0});
  final int unread;
  @override
  Widget build(BuildContext ctx) {
    final chatId = ([myId, fid]..sort()).join('_');
    final dark   = Theme.of(ctx).brightness == Brightness.dark;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$fid').onValue,
      builder: (_, uSnap) {
        if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
        final u = Map.from(uSnap.data!.snapshot.value as Map? ?? {});
        return StreamBuilder(
          stream: FirebaseDatabase.instance.ref('messages/$chatId').limitToLast(1).onValue,
          builder: (_, mSnap) {
            String last = 'Tap to start chatting'; int? ts; bool hasUnread = false; bool mine = false;
            if (mSnap.hasData && mSnap.data!.snapshot.value != null) {
              final rawMap = mSnap.data!.snapshot.value as Map? ?? {};
              if (rawMap.isNotEmpty) {
                final v = Map.from(rawMap.values.first as Map? ?? {});
                final rawText = v['text']?.toString() ?? '';
                last     = v['type'] == 'image' ? '📷 Image'
                    : v['type'] == 'link' ? '🔗 Link'
                    : rawText.contains('http') || rawText.contains('www.')
                        ? '🔗 ${rawText.length > 40 ? rawText.substring(0, 40) + '…' : rawText}'
                        : rawText;
                ts       = v['timestamp'] is int ? v['timestamp'] as int : null;
                hasUnread= unread > 0;
                mine     = v['senderId'] == myId;
              }
            }
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
                          if (ts != null) Text(_timeStr(DateTime.fromMillisecondsSinceEpoch(ts)),
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
                                
                                child: typing
                                  ? Row(key: const ValueKey('t'), mainAxisSize: MainAxisSize.min, children: [
                                      _DotsLoader(small: true), const SizedBox(width: 6),
                                      Text('typing…', style: TextStyle(color: Gx.cyan, fontSize: 12, fontStyle: FontStyle.italic)),
                                    ])
                                  : Text(last, key: const ValueKey('m'), maxLines: 1, overflow: TextOverflow.ellipsis,
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
    decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(99),
      boxShadow: Gx.glow(Gx.violet, b: 8)),
    child: Text(count > 99 ? '99+' : count > 9 ? '$count' : '$count',
      style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800)),
  );
}

// ═══════════════════════════════════════════════════
//  FIND TAB
// ═══════════════════════════════════════════════════
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
            color: dark ? Gx.d4 : Gx.l2,
            borderRadius: BorderRadius.circular(14),
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
                    .startAt(_q.toLowerCase()).endAt('${_q.toLowerCase()}').onValue,
                builder: (ctx, snap) {
                  if (!snap.hasData) return const Center(child: _GaxSpinner());
                  // Also stream friends list to hide already-added users
                  return StreamBuilder(
                    stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
                    builder: (ctx, friendSnap) {
                      final friendIds = <String>{};
                      if (friendSnap.hasData && friendSnap.data!.snapshot.value != null) {
                        (friendSnap.data!.snapshot.value as Map? ?? {}).forEach((k, _) {
                          friendIds.add(k.toString());
                        });
                      }
                      // Also stream pending requests sent by me
                      return StreamBuilder(
                        stream: FirebaseDatabase.instance.ref('users/$myId/req').onValue,
                        builder: (ctx, reqSnap) {
                          final list = <Map>[];
                          (snap.data!.snapshot.value as Map?)?.forEach((k, v) {
                            if (v is Map) {
                              final uid = v['uid']?.toString() ?? '';
                              // Exclude: self, already friends
                              if (uid != myId && !friendIds.contains(uid)) {
                                list.add(Map<String,dynamic>.from(v));
                              }
                            }
                          });
                          if (list.isEmpty) return _emptyView(Icons.search_off_rounded, 'No Results', 'Try a different username');
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (ctx, i) {
                              // Check if request already sent
                              final uid = list[i]['uid']?.toString() ?? '';
                              final reqSent = reqSnap.hasData && reqSnap.data!.snapshot.value != null
                                  && (reqSnap.data!.snapshot.value as Map? ?? {}).containsKey(uid);
                              return _AnimatedListItem(index: i, child: _ContactRow(
                                u: list[i],
                                trailing: reqSent
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Gx.violet.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                                          Icon(Icons.check_rounded, size: 14, color: Gx.violet),
                                          const SizedBox(width: 4),
                                          Text('Sent', style: TextStyle(color: Gx.violet, fontSize: 12, fontWeight: FontWeight.w600)),
                                        ]),
                                      )
                                    : _GaxChip(label: 'Add', icon: Icons.person_add_alt_1_rounded,
                                        onTap: () {
                                          HapticFeedback.mediumImpact();
                                          FirebaseDatabase.instance.ref('users/$uid/req/$myId').set(true).catchError((_){});
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

// ═══════════════════════════════════════════════════
//  SOCIAL TAB
// ═══════════════════════════════════════════════════
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
                      onTap: () { HapticFeedback.lightImpact(); FirebaseDatabase.instance.ref('users/${widget.myId}/req/${e.value}').remove().catchError((_){}); }),
                    const SizedBox(width: 8),
                    _RoundBtn(icon: Icons.check_rounded, color: Gx.mint,
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        FirebaseDatabase.instance.ref('users/${widget.myId}/friends/${e.value}').set(true).catchError((_){});
                        FirebaseDatabase.instance.ref('users/${e.value}/friends/${widget.myId}').set(true).catchError((_){});
                        FirebaseDatabase.instance.ref('users/${widget.myId}/req/${e.value}').remove().catchError((_){});
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
            // ── Online Now strip ──────────────────────────
            _OnlineFriendsStrip(friendIds: ids, myId: widget.myId, dark: dark),
            // ── Full friends list ─────────────────────────
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
                          FirebaseDatabase.instance.ref('users/${widget.myId}/friends/${e.value}').remove().catchError((_){});
                          FirebaseDatabase.instance.ref('users/${e.value}/friends/${widget.myId}').remove().catchError((_){});
                          Navigator.pop(ctx);
                        })),
                  ]),
                ));
              },
            )).toList(),
          ]);
        },
      )),
    ]);
  }
}

// ═══════════════════════════════════════════════════
//  PROFILE TAB
// ═══════════════════════════════════════════════════
class ProfileTab extends StatelessWidget {
  final ThemeCtrl tc;
  const ProfileTab({super.key, required this.tc});

  @override
  Widget build(BuildContext ctx) {
    final myId = FirebaseAuth.instance.currentUser!.uid;
    final dark  = Theme.of(ctx).brightness == Brightness.dark;
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref('users/$myId').onValue,
      builder: (_, snap) {
        if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();
        final d = Map.from(snap.data!.snapshot.value as Map? ?? {});
        return CustomScrollView(slivers: [
          SliverToBoxAdapter(child: _ProfileHeader(d: d, dark: dark, onEdit: () => _editProfile(ctx, d))),
          SliverToBoxAdapter(child: Column(children: [
            const SizedBox(height: 12),
            _SectionLabel('APPEARANCE'),
            _PrefRow(
              icon: Icons.brightness_auto,
              iconGrad: const LinearGradient(colors: [Color(0xFF4B3ECC), Gx.violet]),
              title: 'Auto Theme',
              subtitle: tc.auto
                ? (tc.autoMode == AutoThemeMode.system ? "Follows phone's dark mode" : "Changes by time of day")
                : 'Manual',
              trailing: Switch.adaptive(value: tc.auto, onChanged: tc.setAuto, activeColor: Gx.violet,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
              dark: dark,
            ),
            AnimatedCrossFade(
              crossFadeState: tc.auto ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 220),
              firstChild: Column(children: [
                _PrefRow(
                  icon: Icons.phone_android_rounded,
                  iconGrad: const LinearGradient(colors: [Color(0xFF00509D), Color(0xFF00AAFF)]),
                  title: "Follow Phone's Mode",
                  subtitle: "Uses your phone's dark/light setting",
                  trailing: _RadioDot(selected: tc.autoMode == AutoThemeMode.system),
                  onTap: () => tc.setAutoMode(AutoThemeMode.system),
                  dark: dark,
                ),
                _PrefRow(
                  icon: Icons.schedule_rounded,
                  iconGrad: const LinearGradient(colors: [Color(0xFF805000), Gx.amber]),
                  title: 'Time-Based',
                  subtitle: 'Dark 7PM–6AM · Light otherwise',
                  trailing: _RadioDot(selected: tc.autoMode == AutoThemeMode.timeBased),
                  onTap: () => tc.setAutoMode(AutoThemeMode.timeBased),
                  dark: dark,
                ),
              ]),
              secondChild: _PrefRow(
                icon: Icons.dark_mode_rounded,
                iconGrad: const LinearGradient(colors: [Color(0xFF222260), Color(0xFF4B3ECC)]),
                title: 'Dark Mode',
                trailing: Switch.adaptive(value: tc.isDarkNow, onChanged: tc.setDark, activeColor: Gx.violet,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                dark: dark,
              ),
            ),
            _SectionLabel('ACCOUNT'),
            _PrefRow(icon: Icons.manage_accounts_outlined,
              iconGrad: const LinearGradient(colors: [Color(0xFF0080CC), Gx.cyan]),
              title: 'Edit Profile', onTap: () => _editProfile(ctx, d), dark: dark),
            _PrefRow(icon: Icons.notifications_outlined,
              iconGrad: const LinearGradient(colors: [Color(0xFF7B4F00), Gx.amber]),
              title: 'Notifications',
              subtitle: 'Message sounds & vibration',
              trailing: Switch.adaptive(
                value: true, onChanged: (_) {},
                activeColor: Gx.violet,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
              dark: dark),
            _PrefRow(icon: Icons.info_outline_rounded,
              iconGrad: const LinearGradient(colors: [Color(0xFF1E7D32), Gx.mint]),
              title: 'About GAX', onTap: () => _showAbout(ctx), dark: dark),
            _PrefRow(icon: Icons.logout_rounded,
              iconGrad: LinearGradient(colors: [Color(0xFF8B0020), Gx.rose]),
              title: 'Sign Out', titleColor: Gx.rose, dark: dark,
              onTap: () => _gaxDialog(ctx, title: 'Sign Out', body: 'Sign out from GAX Chats?',
                confirmLabel: 'Sign Out', confirmClr: Gx.rose,
                onConfirm: () { Navigator.pop(ctx); FirebaseAuth.instance.signOut(); })),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60),
              padding: const EdgeInsets.symmetric(vertical: 9),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Gx.violet.withOpacity(0.22))),
              child: Center(child: ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
                child: const Text('GAX  ·  v9.0  ·  GamerArnabXYZ',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)))),
            ),
            const SizedBox(height: 40),
          ])),
        ]);
      },
    );
  }

  void _editProfile(BuildContext ctx, Map d) {
    final n = TextEditingController(text: d['name']);
    final u = TextEditingController(text: d['username']);
    final b = TextEditingController(text: d['bio'] ?? '');
    final p = TextEditingController(text: d['pfp'] ?? '');
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, useSafeArea: true,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      builder: (c) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom + 24, left: 22, right: 22, top: 14),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(),
          const SizedBox(height: 16),
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
            FirebaseDatabase.instance.ref('users/${d['uid']}').update({
              'name': n.text.trim(), 'username': u.text.trim().toLowerCase(),
              'pfp': p.text.trim().isEmpty ? (d['pfp'] ?? '') : p.text.trim(),
              'bio': b.text.trim(),
            }).catchError((_){});
            Navigator.pop(c);
          }, child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
        ]),
      ),
    );
  }

  void _showAbout(BuildContext ctx) => showDialog(context: ctx, builder: (c) => _GaxAlertDialog(
    title: 'About GAX', body: 'GAX Chats — real-time messaging.\nFast. Secure. Yours.\n\nv9.0  ·  Built by GamerArnabXYZ\nArnabLabZ Studio\n\n✨ Features: Emoji reactions, message forward, URL sharing, online friends, real-time presence, smart unread counts.',
    confirmLabel: 'Close', confirmClr: Gx.violet, onConfirm: () => Navigator.pop(c),
  ));
}

class _ProfileHeader extends StatelessWidget {
  final Map d; final bool dark; final VoidCallback onEdit;
  const _ProfileHeader({required this.d, required this.dark, required this.onEdit});
  @override
  Widget build(BuildContext ctx) => Container(
    decoration: BoxDecoration(gradient: dark ? Gx.gHdr : Gx.gLHdr),
    child: SafeArea(bottom: false, child: Column(children: [
      const SizedBox(height: 28),
      GestureDetector(
        onTap: onEdit,
        child: Stack(alignment: Alignment.bottomRight, children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(shape: BoxShape.circle, gradient: Gx.gBrand, boxShadow: Gx.glow(Gx.violet, b: 26)),
            child: CircleAvatar(radius: 42, backgroundColor: Gx.d3,
              backgroundImage: NetworkImage(d['pfp'] ?? ''), onBackgroundImageError: (_, __) {}),
          ),
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(gradient: Gx.gBrand, shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2)),
            child: const Icon(Icons.edit_rounded, size: 14, color: Colors.white),
          ),
        ]),
      ),
      const SizedBox(height: 14),
      Text(d['name'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
      const SizedBox(height: 4),
      ShaderMask(shaderCallback: (r) => const LinearGradient(colors: [Colors.white, Color(0xFFBBAAFF)]).createShader(r),
        child: Text('@${d['username'] ?? ''}', style: const TextStyle(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w600))),
      if ((d['bio'] ?? '').isNotEmpty) ...[
        const SizedBox(height: 8),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text((d['bio'] ?? '').toString(), textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 13))),
      ],
      const SizedBox(height: 16),
      // ── Stats pills ──────────────────────────────
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
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.18)),
    ),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800)),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10.5, fontWeight: FontWeight.w500)),
    ]),
  );
}

// ═══════════════════════════════════════════════════
//  PROFILE DIALOG
// ═══════════════════════════════════════════════════
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
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
                decoration: BoxDecoration(
                  color: online ? Gx.live : Gx.away, shape: BoxShape.circle,
                  border: Border.all(color: dark ? Gx.d3 : Colors.white, width: 2.5),
                  boxShadow: online ? Gx.glow(Gx.live, b: 8) : [],
                ),
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
              decoration: BoxDecoration(
                color: online ? Gx.live.withOpacity(0.12) : (dark ? Gx.d4 : Gx.l2),
                borderRadius: BorderRadius.circular(20),
              ),
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

// ═══════════════════════════════════════════════════
//  CHAT ROOM
// ═══════════════════════════════════════════════════
class ChatRoom extends StatefulWidget {
  final Map target;
  const ChatRoom({super.key, required this.target});
  @override State<ChatRoom> createState() => _ChatState();
}
class _ChatState extends State<ChatRoom> with TickerProviderStateMixin {
  bool get dark => Theme.of(context).brightness == Brightness.dark;
  final _msgC  = TextEditingController();
  final _imgC  = TextEditingController();
  final _srcC  = TextEditingController();
  final _scroll= ScrollController();
  late final String chatId;
  final myId = FirebaseAuth.instance.currentUser!.uid;
  Timer? _typingTimer;
  late final _sendAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  Map? _replyMsg; bool _searching = false; String _srchQ = '';
  int _lastMsgCount = 0;
  Map? _pinMsg; String? _pinKey; bool _hasText = false;

  @override
  void initState() {
    super.initState();
    final ids = [myId, widget.target['uid']]..sort();
    chatId = ids.join('_');
    // Clean up typing indicator if app is force-killed
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').onDisconnect().set(false).catchError((_){});
    // Mark user online
    FirebaseDatabase.instance.ref('users/$myId/status').set('online').catchError((_){});
    FirebaseDatabase.instance.ref('users/$myId/status').onDisconnect().set('offline').catchError((_){});
    _markRead(); _loadPin(); _initChatMeta();
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
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((_){});
    // Write lastSeen timestamp on leave
    FirebaseDatabase.instance.ref('users/$myId/lastSeen')
        .set(ServerValue.timestamp).catchError((_){});
    super.dispose();
  }

  void _markRead() {
    FirebaseDatabase.instance.ref('messages/$chatId').get().then((s) {
      if (!mounted || s.value == null) return;
      final map = s.value as Map? ?? {};
      final Map<String, dynamic> updates = {};
      map.forEach((k, v) {
        final msg = v is Map ? v : {};
        if (msg['senderId'] != myId && msg['read'] != true)
          updates['messages/$chatId/$k/read'] = true;
      });
      if (updates.isNotEmpty)
        FirebaseDatabase.instance.ref().update(updates).catchError((_){});
      // Reset unread counter
      FirebaseDatabase.instance.ref('chats/$chatId/unread/$myId').set(0).catchError((_){});
    });
  }

  void _loadPin() => FirebaseDatabase.instance.ref('chats/$chatId/pinned').get().then((s) {
    if (!mounted || s.value == null) return;
    final key = s.value.toString();
    FirebaseDatabase.instance.ref('messages/$chatId/$key').get().then((ms) {
      if (!mounted || ms.value == null) return;
      if (ms.value is! Map) return;
      setState(() { _pinKey = key; _pinMsg = Map.from(ms.value as Map? ?? {}); });
    });
  });

  void _onTyping(String v) {
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(true).catchError((_){});
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () => FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((_){}));
  }

  void _toBottom() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      _scroll.animateTo(_scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
    });
  }

  Future<void> _send() async {
    final txt = _msgC.text.trim();
    if (txt.isEmpty) return;
    HapticFeedback.lightImpact();
    _msgC.clear(); _sendAc.forward(from: 0);
    FirebaseDatabase.instance.ref('typing/$chatId/$myId').set(false).catchError((_){});
    final payload = <String, dynamic>{
      'senderId': myId, 'text': txt, 'timestamp': ServerValue.timestamp, 'read': false, 'type': 'text',
    };
    if (_replyMsg != null) {
      payload['replyTo'] = { 'text': _replyMsg!['text'], 'senderId': _replyMsg!['senderId'], 'type': _replyMsg!['type'] ?? 'text' };
      if (mounted) setState(() => _replyMsg = null);
    }
    await FirebaseDatabase.instance.ref('messages/$chatId').push().set(payload);
    await _saveChatMeta('text', txt);
    if (!mounted) return;
    _markRead(); _toBottom();
  }

  Future<void> _sendImg() async {
    final url = _imgC.text.trim();
    if (url.isEmpty) return;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid image URL (http/https)'),
        behavior: SnackBarBehavior.floating));
      return;
    }
    _imgC.clear();
    if (!mounted) return;
    Navigator.pop(context);
    await FirebaseDatabase.instance.ref('messages/$chatId').push().set({
      'senderId': myId, 'text': url, 'timestamp': ServerValue.timestamp, 'read': false, 'type': 'image',
    });
    await _saveChatMeta('image', url);
    if (!mounted) return;
    _toBottom();
  }

  Future<void> _saveChatMeta(String type, String text) async {
    final raw     = type == 'image' ? '📷 Image' : type == 'link' ? '🔗 Link' : text.trim();
    final preview  = raw.length > 80 ? '\${raw.substring(0, 80)}…' : raw;
    final otherUid = widget.target['uid'].toString();
    // Batch write: meta + members + unread increment
    await FirebaseDatabase.instance.ref().update({
      'chats/$chatId/members/$myId': true,
      'chats/$chatId/members/$otherUid': true,
      'chats/$chatId/lastMsg': preview,
      'chats/$chatId/lastMsgType': type,
      'chats/$chatId/lastMsgSender': myId,
      'chats/$chatId/lastTs': ServerValue.timestamp,
      'chats/$chatId/updatedAt': ServerValue.timestamp,
    });
    // Atomic unread increment for receiver (no race condition)
    FirebaseDatabase.instance.ref('chats/$chatId/unread/$otherUid')
        .set(ServerValue.increment(1)).catchError((_){});
  }

  void _initChatMeta() {
    FirebaseDatabase.instance.ref('chats/$chatId/members').update({
      myId: true,
      widget.target['uid'].toString(): true,
    }).catchError((_) {}); // silent fail - non-critical
  }

  // ── Forward message to a friend ─────────────────
  void _showForwardSheet(Map msg) {
    final fwdText = msg['type'] == 'image' ? msg['text'] : (msg['text'] ?? '');
    final fwdType = msg['type'] ?? 'text';
    showModalBottomSheet(
      context: context,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(),
          const SizedBox(height: 10),
          Text('Forward to…', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref('users/$myId/friends').onValue,
              builder: (_, snap) {
                if (!snap.hasData || snap.data!.snapshot.value == null)
                  return Center(child: Text('No friends yet', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L)));
                final ids = (snap.data!.snapshot.value as Map? ?? {}).keys.map((k) => k.toString()).toList();
                return ListView.builder(
                  itemCount: ids.length,
                  itemBuilder: (_, i) => StreamBuilder(
                    stream: FirebaseDatabase.instance.ref('users/${ids[i]}').onValue,
                    builder: (_, uSnap) {
                      if (!uSnap.hasData || uSnap.data!.snapshot.value == null) return const SizedBox();
                      final u = Map<String,dynamic>.from(uSnap.data!.snapshot.value as Map? ?? {});
                      final toChatId = ([myId, ids[i]]..sort()).join('_');
                      return _TapScale(
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          final payload = <String,dynamic>{
                            'senderId': myId, 'text': fwdText,
                            'timestamp': ServerValue.timestamp, 'read': false,
                            'type': fwdType, 'forwarded': true,
                          };
                          await FirebaseDatabase.instance.ref('messages/$toChatId').push().set(payload);
                          await FirebaseDatabase.instance.ref('chats/$toChatId/members').update({myId: true, ids[i]: true});
                          await FirebaseDatabase.instance.ref('chats/$toChatId').update({
                            'lastMsg': fwdType == 'image' ? '📷 Image' : (fwdText.length > 80 ? fwdText.substring(0,80) : fwdText),
                            'lastMsgType': fwdType, 'lastMsgSender': myId,
                            'lastTs': ServerValue.timestamp, 'updatedAt': ServerValue.timestamp,
                          });
                          if (mounted) Navigator.pop(c);
                          if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Forwarded to ${u['name']}'),
                            behavior: SnackBarBehavior.floating, duration: const Duration(seconds: 2)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: Row(children: [
                            _Avi(pfp: u['pfp'] ?? '', online: u['status'] == 'online', radius: 22),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(u['name'] ?? '', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontWeight: FontWeight.w700, fontSize: 14)),
                              Text('@${u['username'] ?? ''}', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12)),
                            ])),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(20)),
                              child: const Text('Send', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ]),
      )),
    );
  }

  // ── Send URL as link type ─────────────────────
  Future<void> _sendLink(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) return;
    HapticFeedback.lightImpact();
    final payload = <String,dynamic>{
      'senderId': myId, 'text': url,
      'timestamp': ServerValue.timestamp, 'read': false, 'type': 'link',
    };
    await FirebaseDatabase.instance.ref('messages/$chatId').push().set(payload);
    await _saveChatMeta('link', '🔗 $url');
    if (!mounted) return;
    _markRead(); _toBottom();
  }

  void _emojiSheet() {
    const emojis = [
      '😀','😂','🥰','😎','🤔','😭','🙏','🔥',
      '💯','❤️','💜','💙','✨','🎉','👏','👀',
      '😅','🤣','😍','🥺','😤','😴','🤗','😇',
      '💪','🫡','🙌','🫶','🤝','👋','✌️','🤙',
      '🍕','🎮','🚀','💎','🏆','🎯','⚡','🌟',
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 10),
          Text('Emoji', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6, runSpacing: 6,
            children: emojis.map((e) => _TapScale(
              onTap: () {
                Navigator.pop(c);
                _msgC.text = _msgC.text + e;
                _msgC.selection = TextSelection.collapsed(offset: _msgC.text.length);
              },
              child: Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color: dark ? Gx.d5 : Gx.l2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(e, style: const TextStyle(fontSize: 22))),
              ),
            )).toList(),
          ),
          const SizedBox(height: 8),
        ]),
      )),
    );
  }

  void _chatMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 8),
          _ActionRow(icon: Icons.person_outline_rounded, color: Gx.violet,
            label: 'View Profile',
            onTap: () {
              Navigator.pop(c);
              showDialog(context: context,
                builder: (_) => ProfileDialog(user: widget.target));
            }, dark: dark),
          _ActionRow(icon: Icons.push_pin_outlined, color: Gx.indigo,
            label: _pinMsg != null ? 'Unpin Message' : 'No Pinned Message',
            onTap: _pinMsg != null ? () {
              FirebaseDatabase.instance.ref('chats/$chatId/pinned').remove().catchError((_){});
              setState(() { _pinKey = null; _pinMsg = null; });
              Navigator.pop(c);
            } : null, dark: dark),
          _ActionRow(icon: Icons.cleaning_services_outlined, color: Gx.amber,
            label: 'Clear Chat',
            onTap: () {
              Navigator.pop(c);
              _gaxDialog(context, title: 'Clear Chat',
                body: 'Delete all messages? This cannot be undone.',
                confirmLabel: 'Clear', confirmClr: Gx.rose,
                onConfirm: () {
                  FirebaseDatabase.instance.ref('messages/$chatId').remove().catchError((_){});
                  FirebaseDatabase.instance.ref('chats/$chatId/lastMsg').set('').catchError((_){});
                  Navigator.pop(context);
                });
            }, dark: dark),
          _ActionRow(icon: Icons.block_rounded, color: Gx.rose,
            label: 'Unfriend & Remove',
            onTap: () {
              Navigator.pop(c);
              _gaxDialog(context, title: 'Unfriend',
                body: 'Remove ${widget.target['name']} from friends?',
                confirmLabel: 'Remove', confirmClr: Gx.rose,
                onConfirm: () {
                  final otherUid = widget.target['uid'].toString();
                  FirebaseDatabase.instance.ref('users/$myId/friends/$otherUid').remove().catchError((_){});
                  FirebaseDatabase.instance.ref('users/$otherUid/friends/$myId').remove().catchError((_){});
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
            }, dark: dark),
        ]),
      )),
    );
  }

  void _linkSheet() {
    final lctrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(c).viewInsets.bottom + 20, left: 20, right: 20, top: 14),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(), const SizedBox(height: 14),
          Text('Share a Link', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          _GaxField(ctrl: lctrl, hint: 'Paste URL here…', icon: Icons.link_rounded,
            type: TextInputType.url, dark: dark),
          const SizedBox(height: 16),
          _GaxBtn(onTap: () async {
            final url = lctrl.text.trim();
            Navigator.pop(c);
            lctrl.dispose();
            await _sendLink(url);
          }, child: const Text('Send Link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15))),
        ]),
      ),
    );
  }

  void _imgSheet() {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      backgroundColor: dark ? Gx.d4 : Colors.white,
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

  void _quickReact(String key) {
    HapticFeedback.mediumImpact();
    FirebaseDatabase.instance.ref('messages/$chatId/$key/reactions/$myId').set('❤️').catchError((_){});
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('❤️ Reacted!'), behavior: SnackBarBehavior.floating, duration: Duration(milliseconds: 800)));
  }

  void _msgActions(String key, Map msg, bool isMe) {
    HapticFeedback.mediumImpact();
    final dark = Theme.of(context).brightness == Brightness.dark;
    const emojis = ['❤️', '😂', '👍', '😮', '😢', '🔥'];
    showModalBottomSheet(
      context: context,
      backgroundColor: dark ? Gx.d4 : Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (c) => SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _SheetHandle(),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: emojis.map((e) => _TapScale(
            onTap: () {
              HapticFeedback.lightImpact();
              FirebaseDatabase.instance.ref('messages/$chatId/$key/reactions/$myId').set(e).catchError((_){});
              Navigator.pop(c);
            },
            child: Container(
              width: 50, height: 50,
              decoration: BoxDecoration(color: dark ? Gx.d5 : Gx.l2, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Gx.violet.withOpacity(0.15))),
              child: Center(child: Text(e, style: const TextStyle(fontSize: 24))),
            ),
          )).toList()),
          const SizedBox(height: 8),
          Divider(color: dark ? Gx.divD : Gx.divL),
          _ActionRow(icon: Icons.reply_rounded, color: Gx.violet, label: 'Reply',
            onTap: () { setState(() => _replyMsg = msg); Navigator.pop(c); }, dark: dark),
          _ActionRow(icon: Icons.forward_rounded, color: Gx.mint, label: 'Forward',
            onTap: () {
              Navigator.pop(c);
              _showForwardSheet(msg);
            }, dark: dark),
          _ActionRow(icon: Icons.copy_rounded, color: Gx.cyan, label: 'Copy Text',
            onTap: () {
              Clipboard.setData(ClipboardData(text: msg['text'] ?? ''));
              Navigator.pop(c);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Copied to clipboard'), behavior: SnackBarBehavior.floating, duration: Duration(seconds: 1)));
            }, dark: dark),
          if (isMe) _ActionRow(icon: Icons.push_pin_outlined, color: Gx.indigo, label: 'Pin Message',
            onTap: () {
              FirebaseDatabase.instance.ref('chats/$chatId/pinned').set(key).catchError((_){});
              setState(() { _pinKey = key; _pinMsg = msg; }); Navigator.pop(c);
            }, dark: dark),
          if (isMe) _ActionRow(icon: Icons.delete_outline_rounded, color: Gx.rose, label: 'Delete',
            onTap: () {
              FirebaseDatabase.instance.ref('messages/$chatId/$key').remove().catchError((_){});
              // Clear pin if this message was pinned
              if (_pinKey == key) {
                FirebaseDatabase.instance.ref('chats/$chatId/pinned').remove().catchError((_){});
                setState(() { _pinKey = null; _pinMsg = null; });
              }
              Navigator.pop(c);
            }, dark: dark),
        ]),
      )),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    final dark   = Theme.of(ctx).brightness == Brightness.dark;
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
                    stream: FirebaseDatabase.instance.ref("users/${widget.target['uid']}").onValue,
                    builder: (_, stSnap) {
                      final d = stSnap.hasData && stSnap.data!.snapshot.value != null
                          ? Map<String,dynamic>.from(stSnap.data!.snapshot.value as Map? ?? {}) : <String,dynamic>{};
                      final st  = d['status']?.toString();
                      final lsRaw = d['lastSeen'];
                      final online = st == 'online';
                      String subtitle;
                      if (online) {
                        subtitle = '● online';
                      } else if (lsRaw != null) {
                        final lsDt = DateTime.fromMillisecondsSinceEpoch(
                            lsRaw is int ? lsRaw : int.tryParse(lsRaw.toString()) ?? 0);
                        final diff = DateTime.now().difference(lsDt);
                        if (diff.inMinutes < 1)       subtitle = 'last seen just now';
                        else if (diff.inMinutes < 60) subtitle = 'last seen ${diff.inMinutes}m ago';
                        else if (diff.inHours < 24)   subtitle = 'last seen ${diff.inHours}h ago';
                        else if (diff.inDays == 1)     subtitle = 'last seen yesterday';
                        else                           subtitle = 'last seen ${diff.inDays}d ago';
                      } else {
                        subtitle = 'offline';
                      }
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(subtitle, key: ValueKey(subtitle),
                          style: TextStyle(
                            color: online ? Gx.live.withOpacity(0.9) : Colors.white54,
                            fontSize: 11.5)),
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
            controller: _srcC, autofocus: true,
            onChanged: (v) => setState(() => _srchQ = v.toLowerCase()),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: const InputDecoration(
              hintText: 'Search…', hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none, filled: false, contentPadding: EdgeInsets.symmetric(vertical: 8)),
          )),
          IconButton(
            icon: AnimatedSwitcher(duration: const Duration(milliseconds: 200),
              child: Icon(_searching ? Icons.close_rounded : Icons.search_rounded,
                key: ValueKey(_searching), color: Colors.white, size: 21)),
            onPressed: () => setState(() { _searching = !_searching; _srchQ = ''; _srcC.clear(); }),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 21),
            onPressed: () => _chatMoreMenu(),
          ),
        ],
      ),
      body: Column(children: [
        if (_pinMsg != null) _PinBanner(
          text: _pinMsg!['type'] == 'image' ? '📷 Image' : (_pinMsg!['text'] ?? ''),
          onDismiss: () { FirebaseDatabase.instance.ref('chats/$chatId/pinned').remove().catchError((_){}); setState(() { _pinKey = null; _pinMsg = null; }); },
          dark: dark,
        ),
        Expanded(child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('messages/$chatId').onValue,
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
              '_key': e.key.toString(), ...Map<String, dynamic>.from(e.value as Map? ?? {}),
            }).toList();
            msgs.sort((a, b) => ((a['timestamp'] ?? 0) as num).compareTo((b['timestamp'] ?? 0) as num));
            if (_srchQ.isNotEmpty) msgs = msgs.where((m) => (m['text'] ?? '').toString().toLowerCase().contains(_srchQ)).toList();
            if (msgs.length != _lastMsgCount) {
              _lastMsgCount = msgs.length;
              _toBottom();
            }
            return ListView.builder(
              controller: _scroll,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: msgs.length,
              itemBuilder: (ctx, i) {
                final m  = msgs[i]; final isMe = m['senderId'] == myId;
                final ts = m['timestamp'] is int ? DateTime.fromMillisecondsSinceEpoch(m['timestamp'] as int) : DateTime.now();
                final prevTs = i > 0 && msgs[i-1]['timestamp'] is int
                    ? DateTime.fromMillisecondsSinceEpoch(msgs[i-1]['timestamp'] as int) : null;
                return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  if (prevTs == null || !_sameDay(prevTs, ts)) _DateChip(ts, dark),
                  _BubbleEntry(isMe: isMe, child: _BubbleWidget(
                    msg: m, isMe: isMe, ts: ts, myId: myId, dark: dark,
                    onLongPress: () => _msgActions(m['_key'] as String, m, isMe),
                    onDoubleTap: () => _quickReact(m['_key'] as String),
                  )),
                ]);
              },
            );
          },
        )),
        if (_replyMsg != null) _ReplyBar(msg: _replyMsg!, myId: myId, onCancel: () => setState(() => _replyMsg = null), dark: dark),
        _MsgInput(ctrl: _msgC, hasText: _hasText, dark: dark, sendAc: _sendAc, onTyping: _onTyping, onSend: _send, onImage: _imgSheet, onLink: _linkSheet, onEmoji: _emojiSheet),
      ]),
    );
  }

  bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
}

// BUBBLE ENTRY
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

// BUBBLE
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
            if (msg['reactions'] is Map) _Reactions(r: Map<String,dynamic>.from(msg['reactions'] as Map)),
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
      if (msg['replyTo'] is Map) _ReplyPreview(reply: Map<String,dynamic>.from(msg['replyTo'] as Map), myId: myId, isMe: isMe, dark: dark),
      if (msg['forwarded'] == true)
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.forward_rounded, size: 12, color: isMe ? Colors.white54 : Gx.tx2),
            const SizedBox(width: 3),
            Text('Forwarded', style: TextStyle(fontSize: 10.5, color: isMe ? Colors.white54 : Gx.tx2, fontStyle: FontStyle.italic)),
          ]),
        ),
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
              child: Icon(
                msg['read'] == true ? Icons.done_all_rounded : Icons.done_rounded,
                key: ValueKey(msg['read']),
                size: 14,
                color: msg['read'] == true ? Gx.readClr : Gx.tx2,
              ),
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
            : (rt.startsWith('http') || rt.startsWith('www')) ? '🔗 ${rt.length > 35 ? rt.substring(0, 35) + '…' : rt}'
            : rt;
        return Text(preview,
          maxLines: 1, overflow: TextOverflow.ellipsis,
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
      errorBuilder: (c, e, s) => const SizedBox(width: 230, height: 80,
        child: Center(child: Icon(Icons.broken_image_outlined, color: Gx.tx2)))),
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
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Wrap(spacing: 4, runSpacing: 4, children: counts.entries.map((e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: dark ? Gx.d5 : Gx.l2, borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Gx.violet.withOpacity(0.22))),
        child: Text('${e.key} ${e.value}', style: const TextStyle(fontSize: 12)),
      )).toList()),
    );
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
      border: Border(
        bottom: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6),
        left: const BorderSide(color: Gx.violet, width: 3),
      ),
    ),
    child: Row(children: [
      ShaderMask(shaderCallback: (r) => Gx.gBrand.createShader(r),
        child: const Icon(Icons.push_pin_rounded, size: 13, color: Colors.white)),
      const SizedBox(width: 8),
      Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis,
        style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12.5))),
      GestureDetector(onTap: onDismiss,
        child: Icon(Icons.close_rounded, size: 15, color: dark ? Gx.tx2 : Gx.tx2L)),
    ]),
  );
}

class _ReplyBar extends StatelessWidget {
  final Map msg; final String myId; final VoidCallback onCancel; final bool dark;
  const _ReplyBar({required this.msg, required this.myId, required this.onCancel, required this.dark});
  @override
  Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.fromLTRB(16, 9, 8, 9),
    decoration: BoxDecoration(color: dark ? Gx.d3 : Gx.l2,
      border: Border(top: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6))),
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
              : (pt.startsWith('http') || pt.startsWith('www')) ? '🔗 Link'
              : pt;
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
    decoration: BoxDecoration(
      color: dark ? Gx.d2 : Colors.white,
      border: Border(top: BorderSide(color: dark ? Gx.divD : Gx.divL, width: 0.6)),
    ),
    child: SafeArea(top: false, child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      _TapScale(
        onTap: onImage,
        child: Container(
          width: 40, height: 40, margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: dark ? Gx.d4 : Gx.l2,
            border: Border.all(color: dark ? Gx.divD : Gx.divL, width: 0.8)),
          child: Icon(Icons.image_outlined, size: 19, color: dark ? Gx.tx2 : Gx.tx2L),
        ),
      ),
      const SizedBox(width: 6),
      _TapScale(
        onTap: onEmoji,
        child: Container(
          width: 40, height: 40, margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: dark ? Gx.d4 : Gx.l2,
            border: Border.all(color: dark ? Gx.divD : Gx.divL, width: 0.8)),
          child: const Text('😊', style: TextStyle(fontSize: 20)),
        ),
      ),
      const SizedBox(width: 6),
      _TapScale(
        onTap: onLink,
        child: Container(
          width: 40, height: 40, margin: const EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(shape: BoxShape.circle,
            color: dark ? Gx.d4 : Gx.l2,
            border: Border.all(color: dark ? Gx.divD : Gx.divL, width: 0.8)),
          child: Icon(Icons.link_rounded, size: 19, color: dark ? Gx.tx2 : Gx.tx2L),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(child: Container(
        constraints: const BoxConstraints(minHeight: 44),
        decoration: BoxDecoration(
          color: dark ? Gx.d4 : Gx.l2,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Gx.violet.withOpacity(dark ? 0.20 : 0.15)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const SizedBox(width: 14),
          Expanded(child: TextField(
            controller: ctrl, onChanged: onTyping, maxLines: 5, minLines: 1,
            style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 15),
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              hintText: 'Message…', border: InputBorder.none,
              enabledBorder: InputBorder.none, focusedBorder: InputBorder.none,
              filled: false, contentPadding: const EdgeInsets.symmetric(vertical: 11),
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasText ? Gx.gBrand : null,
              color: hasText ? null : (dark ? Gx.d4 : Gx.l2),
              boxShadow: hasText ? Gx.glow(Gx.violet, b: 16) : [],
            ),
            child: Icon(hasText ? Icons.send_rounded : Icons.mic_rounded,
              size: 20, color: hasText ? Colors.white : (dark ? Gx.tx2 : Gx.tx2L)),
          ),
        ),
      ),
    ])),
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
      color: dark ? Gx.d5.withOpacity(0.9) : Gx.l3,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: dark ? Gx.violet.withOpacity(0.18) : Gx.divL),
    ),
    child: Text(_label(), style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11.5, fontWeight: FontWeight.w500)),
  ));
}

class _ActionRow extends StatelessWidget {
  final IconData icon; final Color color; final String label; final VoidCallback? onTap; final bool dark;
  const _ActionRow({required this.icon, required this.color, required this.label, this.onTap, required this.dark});
  @override
  Widget build(BuildContext ctx) => ListTile(
    dense: true, onTap: onTap,
    leading: Container(
      width: 32, height: 32,
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, color: color, size: 17)),
    title: Text(label, style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L, fontSize: 14, fontWeight: FontWeight.w500)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}

// ═══════════════════════════════════════════════════
//  REUSABLE ATOMS
// ═══════════════════════════════════════════════════

class _AnimatedListItem extends StatefulWidget {
  final Widget child; final int index;
  const _AnimatedListItem({required this.child, required this.index});
  @override State<_AnimatedListItem> createState() => _AnimatedListItemState();
}
class _AnimatedListItemState extends State<_AnimatedListItem> with SingleTickerProviderStateMixin {
  late final _ac = AnimationController(vsync: this, duration: const Duration(milliseconds: 340))..forward();
  late final _fade  = CurvedAnimation(parent: _ac, curve: Curves.easeOut);
  late final _slide = Tween<Offset>(begin: const Offset(0, 0.13), end: Offset.zero)
      .animate(CurvedAnimation(parent: _ac, curve: Curves.easeOutCubic));
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
    onTapUp: (_) { _ac.forward(); widget.onTap?.call(); },
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
    final bg       = Theme.of(ctx).scaffoldBackgroundColor;
    final hasPfp   = pfp.isNotEmpty && (pfp.startsWith('http://') || pfp.startsWith('https://'));
    final imgProv  = hasPfp ? NetworkImage(pfp) as ImageProvider : null;
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
  Widget build(BuildContext ctx) {
    // Uses logo.png from assets/logo.png if present, fallback to gradient icon
    return SizedBox(
      width: size, height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.26),
        child: Image.asset(
          'assets/logo.png',
          width: size, height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: size, height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.26),
              gradient: Gx.gBrand,
              boxShadow: Gx.glow(Gx.violet, b: 24),
            ),
            child: Icon(Icons.bolt_rounded, size: size * 0.56, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _BrandText extends StatelessWidget {
  final String text; final double size; final double spacing;
  const _BrandText(this.text, {required this.size, required this.spacing});
  @override
  Widget build(BuildContext ctx) => ShaderMask(
    shaderCallback: (r) => Gx.gBrand.createShader(r),
    child: Text(text, style: TextStyle(color: Colors.white, fontSize: size, fontWeight: FontWeight.w900, letterSpacing: spacing)),
  );
}

class _GaxField extends StatelessWidget {
  final TextEditingController? ctrl;
  final String hint; final IconData? icon;
  final TextInputType? type; final bool obscure, dark;
  final Widget? suffix; final int? maxLines;
  final ValueChanged<String>? onChanged;
  const _GaxField({this.ctrl, required this.hint, this.icon, this.type,
    this.obscure = false, this.suffix, this.maxLines, required this.dark, this.onChanged});

  @override
  Widget build(BuildContext ctx) {
    final textClr  = dark ? Gx.tx1  : Gx.tx1L;
    final hintClr  = dark ? Gx.tx2  : Gx.tx2L;
    final iconClr  = dark ? Gx.tx2  : Gx.tx2L;
    final fillClr  = dark ? Gx.d4   : Gx.l2;
    final focusBdr = BorderSide(color: Gx.violet, width: 1.6);
    final radius   = BorderRadius.circular(14);
    return TextField(
      controller: ctrl, keyboardType: type,
      obscureText: obscure, maxLines: obscure ? 1 : (maxLines ?? 1),
      onChanged: onChanged,
      cursorColor: Gx.violet,
      style: TextStyle(color: textClr, fontSize: 15, height: 1.4),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintClr, fontSize: 14),
        filled: true,
        fillColor: fillClr,
        border:        OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: radius, borderSide: focusBdr),
        prefixIcon: icon != null ? Icon(icon, size: 18, color: iconClr) : null,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
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
          boxShadow: onTap != null ? Gx.glow(Gx.violet, b: 18) : [],
        ),
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
    child: Container(
      width: 36, height: 36,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.12), border: Border.all(color: color.withOpacity(0.28))),
      child: Icon(icon, size: 17, color: color),
    ),
  );
}

class _ContactRow extends StatelessWidget {
  final Map u; final Widget? trailing; final VoidCallback? onTap;
  const _ContactRow({required this.u, this.trailing, this.onTap});
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      splashColor: Gx.violet.withOpacity(0.07),
      highlightColor: Gx.violet.withOpacity(0.04),
      child: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
          child: Row(children: [
            _Avi(pfp: u['pfp'] ?? '', online: u['status'] == 'online', radius: 24),
            const SizedBox(width: 13),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(u['name'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.5, color: dark ? Gx.tx1 : Gx.tx1L)),
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
  final String? subtitle;
  final Color? titleColor; final Widget? trailing; final VoidCallback? onTap; final bool dark;
  const _PrefRow({required this.icon, required this.iconGrad, required this.title,
    required this.dark, this.subtitle, this.titleColor, this.trailing, this.onTap});
  @override
  Widget build(BuildContext ctx) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    leading: Container(
      width: 38, height: 38,
      decoration: BoxDecoration(gradient: iconGrad, borderRadius: BorderRadius.circular(11), boxShadow: Gx.glow(Gx.violet, b: 8, s: -2)),
      child: Icon(icon, size: 19, color: Colors.white),
    ),
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
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: selected ? Gx.gBrand : null,
      border: Border.all(
        color: selected ? Colors.transparent : Gx.tx2,
        width: 2,
      ),
      boxShadow: selected ? Gx.glow(Gx.violet, b: 8, s: -2) : [],
    ),
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
    decoration: BoxDecoration(
      color: Gx.d3.withOpacity(0.9),
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: Gx.violet.withOpacity(0.20), width: 1),
      boxShadow: Gx.glow(Gx.violet, b: 44, s: -6),
    ),
    child: child,
  );
}

class _GradientBar extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) => Container(
    height: 3.5, width: 52, margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(gradient: Gx.gBrand, borderRadius: BorderRadius.circular(2)),
  );
}

// ── FindTab empty state — show own @username ──────
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
            ? Map<String,dynamic>.from(snap.data!.snapshot.value as Map? ?? {}) : <String,dynamic>{};
        final username = d['username'] ?? '';
        return Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(gradient: Gx.gBrand2, borderRadius: BorderRadius.circular(22),
                boxShadow: Gx.glow(Gx.violet, b: 24)),
              child: const Icon(Icons.person_search_rounded, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            Text('Find People', style: TextStyle(color: dark ? Gx.tx1 : Gx.tx1L,
              fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('Search by @username above to add friends',
              textAlign: TextAlign.center,
              style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 13.5)),
            if (username.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Share your username', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 12)),
              const SizedBox(height: 8),
              _TapScale(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '@$username'));
                  ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                    content: Text('Username copied to clipboard!'),
                    behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2)));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  decoration: BoxDecoration(
                    gradient: Gx.gBrand,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: Gx.glow(Gx.violet, b: 14)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.alternate_email_rounded, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text('@$username', style: const TextStyle(color: Colors.white, fontSize: 15,
                      fontWeight: FontWeight.w800, letterSpacing: 0.3)),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy_rounded, color: Colors.white70, size: 14),
                  ]),
                ),
              ),
              const SizedBox(height: 8),
              Text('Tap to copy & share', style: TextStyle(color: dark ? Gx.tx3 : Gx.tx3L, fontSize: 11)),
            ],
          ]),
        ));
      },
    );
  }
}

// ── Online Friends Horizontal Strip ────────────────
class _OnlineFriendsStrip extends StatelessWidget {
  final List<String> friendIds;
  final String myId;
  final bool dark;
  const _OnlineFriendsStrip({required this.friendIds, required this.myId, required this.dark});

  @override
  Widget build(BuildContext ctx) {
    if (friendIds.isEmpty) return const SizedBox();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _SectionLabel('ONLINE NOW'),
      SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
          itemCount: friendIds.length,
          itemBuilder: (_, i) => StreamBuilder(
            stream: FirebaseDatabase.instance.ref('users/${friendIds[i]}').onValue,
            builder: (_, snap) {
              if (!snap.hasData || snap.data!.snapshot.value == null) return const SizedBox();
              final u = Map<String,dynamic>.from(snap.data!.snapshot.value as Map? ?? {});
              final online = u['status'] == 'online';
              if (!online) return const SizedBox();
              return _TapScale(
                onTap: () => _gaxPush(ctx, ChatRoom(target: u)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _Avi(pfp: u['pfp'] ?? '', online: true, radius: 28),
                    const SizedBox(height: 6),
                    SizedBox(width: 62, child: Text(
                      u['name'] ?? '',
                      maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                        color: dark ? Gx.tx1 : Gx.tx1L),
                    )),
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}

// ── URL Link Embed in chat bubble ──────────────────
// ═══════════════════════════════════════════════════
//  AUTO CONTENT — smart URL + image detector
// ═══════════════════════════════════════════════════
class _AutoContent extends StatelessWidget {
  final String text;
  final Color tx;
  final bool isMe, dark;
  const _AutoContent({required this.text, required this.tx, required this.isMe, required this.dark});

  // Image extensions — auto-embed
  static const _imgExts = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp', '.svg'];

  // URL regex — detects http://, https://, www.
  static final _urlRegex = RegExp(
    r'(https?://[^\s]+|www\.[^\s]+)',
    caseSensitive: false,
  );

  bool _isImageUrl(String url) {
    final lower = url.toLowerCase().split('?').first; // ignore query params
    return _imgExts.any((ext) => lower.endsWith(ext));
  }

  String _ensureScheme(String url) =>
      url.startsWith('http') ? url : 'https://$url';

  @override
  Widget build(BuildContext ctx) {
    // If no URL found → plain text
    if (!_urlRegex.hasMatch(text)) {
      return Text(text, style: TextStyle(color: tx, fontSize: 15.5, height: 1.45));
    }

    // Split text into segments
    final segments = <_Segment>[];
    int lastEnd = 0;
    for (final match in _urlRegex.allMatches(text)) {
      // Text before URL
      if (match.start > lastEnd) {
        segments.add(_Segment(text.substring(lastEnd, match.start), _SegType.text));
      }
      final url = _ensureScheme(match.group(0)!);
      if (_isImageUrl(url)) {
        segments.add(_Segment(url, _SegType.image));
      } else {
        segments.add(_Segment(url, _SegType.link));
      }
      lastEnd = match.end;
    }
    // Remaining text after last URL
    if (lastEnd < text.length) {
      segments.add(_Segment(text.substring(lastEnd), _SegType.text));
    }

    // If only ONE segment and it's a pure image — render full-width
    if (segments.length == 1 && segments.first.type == _SegType.image) {
      return _AutoImageEmbed(url: segments.first.content, isMe: isMe, dark: dark);
    }
    if (segments.length == 1 && segments.first.type == _SegType.link) {
      return _LinkEmbed(url: segments.first.content, isMe: isMe, dark: dark);
    }

    // Mixed content — build column
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: segments.map((seg) {
        switch (seg.type) {
          case _SegType.text:
            final trimmed = seg.content.trim();
            if (trimmed.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(trimmed, style: TextStyle(color: tx, fontSize: 15.5, height: 1.45)),
            );
          case _SegType.image:
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _AutoImageEmbed(url: seg.content, isMe: isMe, dark: dark),
            );
          case _SegType.link:
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _LinkEmbed(url: seg.content, isMe: isMe, dark: dark),
            );
        }
      }).toList(),
    );
  }
}

enum _SegType { text, image, link }

class _Segment {
  final String content;
  final _SegType type;
  const _Segment(this.content, this.type);
}

// Auto-detected image embed (no button needed)
class _AutoImageEmbed extends StatelessWidget {
  final String url;
  final bool isMe, dark;
  const _AutoImageEmbed({required this.url, required this.isMe, required this.dark});

  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.network(
            url,
            width: 220, height: 180,
            fit: BoxFit.cover,
            cacheWidth: 440,
            loadingBuilder: (c, ch, p) => p == null ? ch
                : Container(width: 220, height: 180,
                    decoration: BoxDecoration(
                      color: isMe ? Colors.white.withOpacity(0.08) : (dark ? Gx.d4 : Gx.l2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                      _GaxSpinner(),
                      const SizedBox(height: 6),
                      Text('Loading image…', style: TextStyle(
                        color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11)),
                    ]))),
            errorBuilder: (c, e, s) => Container(
              width: 220, height: 70,
              decoration: BoxDecoration(
                color: isMe ? Colors.white.withOpacity(0.08) : (dark ? Gx.d4 : Gx.l2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.broken_image_outlined, color: Gx.tx2, size: 26),
                const SizedBox(height: 4),
                Text('Could not load image', style: TextStyle(
                  color: dark ? Gx.tx2 : Gx.tx2L, fontSize: 11)),
              ]),
            ),
          ),
          // Small "auto detected" label
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.auto_awesome_rounded, size: 10, color: Colors.white70),
              SizedBox(width: 3),
              Text('Auto', style: TextStyle(color: Colors.white70, fontSize: 9.5,
                fontWeight: FontWeight.w600)),
            ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkEmbed extends StatelessWidget {
  final String url;
  final bool isMe, dark;
  const _LinkEmbed({required this.url, required this.isMe, required this.dark});

  String get _domain {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (_) { return url; }
  }

  @override
  Widget build(BuildContext ctx) {
    final bubbleBg = isMe
        ? Colors.white.withOpacity(0.12)
        : (dark ? Gx.d3 : Gx.l2);
    final tx = isMe ? Colors.white : (dark ? Gx.tx1 : Gx.tx1L);
    final tx2 = isMe ? Colors.white70 : (dark ? Gx.tx2 : Gx.tx2L);

    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 240),
        margin: const EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          color: bubbleBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Gx.violet.withOpacity(0.3)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Gx.violet.withOpacity(0.25), Gx.cyan.withOpacity(0.10)],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(children: [
              Icon(Icons.link_rounded, size: 14, color: Gx.violet),
              const SizedBox(width: 6),
              Expanded(child: Text(_domain,
                style: TextStyle(fontSize: 11, color: Gx.violet, fontWeight: FontWeight.w700),
                maxLines: 1, overflow: TextOverflow.ellipsis)),
            ]),
          ),
          // URL text
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(url,
                style: TextStyle(fontSize: 12, color: tx2, decoration: TextDecoration.underline,
                  decorationColor: tx2),
                maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: Gx.gBrand,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.open_in_new_rounded, size: 11, color: Colors.white),
                  const SizedBox(width: 4),
                  Text('Tap to copy link', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    final dark = Theme.of(ctx).brightness == Brightness.dark;
    return Container(width: 42, height: 4,
      decoration: BoxDecoration(color: dark ? Gx.tx3 : Gx.tx3L, borderRadius: BorderRadius.circular(2)));
  }
}

// ═══════════════════════════════════════════════════
//  GLOBAL HELPERS
// ═══════════════════════════════════════════════════

Widget _emptyView(IconData icon, String title, String sub) => Center(
  child: Padding(padding: const EdgeInsets.all(36),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      TweenAnimationBuilder<double>(tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutBack,
        builder: (_, v, child) => Transform.scale(scale: v, child: child),
        child: Builder(builder: (ctx) {
          final dark = Theme.of(ctx).brightness == Brightness.dark;
          return Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: dark ? Gx.d4 : const Color(0xFFE8E6FF),
              border: Border.all(color: Gx.violet.withOpacity(dark ? 0.22 : 0.35), width: 1.2),
              boxShadow: dark ? [] : [BoxShadow(color: Gx.violet.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 4))],
            ),
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
    ]),
  ),
);

String _timeStr(DateTime dt) {
  final n = DateTime.now();
  if (n.difference(dt).inHours < 24 && n.day == dt.day) return DateFormat('hh:mm a').format(dt);
  if (n.difference(dt).inDays <= 1) return 'Yesterday';
  return DateFormat('dd/MM/yy').format(dt);
}

void _gaxPush(BuildContext ctx, Widget page) => Navigator.push(ctx, PageRouteBuilder(
  pageBuilder: (_, a1, a2) => page,
  transitionsBuilder: (_, a1, a2, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: a1, curve: Curves.easeOutCubic)),
    child: FadeTransition(opacity: CurvedAnimation(parent: a1, curve: const Interval(0, 0.6)), child: child),
  ),
  transitionDuration: const Duration(milliseconds: 300),
));

void _gaxDialog(BuildContext ctx, {
  required String title, required String body,
  required String confirmLabel, required Color confirmClr,
  required VoidCallback onConfirm, VoidCallback? onCancel,
}) => showDialog(context: ctx, builder: (c) => _GaxAlertDialog(
  title: title, body: body, confirmLabel: confirmLabel,
  confirmClr: confirmClr, onConfirm: onConfirm, onCancel: onCancel,
));

class _GaxAlertDialog extends StatelessWidget {
  final String title, body, confirmLabel;
  final Color confirmClr;
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
          if (onCancel != null) TextButton(onPressed: onCancel,
            child: Text('Cancel', style: TextStyle(color: dark ? Gx.tx2 : Gx.tx2L))),
          TextButton(onPressed: onConfirm,
            child: Text(confirmLabel, style: TextStyle(color: confirmClr, fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}
