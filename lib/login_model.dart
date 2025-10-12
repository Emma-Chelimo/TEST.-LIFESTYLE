import '/backend/api_requests/api_calls.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Assume Firebase Auth is used
// import 'package:firebase_auth/firebase_auth.dart';

class LoginModel extends ChangeNotifier {
  // State variables
  String email = '';
  String password = '';
  bool isLoading = false;
  String? errorMessage;
  bool rememberMe = false;

  // Initialization
  void initialize() {
    _loadSavedCredentials();
  }

  // Methods
  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  bool validateInputs() {
    if (email.isEmpty || !email.contains('@')) {
      errorMessage = 'Please enter a valid email';
      notifyListeners();
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      errorMessage = 'Password must be at least 6 characters';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  Future<bool> signIn() async {
    if (!validateInputs()) return false;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Firebase Auth sign-in
      // final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // Assume success for now
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      if (rememberMe) {
        await _saveCredentials();
      } else {
        await _clearCredentials();
      }

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Sign-in failed: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('rememberMe', rememberMe);
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
    }
    notifyListeners();
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.setBool('rememberMe', false);
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
