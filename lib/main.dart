import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
// Using a simple in-app FFLocalizations without Material delegates
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:project_one/basehomepg.dart';
import 'package:project_one/signin.dart';
import 'package:project_one/loginpg.dart';
import 'package:project_one/Playerpg.dart';
import 'package:project_one/Librarypg.dart';
import 'package:project_one/Searchpg.dart';
import 'package:project_one/profilepg.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class SupaFlow {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://brqyhryqrejbqjuwnbpn.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJycXlocnlxcmVqYnFqdXduYnBuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU3Nzg3NDIsImV4cCI6MjA3MTM1NDc0Mn0.mZ0wEqS9FUK2GPQq_bh_Q_1mkshpGV9yVoZL2BIFGFQ',
    );
  }
}

// Removed duplicate FlutterFlowTheme class to avoid conflicts with
// the app-wide theme in flutter_flow/flutter_flow_theme.dart

Future<void> initializeFirebaseAppCheck() async {
  if (kIsWeb) {
    // For older firebase_app_check versions, web reCAPTCHA is not supported
    // Skip App Check activation for web in this version
    print(
        'App Check not activated for web - version 0.3.2+7 does not support web reCAPTCHA');
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await initFirebase();

  await SupaFlow.initialize();

  // Theme initializes via FlutterFlowTheme.of(context) at runtime

//class FlutterFlowTheme {}
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  await initializeFirebaseAppCheck();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Beatsmusic',
      theme: FlutterFlowTheme.themeData,
      routerConfig: _router,
      // FFLocalizations is a lightweight singleton; no delegates needed here
    );
  }
}

class NavShell extends StatefulWidget {
  final Widget child;
  const NavShell({super.key, required this.child});

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  int _indexFromLocation(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/library')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // home
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.goNamed('Basehomepg');
        break;
      case 1:
        context.goNamed('Search');
        break;
      case 2:
        context.goNamed('Library');
        break;
      case 3:
        context.goNamed('Profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _indexFromLocation(location);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        backgroundColor: const Color(0xFF070707),
        selectedItemColor: const Color(0xFFFF5963),
        unselectedItemColor: const Color(0xFF249689),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            activeIcon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/basehomepg',
  routes: [
    ShellRoute(
      builder: (context, state, child) => NavShell(child: child),
      routes: [
        GoRoute(
          path: '/basehomepg',
          name: 'Basehomepg',
          builder: (context, state) => const BasehomepgWidget(),
        ),
        GoRoute(
          path: '/search',
          name: 'Search',
          builder: (context, state) => const SearchpgWidget(),
        ),
        GoRoute(
          path: '/library',
          name: 'Library',
          builder: (context, state) => const LibrarypgWidget(),
        ),
        GoRoute(
          path: '/profile',
          name: 'Profile',
          builder: (context, state) => const ProfilepgWidget(),
        ),
      ],
    ),
    GoRoute(
      path: '/signin',
      name: 'SignIn',
      builder: (context, state) => const SignInWidget(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginWidget(),
    ),
    GoRoute(
      path: '/playerpg',
      name: 'playerpg',
      builder: (context, state) => const PlayerpgWidget(),
    ),
  ],
);

void usePathUrlStrategy() {}
