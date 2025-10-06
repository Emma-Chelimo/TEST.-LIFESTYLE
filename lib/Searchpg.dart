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

  String? songTitle;
  String? artistName;
  String? albumArtUrl;
  String? previewUrl;
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

    // Call your Spotify API here
    final result = await searchSong(query);

    if (result != null) {
      // Parse response to get song details
      final song = result;
      setState(() {
        songTitle = song['name'];
        artistName = song['artists'][0]['name'];
        albumArtUrl = song['album']['images'][0]['url'];
        previewUrl = song['preview_url'];
      });
      if (previewUrl != null) {
        await _audioPlayer?.play(UrlSource(previewUrl!));
        setState(() {
          isPlaying = true;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Song not found!'))
      );
    }
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer?.pause();
      setState(() {
        isPlaying = false;
      });
    } else if (previewUrl != null) {
      await _audioPlayer?.play(UrlSource(previewUrl!));
      setState(() {
        isPlaying = true;
      });
    }
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
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 24),
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
                              width: 300,
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
                      // ...existing code...
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 250, 0, 0),
                        child: Text(
                          FFLocalizations.of(context).getText('B' /* B */),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.islandMoments(
                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                              fontStyle: FontStyle.italic,
                            ),
                            color: Color(0xFFE10E2C),
                            fontSize: 50,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 240, 0, 0),
                          child: Container(
                            width: 350,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFB416BA),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Color(0xFF46184F)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: albumArtUrl != null
                                              ? Image.network(albumArtUrl!, width: 40, height: 40, fit: BoxFit.cover)
                                              : Image.asset('assets/images/asap.jpg', width: 40, height: 40, fit: BoxFit.cover),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                songTitle ?? 'Song',
                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                ),
                                              ),
                                              Text(
                                                artistName ?? 'Artist',
                                                style: FlutterFlowTheme.of(context).bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          isPlaying ? Icons.pause_outlined : Icons.play_arrow,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          size: 20,
                                        ),
                                        onPressed: _togglePlayPause,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                        child: Icon(
                                          Icons.skip_next,
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

class SearchpgModel {
  ApiCallResponse? apiResultdn2;
  ApiCallResponse? apiResultuj2;
  void dispose() {}
}