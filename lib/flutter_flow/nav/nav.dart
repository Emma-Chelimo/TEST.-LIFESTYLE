import 'package:flutter/material.dart';

void goToHome(BuildContext context) {
  Navigator.of(context).pushNamed('/home');
}

void goToSearch(BuildContext context) {
  Navigator.of(context).pushNamed('/search');
}

void goToLibrary(BuildContext context) {
  Navigator.of(context).pushNamed('/library');
}

void goToProfile(BuildContext context) {
  Navigator.of(context).pushNamed('/profile');
}

void goToSignIn(BuildContext context) {
  Navigator.of(context).pushNamed('/signin');
}

void goToLogin(BuildContext context) {
  Navigator.of(context).pushNamed('/login');
}

// Optionally, add pop and pushReplacement helpers:
void popPage(BuildContext context) {
  Navigator.of(context).pop();
}

void replaceWithHome(BuildContext context) {
  Navigator.of(context).pushReplacementNamed('/home');
}