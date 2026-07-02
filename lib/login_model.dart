import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool isLoading = false;
  String? errorMessage;
  bool rememberMe = false;

  void initialize() {
    _loadSavedCredentials();
  }

  void updateEmail(String v) {
    email = v;
    notifyListeners();
  }

  void updatePassword(String v) {
    password = v;
    notifyListeners();
  }

  void toggleRememberMe(bool v) {
    rememberMe = v;
    notifyListeners();
  }

  bool validateInputs() {
    if (email.isEmpty || !email.contains('@')) {
      errorMessage = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }
    if (password.length < 6) {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (rememberMe) {
        await _saveCredentials();
      } else {
        await _clearCredentials();
      }

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _friendlyError(e.code);
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String _friendlyError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Sign-in failed. Please check your credentials.';
    }
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setBool('rememberMe', true);
    // Note: never save raw passwords to SharedPreferences in production
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      email = prefs.getString('email') ?? '';
    }
    notifyListeners();
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
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
