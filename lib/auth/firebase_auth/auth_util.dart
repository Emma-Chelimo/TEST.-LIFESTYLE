// TODO Implement this library.
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential> signInWithEmail(String email, String password) {
  return auth.signInWithEmailAndPassword(email: email, password: password);
}

Future<UserCredential> registerWithEmail(String email, String password) {
  return auth.createUserWithEmailAndPassword(email: email, password: password);
}

Future<void> signOut() {
  return auth.signOut();
}

Future<void> signOutUser() {
  return auth.signOut();
}

User? getCurrentUser() {
  return auth.currentUser;
}

// Add more helper functions as needed (reset password, update profile, etc.)