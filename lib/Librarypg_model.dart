import '/backend/api_requests/api_calls.dart';
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
  Map<String, dynamic>? currentPlayingSong;
  bool isLoading = false;
  String? errorMessage;

  // Initialization
  void initialize() {
    loadLibraryData();
  }

  // Methods
  void selectCategory(LibraryCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> loadLibraryData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Load data from API or local storage
      // For now, load dummy data
      await Future.delayed(const Duration(seconds: 1));
      songs = [
        {'title': 'Song 1', 'artist': 'Artist 1', 'url': 'url1'},
        {'title': 'Song 2', 'artist': 'Artist 2', 'url': 'url2'},
      ];
      albums = [
        {'title': 'Album 1', 'artist': 'Artist 1', 'cover': 'cover1'},
        {'title': 'Album 2', 'artist': 'Artist 2', 'cover': 'cover2'},
      ];
      playlists = [
        {'name': 'Playlist 1', 'songs': ['song1', 'song2']},
        {'name': 'Playlist 2', 'songs': ['song3', 'song4']},
      ];
      favorites = songs; // Assume all songs are favorites for demo
      recentlyAdded = playlists;
    } catch (e) {
      errorMessage = 'Failed to load library: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadSongs() async {
    // Specific loading for songs if needed
    await loadLibraryData();
  }

  Future<void> loadAlbums() async {
    // Specific loading for albums if needed
    await loadLibraryData();
  }

  Future<void> loadPlaylists() async {
    // Specific loading for playlists if needed
    await loadLibraryData();
  }

  Future<void> loadFavorites() async {
    // Specific loading for favorites if needed
    await loadLibraryData();
  }

  void addToFavorites(Map<String, dynamic> song) {
    if (!favorites.contains(song)) {
      favorites.add(song);
      notifyListeners();
    }
  }

  void removeFromFavorites(Map<String, dynamic> song) {
    favorites.remove(song);
    notifyListeners();
  }

  void playSong(Map<String, dynamic> song) {
    currentPlayingSong = song;
    notifyListeners();
    // Navigate to player or trigger playback
  }

  void pauseSong() {
    // Implement pause logic
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
