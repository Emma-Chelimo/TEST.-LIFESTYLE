import 'package:firebase_app_check/firebase_app_check.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';
//import 'package:project_one/basehomepg.dart';
//import 'auth/firebase_auth/firebase_user_provider.dart';
//import 'auth/firebase_auth/auth_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//import 'lib/backend/supabase/supabase.dart';
//import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
//import 'flutter_flow/flutter_flow_util.dart';
//import 'flutter_flow/internationalization.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//import 'flutter_flow/firebase_app_check_util.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'flutter_flow/nav/nav.dart';
//import 'index.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class SupaFlow {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://brqyhryqrejbqjuwnbpn.supabase.co',
      anonKey: '<YOUR_SUPABASE_ANON_PUBLIC_KEY>',
    );
  }
}
// Removed duplicate FlutterFlowTheme class to avoid conflicts with
// the app-wide theme in flutter_flow/flutter_flow_theme.dart

Future<void> initializeFirebaseAppCheck() async {
  await FirebaseAppCheck.instance.activate(
    //webRecaptchaSiteKey: kIsWeb? '6LcFua0rAAAAAFGKxQRV-JxhyYFXoQg468T6W2Yf',
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
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
    return MaterialApp(
      title: 'Beatsmusic',
      theme: FlutterFlowTheme.themeData,
      home: Scaffold(
        body: Center(child: Text('Hello World')),
      ),
      // Add other properties as needed
    );
  }
}

void usePathUrlStrategy() {}
