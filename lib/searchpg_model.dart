import '/backend/api_requests/api_calls.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchpgModel extends ChangeNotifier {
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;
  String? errorMessage;
  List<String> recentSearches = [];

  Timer? _debounceTimer;

  static const _recentKey = 'recent_searches';
  static const _maxRecent = 8;

  void initialize() {
    _loadRecentSearches();
  }

  void onSearchChanged(String query) {
    searchQuery = query;
    errorMessage = null;
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      searchResults.clear();
      notifyListeners();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 450), performSearch);
    notifyListeners();
  }

  Future<void> performSearch() async {
    final query = searchQuery.trim();
    if (query.isEmpty) return;

    isSearching = true;
    errorMessage = null;
    searchResults.clear();
    notifyListeners();

    try {
      final results = await searchSong(query);
      if (results.isEmpty) {
        errorMessage = 'No results found for "$query"';
      } else {
        searchResults = results;
      }
      await _addToRecentSearches(query);
    } catch (e) {
      errorMessage = 'Search failed. Check your connection and try again.';
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    searchQuery = '';
    searchResults.clear();
    errorMessage = null;
    _debounceTimer?.cancel();
    notifyListeners();
  }

  Future<void> removeRecentSearch(String query) async {
    recentSearches.remove(query);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentKey, recentSearches);
  }

  Future<void> clearAllRecent() async {
    recentSearches.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentKey);
  }

  Future<void> _addToRecentSearches(String query) async {
    recentSearches.remove(query); // avoid duplicates
    recentSearches.insert(0, query);
    if (recentSearches.length > _maxRecent) {
      recentSearches = recentSearches.sublist(0, _maxRecent);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_recentKey, recentSearches);
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches = prefs.getStringList(_recentKey) ?? [];
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
