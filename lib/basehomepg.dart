import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import '/flutter_flow/flutter_flow_animations.dart' as ffAnim;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
// Bottom navigation is now provided by NavShell (ShellRoute) in main.dart

export 'basehomepg_model.dart';

class BasehomepgWidget extends StatefulWidget {
  const BasehomepgWidget({super.key});

  static String routeName = 'Basehomepg';
  static String routePath = 'basehomepg';

  @override
  State<BasehomepgWidget> createState() => _BasehomepgWidgetState();
}

class _BasehomepgWidgetState extends State<BasehomepgWidget>
    with TickerProviderStateMixin, ffAnim.AnimationMixin {
  late Basehomepg_model _model;
  // Index handled globally by NavShell

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = Basehomepg_model();
    _model.addListener(_onModelChanged);
    _model.initialize();

    // Add animations
    animationsMap.addAll({
      'textOnPageLoadAnimation': ffAnim.AnimationInfo(
        trigger: ffAnim.AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ffAnim.FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 700.0.ms,
            begin: 0.38,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onModelChanged() {
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.removeListener(_onModelChanged);
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'Basehomepg',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    '9b8nsb1t' /* Beats */,
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.islandMoments(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        color: Color(0xFFB8172D),
                        fontSize: 36,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            ),
            // bottomNavigationBar is provided by NavShell
            body: SafeArea(
              top: true,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF21005D),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'tsmvfroo' /* Welcome home. */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFF6F1F3),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Icon(
                                Icons.settings_suggest,
                                color: Color(0xFFFF11FF),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Now playing pill
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 16),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              if (_model.isPlaying) {
                                _model.pauseSong();
                              } else if (_model.nowPlaying != null) {
                                { _model.playSong(_model.nowPlaying!); context.pushNamed('playerpg', extra: _model.nowPlaying); }
                              }
                            },
                            child: Container(
                              width: 220,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6482),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  6, 0, 12, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      _model.nowPlaying?['coverUrl'] ??
                                          'https://picsum.photos/seed/839/600',
                                      width: 38,
                                      height: 38,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => Container(
                                        width: 38,
                                        height: 38,
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 4, 0),
                                      child: Text(
                                        _model.nowPlaying?['title'] ??
                                            FFLocalizations.of(context).getText(
                                              'ns6540t9' /* Song */,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    _model.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Playlists header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'mwnreu28' /* Your Playlists */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 20,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),

                    // Dynamic playlists grid
                    SliverPadding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children:
                            List.generate(_model.playlists.length, (i) {
                          final playlist = _model.playlists[i];
                          return GestureDetector(
                            onTap: () {
                              if ((playlist['songs'] as List).isNotEmpty) {
                                final song = (playlist['songs'] as List).first
                                    as Map<String, dynamic>;
                                _model.playSong(song);
                                context.pushNamed('playerpg', extra: song);
                              }
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      playlist['coverUrl'] ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) => Container(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  playlist['name'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    // Albums header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '7abzp49t' /* Albums */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 20,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),

                    // Dynamic albums grid
                    SliverPadding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: List.generate(_model.albums.length, (i) {
                          final album = _model.albums[i];
                          return GestureDetector(
                            onTap: () { _model.playSong(album); context.pushNamed('playerpg', extra: album); },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      album['coverUrl'] ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) => Container(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  album['title'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    // Recommended header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'nepqz6t2' /* Recommended */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 20,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),

                    // Recommended grid
                    SliverPadding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 24),
                      sliver: SliverGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children:
                            List.generate(_model.recommended.length, (i) {
                          final song = _model.recommended[i];
                          return GestureDetector(
                            onTap: () { _model.playSong(song); context.pushNamed('playerpg', extra: song); },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      song['coverUrl'] ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) => Container(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song['title'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}
