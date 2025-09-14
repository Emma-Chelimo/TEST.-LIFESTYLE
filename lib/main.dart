import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
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
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/basehomepg',
  routes: [
    GoRoute(
      path: '/basehomepg',
      name: 'Basehomepg',
      builder: (context, state) => const BasehomepgWidget(),
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
    GoRoute(
      path: '/library',
      name: 'Library',
      builder: (context, state) => const LibrarypgWidget(),
    ),
    GoRoute(
      path: '/search',
      name: 'Search',
      builder: (context, state) => const SearchpgWidget(),
    ),
    GoRoute(
      path: '/profile',
      name: 'Profile',
      builder: (context, state) => const ProfilepgWidget(),
    ),
  ],
);

void usePathUrlStrategy() {}
