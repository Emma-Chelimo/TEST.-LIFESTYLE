import '/backend/api_requests/api_calls.dart';
import '/backend/firebase/music_service.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BasehomepgModel extends ChangeNotifier {
  // State variables
  List<Map<String, dynamic>> playlists = [];
  List<Map<String, dynamic>> albums = [];
  List<Map<String, dynamic>> recommended = [];
  Map<String, dynamic>? nowPlaying;
  bool isLoading = false;
  String? errorMessage;
  bool isPlaying = false;

  final MusicService _musicService = MusicService.instance;

  // Initialization
  void initialize() {
    loadHomeData();
  }

  // Methods
  Future<void> loadHomeData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final uid = getCurrentUser()?.uid;

      final results = await Future.wait([
        _musicService.fetchPlaylists(),
        _musicService.fetchAlbums(),
        _musicService.fetchRecommendedSongs(),
        _musicService.fetchLastPlayed(uid),
      ]);

      playlists = results[0] as List<Map<String, dynamic>>;
      albums = results[1] as List<Map<String, dynamic>>;
      recommended = results[2] as List<Map<String, dynamic>>;
      final lastPlayed = results[3] as Map<String, dynamic>?;

      // Each playlist needs its actual song list resolved from songIds.
      for (final playlist in playlists) {
        final songIds = (playlist['songIds'] as List?) ?? [];
        playlist['songs'] = await _musicService.fetchSongsByIds(songIds);
      }

      nowPlaying = lastPlayed ??
          (recommended.isNotEmpty ? recommended.first : null);
    } catch (e) {
      errorMessage = 'Failed to load home data: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void playSong(Map<String, dynamic> song) {
    nowPlaying = song;
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
    // Implement next logic, e.g., from a queue
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
