import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;
  String? errorMessage;

  void initialize() {}

  void updateEmail(String v) {
    email = v;
    notifyListeners();
  }

  void updatePassword(String v) {
    password = v;
    notifyListeners();
  }

  void updateConfirmPassword(String v) {
    confirmPassword = v;
    notifyListeners();
  }

  bool validateInputs() {
    if (email.isEmpty || !email.contains('@')) {
      errorMessage = 'Please enter a valid email address.';
      notifyListeners();
      return false;
    }
    if (password.length < 6) {
      errorMessage = 'Password must be at least 6 characters.';
      notifyListeners();
      return false;
    }
    if (password != confirmPassword) {
      errorMessage = 'Passwords do not match.';
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
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Create user document in Firestore
      final uid = credential.user?.uid;
      if (uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'display_name': email.split('@').first,
          'email': email.trim(),
          'photoUrl': null,
          'followers': [],
          'following': [],
          'likes': [],
          'posts': [],
          'about': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
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
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password sign-up is not enabled.';
      default:
        return 'Sign-up failed. Please try again.';
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
