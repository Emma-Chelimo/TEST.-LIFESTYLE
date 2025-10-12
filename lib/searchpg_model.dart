import '/backend/api_requests/api_calls.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SearchpgModel extends ChangeNotifier {
  // State variables
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;
  String? errorMessage;
  Map<String, dynamic> filters = {};
  int currentPage = 1;
  int totalPages = 0;
  bool hasMoreResults = false;
  Map<String, dynamic>? selectedItem;
  List<String> recentSearches = [];

  Timer? _debounceTimer;

  // Initialization
  void initialize() {
    // Load recent searches if needed
    _loadRecentSearches();
  }

  // Methods
  void onSearchChanged(String query) {
    searchQuery = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        performSearch();
      } else {
        clearSearch();
      }
    });
    notifyListeners();
  }

  Future<void> performSearch() async {
    if (searchQuery.isEmpty) return;

    isSearching = true;
    errorMessage = null;
    currentPage = 1;
    searchResults.clear();
    notifyListeners();

    try {
      // Integrate with existing API: searchSong returns single result, so simulate multiple or update API
      // For now, call searchSong and add to results; in production, modify api_calls.dart for list search
      final result = await searchSong(searchQuery);
      if (result != null) {
        searchResults.add(result);
        hasMoreResults = true; // Assume more for demo; update based on API
        totalPages = 1; // Placeholder
      } else {
        errorMessage = 'No results found for "$searchQuery"';
      }
    } catch (e) {
      errorMessage = 'Search failed: ${e.toString()}';
    } finally {
      isSearching = false;
      notifyListeners();
    }

    _addToRecentSearches(searchQuery);
  }

  Future<void> loadMore() async {
    if (!hasMoreResults || isSearching) return;

    currentPage++;
    isSearching = true;
    notifyListeners();

    try {
      // Similar to performSearch, but with pagination params if API supports
      // For now, reuse searchSong as example
      final result = await searchSong(searchQuery);
      if (result != null) {
        searchResults.add(result);
      } else {
        hasMoreResults = false;
      }
    } catch (e) {
      errorMessage = 'Load more failed: ${e.toString()}';
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  void applyFilters(Map<String, dynamic> newFilters) {
    filters = newFilters;
    // Reset and perform search with filters
    currentPage = 1;
    searchResults.clear();
    notifyListeners();
    performSearch(); // Re-search with filters applied in API call
  }

  void selectItem(Map<String, dynamic> item) {
    selectedItem = item;
    notifyListeners();
    // Navigate to details or player, e.g., context.pushNamed('Playerpg', extra: item);
  }

  void clearSearch() {
    searchQuery = '';
    searchResults.clear();
    errorMessage = null;
    currentPage = 1;
    _debounceTimer?.cancel();
    notifyListeners();
  }

  void _addToRecentSearches(String query) {
    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
      // Persist to local storage if needed (e.g., SharedPreferences)
      notifyListeners();
    }
  }

  Future<void> _loadRecentSearches() async {
    // Load from local storage; placeholder
    recentSearches = ['example1', 'example2']; // Demo data
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
