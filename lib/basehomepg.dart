import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import '/flutter_flow/flutter_flow_animations.dart' as ffAnim;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late BasehomepgModel _model;
  // Index handled globally by NavShell

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = BasehomepgModel();

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

  @override
  void dispose() {
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
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF6482),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://picsum.photos/seed/839/600',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ns6540t9' /* Song */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Icon(
                                  Icons.skip_next_rounded,
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

                    // Dynamic playlists grid (replace itemCount with API length)
                    SliverPadding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      sliver: SliverGrid.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: List.generate(6, (i) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
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
                        children: List.generate(6, (i) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
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
                        children: List.generate(6, (i) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
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

  void safeSetState(Null Function() param0) {}

  valueOrDefault(String string, String s) {}

  BasehomepgModel createModel(
      BuildContext context, BasehomepgModel Function() param1) {
    return param1();
  }
}

class MyClass {}

// Removed invalid mixin declaration

extension on Text {}

//class FlutterFlowTheme {
//static of(BuildContext context) async {}

//}

class BasehomepgModel {
  bool? get isplaying => null;

  void dispose() {}
}

// AnimationInfo class moved to flutter_flow_animations.dart
