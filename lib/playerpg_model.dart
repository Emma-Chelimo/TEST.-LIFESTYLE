import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '/backend/firebase/music_service.dart';
import '/auth/firebase_auth/auth_util.dart';

class PlayerpgModel extends ChangeNotifier {
  Map<String, dynamic>? song;

  final AudioPlayer _player = AudioPlayer();
  final MusicService _musicService = MusicService.instance;

  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  String? errorMessage;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<PlayerState>? _stateSub;
  StreamSubscription<void>? _completeSub;

  double get sliderValue =>
      duration.inMilliseconds == 0
          ? 0.0
          : position.inMilliseconds / duration.inMilliseconds;

  void initialize(Map<String, dynamic>? initialSong) {
    _positionSub = _player.onPositionChanged.listen((p) {
      position = p;
      notifyListeners();
    });
    _durationSub = _player.onDurationChanged.listen((d) {
      duration = d;
      notifyListeners();
    });
    _stateSub = _player.onPlayerStateChanged.listen((s) {
      isPlaying = s == PlayerState.playing;
      notifyListeners();
    });
    _completeSub = _player.onPlayerComplete.listen((_) {
      isPlaying = false;
      position = Duration.zero;
      notifyListeners();
    });

    if (initialSong != null) {
      loadSong(initialSong);
    }
  }

  Future<void> loadSong(Map<String, dynamic> newSong) async {
    song = newSong;
    errorMessage = null;
    notifyListeners();

    final audioUrl = newSong['audioUrl'] as String?;
    if (audioUrl == null || audioUrl.isEmpty) {
      errorMessage = 'No audio source available for this track yet.';
      notifyListeners();
      return;
    }

    try {
      await _player.play(UrlSource(audioUrl));
      final songId = newSong['id'] as String?;
      if (songId != null) {
        _musicService.recordRecentlyPlayed(getCurrentUser()?.uid, songId);
      }
    } catch (e) {
      errorMessage = 'Could not play this track: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> togglePlayPause() async {
    if (song == null) return;
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  Future<void> seekTo(double fraction) async {
    if (duration.inMilliseconds == 0) return;
    final target = Duration(
      milliseconds: (duration.inMilliseconds * fraction).round(),
    );
    await _player.seek(target);
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _durationSub?.cancel();
    _stateSub?.cancel();
    _completeSub?.cancel();
    _player.dispose();
    super.dispose();
  }
}
