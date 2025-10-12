import '/backend/api_requests/api_calls.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// Assume just_audio is added to pubspec.yaml for audio playback
// import 'package:just_audio/just_audio.dart';

class PlayerpgModel extends ChangeNotifier {
  // State variables
  Map<String, dynamic>? currentSong;
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoading = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  double volume = 1.0;
  bool isFavorite = false;
  List<Map<String, dynamic>> playlist = [];
  int currentIndex = 0;
  double sliderValue = 0.0;
  String? errorMessage;

  // Audio player instance (commented out until package is added)
  // late AudioPlayer _audioPlayer;

  Timer? _positionTimer;

  // Initialization
  void initialize() {
    // _audioPlayer = AudioPlayer();
    // _setupAudioPlayerListeners();
    _loadInitialSong();
  }

  void _loadInitialSong() {
    // Load a default song or from arguments
    currentSong = {
      'title': 'Sample Song',
      'artist': 'Sample Artist',
      'album': 'Sample Album',
      'url': 'https://example.com/sample.mp3',
      'duration': Duration(minutes: 3),
    };
    totalDuration = currentSong!['duration'];
    notifyListeners();
  }

  // Methods
  Future<void> play() async {
    if (currentSong == null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // _audioPlayer.setUrl(currentSong!['url']);
      // await _audioPlayer.play();
      isPlaying = true;
      isPaused = false;
      _startPositionTimer();
    } catch (e) {
      errorMessage = 'Failed to play: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    // await _audioPlayer.pause();
    isPlaying = false;
    isPaused = true;
    _stopPositionTimer();
    notifyListeners();
  }

  Future<void> next() async {
    if (playlist.isNotEmpty && currentIndex < playlist.length - 1) {
      currentIndex++;
      currentSong = playlist[currentIndex];
      totalDuration = currentSong!['duration'];
      currentPosition = Duration.zero;
      sliderValue = 0.0;
      if (isPlaying) {
        await play();
      }
    }
    notifyListeners();
  }

  Future<void> previous() async {
    if (currentIndex > 0) {
      currentIndex--;
      currentSong = playlist[currentIndex];
      totalDuration = currentSong!['duration'];
      currentPosition = Duration.zero;
      sliderValue = 0.0;
      if (isPlaying) {
        await play();
      }
    }
    notifyListeners();
  }

  void seek(double value) {
    currentPosition = Duration(seconds: (value * totalDuration.inSeconds).toInt());
    sliderValue = value;
    // _audioPlayer.seek(currentPosition);
    notifyListeners();
  }

  void setVolume(double newVolume) {
    volume = newVolume;
    // _audioPlayer.setVolume(volume);
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    // Persist to backend or local storage
    notifyListeners();
  }

  Future<void> downloadSong() async {
    if (currentSong == null) return;

    // Implement download logic, e.g., using dio or http
    // For now, just set a flag or show message
    errorMessage = 'Download started for ${currentSong!['title']}';
    notifyListeners();
  }

  void loadPlaylist(List<Map<String, dynamic>> songs) {
    playlist = songs;
    if (songs.isNotEmpty) {
      currentSong = songs[0];
      totalDuration = currentSong!['duration'];
      currentPosition = Duration.zero;
      sliderValue = 0.0;
    }
    notifyListeners();
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlaying && currentPosition < totalDuration) {
        currentPosition += const Duration(seconds: 1);
        sliderValue = currentPosition.inSeconds / totalDuration.inSeconds;
        notifyListeners();
      } else if (currentPosition >= totalDuration) {
        next(); // Auto-play next
      }
    });
  }

  void _stopPositionTimer() {
    _positionTimer?.cancel();
  }

  // void _setupAudioPlayerListeners() {
  //   _audioPlayer.positionStream.listen((position) {
  //     currentPosition = position;
  //     sliderValue = position.inSeconds / totalDuration.inSeconds;
  //     notifyListeners();
  //   });
  //   _audioPlayer.durationStream.listen((duration) {
  //     if (duration != null) {
  //       totalDuration = duration;
  //       notifyListeners();
  //     }
  //   });
  //   _audioPlayer.playerStateStream.listen((state) {
  //     isPlaying = state.playing;
  //     isPaused = state.processingState == ProcessingState.ready && !state.playing;
  //     notifyListeners();
  //   });
  // }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    // _audioPlayer.dispose();
    super.dispose();
  }
}
