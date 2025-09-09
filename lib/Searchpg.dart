import 'package:go_router/go_router.dart';
import 'package:project_one/Playerpg.dart';
import 'package:project_one/basehomepg.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'searchpg_model.dart';
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

  @override
  void initState() {
    super.initState();
    _model = SearchpgModel();

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
        title: 'Searchpg',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
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
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context
                                        .pushNamed(BasehomepgWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, -1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40, 10, 0, 0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ew3rq1b7' /* Search */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Opacity(
                        opacity: 0.8,
                        child: Align(
                          alignment: AlignmentDirectional(-1, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(50, 20, 0, 0),
                            child: Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                border: Border.all(
                                  color: Color(0xFF444267),
                                ),
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.apiResultdn2 =
                                      await SearchspotifyCall.call(
                                          query: 'drake');

                                  if (!(_model.apiResultdn2?.succeeded ??
                                      false)) {
                                    _model.apiResultuj2 =
                                        await SearchspotifyCall.call(
                                            query: 'taylor');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          false.toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: FaIcon(
                                        FontAwesomeIcons.listUl,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          40, 0, 0, 0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          '6n2oxw9r' /* Hinted search */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          90, 0, 0, 0),
                                      child: Icon(
                                        Icons.search,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 250, 0, 0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '7nfemu1b' /* B */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.islandMoments(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    color: Color(0xFFE10E2C),
                                    fontSize: 50,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
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
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              border: Border.all(
                                color: Color(0xFF46184F),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/asap.jpg',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  80, 0, 0, 0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '3zk0r6jg' /* Song */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            40, 0, 0, 0),
                                        child: Icon(
                                          Icons.pause_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            30, 0, 0, 0),
                                        child: Icon(
                                          Icons.skip_next,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
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
        ));
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
