import 'package:flutter/material.dart';

// Localization class
class FFLocalizations {
  static FFLocalizations? _instance;
  static FFLocalizations of(BuildContext context) {
    _instance ??= FFLocalizations._();
    return _instance!;
  }

  FFLocalizations._();

  // Localization map
  final Map<String, String> _localizations = {
    '9b8nsb1t': 'Beats',
    'tsmvfroo': 'Welcome home.',
    'ns6540t9': 'Song',
    'mwnreu28': 'Your Playlists',
    'kiiy7wgj': 'Playlist',
    '9o8tl52p': 'Playlist',
    'mel8hbwc': 'Playlist',
    '7abzp49t': 'Albums',
    't1zh0xk3': 'Album',
    'n0kdvcyy': 'Album',
    '9gpzar9w': 'Album',
    'nepqz6t2': 'Recommended',
    '2qe70xel': 'Album',
    'vttusw49': 'Album',
    'f6zdhf4f': 'Album',
  };

  String getText(String key) {
    return _localizations[key] ?? key;
  }
}

// Extension for easy access
extension FFLocalizationsExtension on BuildContext {
  FFLocalizations get ffLocalizations => FFLocalizations.of(this);
}
