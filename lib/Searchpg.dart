//import 'package:go_router/go_router.dart';
// import 'package:project_one/Playerpg.dart';
//import 'package:project_one/basehomepg.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'searchpg_model.dart';
export 'searchpg_model.dart';
import 'searchpg_model.dart';

// ...existing imports...
import 'package:audioplayers/audioplayers.dart'; // Add this for audio playback

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

  Map<String, dynamic>? selectedSong;
  bool isPlaying = false;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    _model = SearchpgModel();
    _audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _audioPlayer?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchSong() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    // Set the query in the model and perform search
    _model.searchQuery = query;
    await _model.performSearch();
    // Results are now in _model.searchResults
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer?.pause();
      setState(() {
        isPlaying = false;
      });
    } else if (selectedSong != null && selectedSong!['audioUrl'] != null) {
      await _audioPlayer?.play(UrlSource(selectedSong!['audioUrl']));
      setState(() {
        isPlaying = true;
      });
    }
  }

  void _selectSong(Map<String, dynamic> song) {
    setState(() {
      selectedSong = song;
      isPlaying = false; // Reset, will play on toggle
    });
    // Optionally auto-play
    _togglePlayPause();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Searchpg',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
          body: SafeArea(
            top: true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF21005D),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/6426b3c84bd07f5104371b0f1d7b3478.jpg',
                  ).image,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // ...existing header code...
                  Opacity(
                    opacity: 0.8,
                    child: Align(
                      alignment: AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(50, 20, 0, 0),
                        child: Container(
                          width: 350,
                          height: 50,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Color(0xFF444267)),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.listUl,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search for a song...',
                                      border: InputBorder.none,
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                    onSubmitted: (_) => _searchSong(),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.search, color: FlutterFlowTheme.of(context).primaryText),
                                onPressed: _searchSong,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Search Results List
                  Expanded(
                    child: ListenableBuilder(
                      listenable: _model,
                      builder: (context, child) {
                        if (_model.isSearching) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (_model.errorMessage != null) {
                          return Center(child: Text(_model.errorMessage!));
                        }
                        if (_model.searchResults.isEmpty) {
                          return Center(child: Text('No results found.'));
                        }
                        return ListView.builder(
                          itemCount: _model.searchResults.length,
                          itemBuilder: (context, index) {
                            final song = _model.searchResults[index];
                            final isSelected = selectedSong == song;
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: song['albumArtUrl'] != null && song['albumArtUrl'].isNotEmpty
                                    ? Image.network(song['albumArtUrl'], width: 50, height: 50, fit: BoxFit.cover)
                                    : Image.asset('assets/images/asap.jpg', width: 50, height: 50, fit: BoxFit.cover),
                              ),
                              title: Text(song['title'] ?? 'Unknown Title'),
                              subtitle: Text(song['artist'] ?? 'Unknown Artist'),
                              trailing: IconButton(
                                icon: Icon(
                                  isSelected && isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                                onPressed: () => _selectSong(song),
                              ),
                              onTap: () => _selectSong(song),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }
}


