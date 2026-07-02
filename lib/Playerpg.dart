import 'package:go_router/go_router.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'playerpg_model.dart';

class PlayerpgWidget extends StatefulWidget {
  const PlayerpgWidget({super.key, this.song});

  final Map<String, dynamic>? song;

  static String routeName = 'playerpg';
  static String routePath = 'playerpg';

  @override
  State<PlayerpgWidget> createState() => _PlayerpgWidgetState();
}

class _PlayerpgWidgetState extends State<PlayerpgWidget> {
  late PlayerpgModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PlayerpgModel();
    _model.addListener(_onModelChanged);
    _model.initialize(widget.song);

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

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final song = _model.song;

    return Title(
        title: 'playerpg',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
                automaticallyImplyLeading: false,
                actions: [],
                centerTitle: false,
                elevation: 2,
              ),
            ),
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go('/basehomepg');
                              }
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color:
                                  FlutterFlowTheme.of(context).primaryBackground,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                        width: 270,
                        height: 320,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(140),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(140),
                          child: Image.network(
                            song?['coverUrl'] ?? 'https://picsum.photos/seed/205/600',
                            width: 270,
                            height: 320,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              color:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Text(
                        song?['title'] ??
                            FFLocalizations.of(context).getText('g3jkck2q' /* Song */),
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                              font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                              color: FlutterFlowTheme.of(context).primaryBackground,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        song?['artist'] ?? '',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(),
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                      ),
                    ),
                    if (_model.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          _model.errorMessage!,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.skip_previous_rounded,
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            size: 28,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                            child: GestureDetector(
                              onTap: () => _model.togglePlayPause(),
                              child: Icon(
                                _model.isPlaying
                                    ? Icons.pause_circle_filled_rounded
                                    : Icons.play_circle_fill_rounded,
                                color:
                                    FlutterFlowTheme.of(context).primaryBackground,
                                size: 56,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.skip_next_rounded,
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.list_rounded,
                            color: FlutterFlowTheme.of(context).error,
                            size: 24,
                          ),
                          Icon(
                            Icons.favorite_rounded,
                            color: FlutterFlowTheme.of(context).error,
                            size: 24,
                          ),
                          Icon(
                            Icons.download_for_offline,
                            color: FlutterFlowTheme.of(context).error,
                            size: 24,
                          ),
                          Icon(
                            Icons.speaker,
                            color: FlutterFlowTheme.of(context).error,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 3,
                          thumbShape:
                              const RoundSliderThumbShape(enabledThumbRadius: 6),
                        ),
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).error,
                          inactiveColor: FlutterFlowTheme.of(context).alternate,
                          min: 0.0,
                          max: 1.0,
                          value: _model.sliderValue.clamp(0.0, 1.0),
                          onChanged: (double newValue) {
                            _model.seekTo(newValue);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_model.position),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(),
                                  color:
                                      FlutterFlowTheme.of(context).primaryBackground,
                                ),
                          ),
                          Text(
                            _formatDuration(_model.duration),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.inter(),
                                  color:
                                      FlutterFlowTheme.of(context).primaryBackground,
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
        ));
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }
}
