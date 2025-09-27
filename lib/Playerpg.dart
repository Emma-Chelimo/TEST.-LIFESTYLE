//import 'package:project_one/basehomepg.dart';

//import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
//import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/internationalization.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
//import 'dart:math';
//import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:provider/provider.dart';
//import '/flutter_flow/flutter_flow_theme.dart';
//import 'playerpg_model.dart';
export 'playerpg_model.dart';
//import 'package:project_one/basehomepg.dart' as basehome;
//import 'package:project_one/flutter_flow/flutter_flow_theme.dart' as ffTheme;

//basehome.BaseHomeTheme
//ffTheme.FlutterFlowTheme;

class AnimationInfo {
  final dynamic trigger;
  final List<dynamic> Function() effectsBuilder;

  AnimationInfo({
    required this.trigger,
    required this.effectsBuilder,
  });
}

class PlayerpgWidget extends StatefulWidget {
  const PlayerpgWidget({super.key});

  static String routeName = 'playerpg';
  static String routePath = 'playerpg';

  @override
  State<PlayerpgWidget> createState() => _PlayerpgWidgetState();
}

class _PlayerpgWidgetState extends State<PlayerpgWidget>
    with TickerProviderStateMixin {
  late PlayerpgModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = PlayerpgModel();

    animationsMap.addAll({
      'iconOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          RotateEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                          child: Container(
                            width: 270,
                            height: 400,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(125),
                                bottomRight: Radius.circular(125),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(125),
                                bottomRight: Radius.circular(125),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/205/600',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Icon(
                            Icons.filter_list_sharp,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 90, 0, 0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'oerm1oqt' /* Song */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                            child: Icon(
                              Icons.skip_previous_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                            child: Icon(
                              Icons.pause_circle_outline_sharp,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                            child: Icon(
                              key: ValueKey('1'),
                              Icons.skip_next_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(45, 0, 0, 0),
                            child: Icon(
                              Icons.list_rounded,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24,
                            ).animateOnPageLoad(
                                animationsMap['iconOnPageLoadAnimation1']!),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                            child: Icon(
                              Icons.favorite_rounded,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24,
                            ).animateOnPageLoad(
                                animationsMap['iconOnPageLoadAnimation2']!),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                            child: Icon(
                              Icons.download_for_offline,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24,
                            ).animateOnPageLoad(
                                animationsMap['iconOnPageLoadAnimation3']!),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(70, 0, 0, 0),
                            child: Icon(
                              Icons.speaker,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24,
                            ).animateOnPageLoad(
                                animationsMap['iconOnPageLoadAnimation4']!),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Container(
                            width: 390,
                            child: Slider(
                              activeColor: FlutterFlowTheme.of(context).error,
                              inactiveColor:
                                  FlutterFlowTheme.of(context).alternate,
                              min: 0.0,
                              max: 10.0,
                              value: _model.sliderValue ?? 1.0,
                              onChanged: (double newValue) {
                                final double rounded =
                                    double.parse(newValue.toStringAsFixed(2));
                                safeSetState(() {
                                  _model.sliderValue = rounded;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'dni4ea0d' /* 0 : 32 */,
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
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(280, 0, 0, 0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'dh4lxyri' /* 3 : 00 */,
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
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  PlayerpgModel createModel(
      BuildContext context, PlayerpgModel Function() param1) {
    return param1();
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    // ignore: invalid_use_of_protected_member
    setState(fn);
  }
}

extension on Icon {
  animateOnPageLoad(AnimationInfo animationInfo) async {}
}

extension on BuildContext {
  void safePop() {}
}

class AnimationTrigger {
  // ignore: prefer_typing_uninitialized_variables
  static var onPageLoad;
}

class PlayerpgModel {
  double? sliderValue;

  void dispose() {}
}
