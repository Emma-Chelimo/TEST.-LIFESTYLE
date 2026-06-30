//import '/backend/api_requests/api_calls.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:shared_preferences/shared_preferences.dart';
// Assume Firebase Auth is used
// import 'package:firebase_auth/firebase_auth.dart';

class SignInModel extends ChangeNotifier {
  // State variables
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  String? errorMessage;

  // Initialization
  void initialize() {
    // Any initialization logic if needed
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

  void updateConfirmPassword(String newConfirmPassword) {
    confirmPassword = newConfirmPassword;
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
    if (password != confirmPassword) {
      errorMessage = 'Passwords do not match';
      notifyListeners();
      return false;
    }
    errorMessage = null;
    return true;
  }

  Future<bool> signUp() async {
    if (!validateInputs()) return false;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Firebase Auth sign-up
      // final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // Assume success for now
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Sign-up failed: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      return false;
    }
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
