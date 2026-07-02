import 'package:go_router/go_router.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'searchpg_model.dart';

class SearchpgWidget extends StatefulWidget {
  const SearchpgWidget({super.key});

  static String routeName = 'Searchpg';
  static String routePath = 'searchPage';

  @override
  State<SearchpgWidget> createState() => _SearchpgWidgetState();
}

class _SearchpgWidgetState extends State<SearchpgWidget> {
  late SearchpgModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = SearchpgModel();
    _model.addListener(_onModelChanged);
    _model.initialize();

    _searchController.addListener(
        () => _model.onSearchChanged(_searchController.text));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onModelChanged() {
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.removeListener(_onModelChanged);
    _model.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }

  void _onRecentTap(String query) {
    _searchController.text = query;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    _model.onSearchChanged(query);
    _searchFocus.unfocus();
  }

  void _openPlayer(Map<String, dynamic> song) {
    // Map iTunes fields to our internal schema
    final mapped = {
      'id': null,
      'title': song['title'],
      'artist': song['artist'],
      'coverUrl': song['albumArtUrl'],
      'audioUrl': song['audioUrl'],
    };
    context.pushNamed('playerpg', extra: mapped);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasQuery = _searchController.text.trim().isNotEmpty;

    return Title(
      title: 'Search',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: GestureDetector(
        onTap: () {
          _searchFocus.unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF21005D),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/6426b3c84bd07f5104371b0f1d7b3478.jpg',
                ).image,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // ── Search bar ──
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(Icons.search,
                              color: Colors.white54, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocus,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              decoration: InputDecoration(
                                hintText: FFLocalizations.of(context).getText(
                                  'search_hint' /* Search songs, artists, albums */,
                                ) == 'search_hint'
                                    ? 'Search songs, artists, albums...'
                                    : FFLocalizations.of(context).getText(
                                        'search_hint'),
                                hintStyle: const TextStyle(
                                    color: Colors.white38, fontSize: 14),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (_) {
                                _model.performSearch();
                                _searchFocus.unfocus();
                              },
                            ),
                          ),
                          if (hasQuery)
                            IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white54, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                _model.clearSearch();
                              },
                            )
                          else
                            const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Body: recent searches or results ──
                  Expanded(
                    child: hasQuery
                        ? _buildResults()
                        : _buildRecentSearches(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Recent searches view ──
  Widget _buildRecentSearches() {
    if (_model.recentSearches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search,
                color: Colors.white24, size: 64),
            const SizedBox(height: 16),
            Text(
              'Search for songs, artists or albums',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    color: Colors.white38,
                  ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w700),
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
              ),
              TextButton(
                onPressed: _model.clearAllRecent,
                child: Text(
                  'Clear all',
                  style: TextStyle(
                      color: FlutterFlowTheme.of(context).error,
                      fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _model.recentSearches.map((query) {
              return GestureDetector(
                onTap: () => _onRecentTap(query),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history,
                          color: Colors.white54, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        query,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.inter(),
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _model.removeRecentSearch(query),
                        child: Icon(Icons.close,
                            color: Colors.white38, size: 14),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Search results view ──
  Widget _buildResults() {
    if (_model.isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_model.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.music_off, color: Colors.white24, size: 48),
              const SizedBox(height: 16),
              Text(
                _model.errorMessage!,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: Colors.white54,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    if (_model.searchResults.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      itemCount: _model.searchResults.length,
      separatorBuilder: (_, __) => Divider(
          color: Colors.white.withOpacity(0.08), height: 1),
      itemBuilder: (context, index) {
        final song = _model.searchResults[index];
        return _resultTile(song);
      },
    );
  }

  Widget _resultTile(Map<String, dynamic> song) {
    final coverUrl = song['albumArtUrl'] as String? ?? '';
    final title = song['title'] as String? ?? 'Unknown Title';
    final artist = song['artist'] as String? ?? 'Unknown Artist';
    final album = song['collectionName'] as String? ?? '';

    return InkWell(
      onTap: () => _openPlayer(song),
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Cover art
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: coverUrl.isNotEmpty
                  ? Image.network(
                      coverUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => _coverPlaceholder(),
                    )
                  : _coverPlaceholder(),
            ),
            const SizedBox(width: 14),

            // Title / artist / album
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(),
                          color: Colors.white54,
                        ),
                  ),
                  if (album.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      album,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context)
                          .bodySmall
                          .override(
                            font: GoogleFonts.inter(),
                            color: Colors.white38,
                            fontSize: 11,
                          ),
                    ),
                  ],
                ],
              ),
            ),

            // Play icon + navigate
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: FlutterFlowTheme.of(context).error,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coverPlaceholder() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.music_note, color: Colors.white38, size: 24),
    );
  }
}
