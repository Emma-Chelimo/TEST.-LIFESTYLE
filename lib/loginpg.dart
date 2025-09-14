import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_one/Playerpg.dart';
import 'package:project_one/basehomepg.dart';
import 'package:project_one/signin.dart';

//import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
//import '/flutter_flow/flutter_flow_util.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
//import 'dart:ui';
//import '/index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:provider/provider.dart';

//import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  static String routeName = 'login';
  static String routePath = 'login';

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  get authManager => null;

  get kTransitionInfoKey => null;

  @override
  void initState() {
    super.initState();
    _model = LoginModel();

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
        title: 'login',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'znx3bkg4' /* Login */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 22,
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
                      'assets/images/53bb7ee361263b56c290ed2eaa1fe39b.jpg',
                    ).image,
                  ),
                  border: Border.all(
                    width: 0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AnimatedOpacity(
                      opacity: 0.8,
                      duration: 300.ms,
                      curve: Curves.easeInOut,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (_model.email.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Email required!',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    await authManager.updateEmail(
                                      email: _model.email,
                                      context: context,
                                    );
                                    safeSetState(() {});
                                  },
                                  child: Text(
                                    key: ValueKey(valueOrDefault<String>(
                                      _model.email,
                                      'email',
                                    )),
                                    valueOrDefault<String>(
                                      _model.email,
                                      'email',
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
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.8,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await authManager.updatePassword(
                                      newPassword: _model.password,
                                      context: context,
                                    );
                                    safeSetState(() {});

                                    context.goNamedAuth(
                                        BasehomepgWidget.routeName,
                                        context.mounted);
                                  },
                                  child: Text(
                                    key: ValueKey(_model.password),
                                    valueOrDefault<String>(
                                      _model.password,
                                      'password',
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          GoRouter.of(context).prepareAuthEvent();

                          final user = await authManager.signInWithEmail(
                            context,
                            _model.email,
                            _model.password,
                          );
                          if (user == null) {
                            return;
                          }

                          context.goNamedAuth(
                              BasehomepgWidget.routeName, context.mounted);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFEF395A),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            border: Border.all(
                              color: Color(0xFFEF39AA),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 10, 0, 0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'qlkakz9m' /* Login */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (Navigator.of(context).canPop()) {
                            context.pop();
                          }
                          context.pushNamed(
                            SignInWidget.routeName,
                            extra: <String, dynamic>{
                              kTransitionInfoKey: TransitionInfo(
                                hasTransition: true,
                                transitionType: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 0),
                              ),
                            },
                          );
                        },
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'yx7lot7m' /* Dont have an account, create */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void safeSetState(Null Function() param0) {}

  T valueOrDefault<T>(T? value, T defaultValue) {
    return value ?? defaultValue;
  }

  LoginModel createModel(BuildContext context, LoginModel Function() param1) {
    return param1();
  }
}

class TransitionInfo {
  final bool hasTransition;
  final PageTransitionType? transitionType;
  final Duration? duration;
  TransitionInfo({
    required this.hasTransition,
    this.transitionType,
    this.duration,
  });
}

extension on GoRouter {
  void prepareAuthEvent() {}
}

extension on BuildContext {
  void goNamedAuth(String routeName, bool mounted) {}
}

class LoginModel {
  get email => null;

  get password => null;

  void dispose() {}
}
