import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseUserProvider extends StatelessWidget {
  final Widget child;

  const FirebaseUserProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      child: child,
    );
  }
}