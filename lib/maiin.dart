import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(BeatsMusicApp());
}

class BeatsMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BEATS MUSIC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.purpleAccent,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF1E1E1E),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.white, fontSize: 20),
          bodyText1: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MainScreen();
        }
        return LoginScreen();
      },
    );
  }
}