// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWC3DUEco6t4JjkrqDsSFhvGpmhP8t1C4',
    appId: '1:70498032913:web:9c708bd8b3d9500b7c00b0',
    messagingSenderId: '70498032913',
    projectId: 'fir-one-b24dd',
    authDomain: 'fir-one-b24dd.firebaseapp.com',
    storageBucket: 'fir-one-b24dd.firebasestorage.app',
    measurementId: 'G-QYEB09M2EK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1FHlOGS-a0dIr8h4eXdUPCfB0ArgTwAg',
    appId: '1:70498032913:android:4a8a49f644b3fe867c00b0',
    messagingSenderId: '70498032913',
    projectId: 'fir-one-b24dd',
    storageBucket: 'fir-one-b24dd.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3FCRpLyQUFiEbi8TXyKId2A0lydR8mjY',
    appId: '1:70498032913:ios:4ab6e6f11881d5a97c00b0',
    messagingSenderId: '70498032913',
    projectId: 'fir-one-b24dd',
    storageBucket: 'fir-one-b24dd.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3FCRpLyQUFiEbi8TXyKId2A0lydR8mjY',
    appId: '1:70498032913:ios:4ab6e6f11881d5a97c00b0',
    messagingSenderId: '70498032913',
    projectId: 'fir-one-b24dd',
    storageBucket: 'fir-one-b24dd.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWC3DUEco6t4JjkrqDsSFhvGpmhP8t1C4',
    appId: '1:70498032913:web:c3ae18015f87ffdb7c00b0',
    messagingSenderId: '70498032913',
    projectId: 'fir-one-b24dd',
    authDomain: 'fir-one-b24dd.firebaseapp.com',
    storageBucket: 'fir-one-b24dd.firebasestorage.app',
    measurementId: 'G-XNY9SKC7XZ',
  );
}
