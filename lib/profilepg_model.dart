import '/backend/api_requests/api_calls.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilepgModel extends ChangeNotifier {
  // State variables
  String userDisplayName = 'User';
  String? userPhotoUrl;
  int followersCount = 0;
  int likesCount = 0;
  List<String> posts = [];
  bool isDataUploading_uploadData3xk = false;
  bool isDataUploading_uploadDataGye = false;
  FFUploadedFile? uploadedLocalFile_uploadData3xk;
  String? uploadedFileUrl_uploadData3xk;
  FFUploadedFile? uploadedLocalFile_uploadDataGye;
  String? uploadedFileUrl_uploadDataGye;
  DocumentReference<Map<String, dynamic>>? currentUserReference;
  Map<String, dynamic>? currentUserDocument;
  bool isLoading = false;
  String? errorMessage;

  // Initialization
  void initialize(DocumentReference<Map<String, dynamic>>? userRef) {
    currentUserReference = userRef;
    if (currentUserReference != null) {
      loadUserProfile();
    }
  }

  // Methods
  Future<void> loadUserProfile() async {
    if (currentUserReference == null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final doc = await currentUserReference!.get();
      if (doc.exists) {
        currentUserDocument = doc.data();
        userDisplayName = currentUserDocument?['display_name'] ?? 'User';
        userPhotoUrl = currentUserDocument?['photoUrl'];
        followersCount = (currentUserDocument?['followers'] as List<dynamic>?)?.length ?? 0;
        likesCount = (currentUserDocument?['likes'] as List<dynamic>?)?.length ?? 0;
        posts = List<String>.from(currentUserDocument?['posts'] ?? []);
      }
    } catch (e) {
      errorMessage = 'Failed to load profile: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfilePhoto(String? newPhotoUrl) async {
    if (currentUserReference == null || newPhotoUrl == null) return;

    try {
      await currentUserReference!.update({'photoUrl': newPhotoUrl});
      userPhotoUrl = newPhotoUrl;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to update photo: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> followUser(DocumentReference<Map<String, dynamic>>? targetUserRef) async {
    if (currentUserReference == null || targetUserRef == null) return;

    try {
      await currentUserReference!.update({
        'following': FieldValue.arrayUnion([targetUserRef]),
      });
      // Optionally, update target's followers
      await targetUserRef.update({
        'followers': FieldValue.arrayUnion([currentUserReference]),
      });
      // Reload profile to update counts
      loadUserProfile();
    } catch (e) {
      errorMessage = 'Failed to follow user: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> addPost(String? postUrl) async {
    if (currentUserReference == null || postUrl == null) return;

    try {
      await currentUserReference!.update({
        'posts': FieldValue.arrayUnion([postUrl]),
      });
      posts.add(postUrl);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to add post: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> updateDisplayName(String newName) async {
    if (currentUserReference == null) return;

    try {
      await currentUserReference!.update({'display_name': newName});
      userDisplayName = newName;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to update name: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUser();
    } catch (e) {
      errorMessage = 'Sign out failed: ${e.toString()}';
      notifyListeners();
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

class FFUploadedFile {
  final String? name;
  final List<int>? bytes;
  final double? height;
  final double? width;
  final String? blurHash;

  FFUploadedFile({
    this.name,
    this.bytes,
    this.height,
    this.width,
    this.blurHash,
  });
}
