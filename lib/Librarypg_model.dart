import '/backend/firebase/music_service.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum LibraryCategory { songs, albums, playlists, favorites }

class LibrarypgModel extends ChangeNotifier {
  // State variables
  LibraryCategory selectedCategory = LibraryCategory.songs;
  List<Map<String, dynamic>> songs = [];
  List<Map<String, dynamic>> albums = [];
  List<Map<String, dynamic>> playlists = [];
  List<Map<String, dynamic>> favorites = [];
  List<Map<String, dynamic>> recentlyAdded = [];
  List<Map<String, dynamic>> recentlyPlayed = [];
  Map<String, dynamic>? currentPlayingSong;
  bool isPlaying = false;
  bool isLoading = false;
  String? errorMessage;

  final MusicService _musicService = MusicService.instance;

  // Initialization
  void initialize() {
    loadLibraryData();
  }

  // Methods
  void selectCategory(LibraryCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  List<Map<String, dynamic>> get currentCategoryItems {
    switch (selectedCategory) {
      case LibraryCategory.songs:
        return songs;
      case LibraryCategory.albums:
        return albums;
      case LibraryCategory.playlists:
        return playlists;
      case LibraryCategory.favorites:
        return favorites;
    }
  }

  Future<void> loadLibraryData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uid = getCurrentUser()?.uid;

      final results = await Future.wait([
        _musicService.fetchAllSongs(),
        _musicService.fetchAlbums(),
        _musicService.fetchPlaylists(),
        _musicService.fetchFavorites(uid),
      ]);

      songs = results[0];
      albums = results[1];
      playlists = results[2];
      favorites = results[3];

      // Recently added: most recently created playlists (top 3).
      recentlyAdded = playlists.take(3).toList();
      // Recently played: most recently created/added songs for now;
      // swap for real per-user history once recentlyPlayed has volume.
      recentlyPlayed = songs.take(3).toList();
    } catch (e) {
      errorMessage = 'Failed to load library: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool isFavorite(String songId) {
    return favorites.any((s) => s['id'] == songId);
  }

  Future<void> toggleFavorite(Map<String, dynamic> song) async {
    final uid = getCurrentUser()?.uid;
    final songId = song['id'] as String?;
    if (songId == null) return;

    final currentlyFav = isFavorite(songId);
    if (currentlyFav) {
      favorites.removeWhere((s) => s['id'] == songId);
    } else {
      favorites.add(song);
    }
    notifyListeners();

    await _musicService.toggleFavorite(uid, songId, !currentlyFav);
  }

  void playSong(Map<String, dynamic> song) {
    currentPlayingSong = song;
    isPlaying = true;
    notifyListeners();

    final songId = song['id'] as String?;
    if (songId != null) {
      _musicService.recordRecentlyPlayed(getCurrentUser()?.uid, songId);
    }
    // Navigate to player or trigger playback
  }

  void pauseSong() {
    isPlaying = false;
    notifyListeners();
  }

  void nextSong() {
    // Implement next logic
    notifyListeners();
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
