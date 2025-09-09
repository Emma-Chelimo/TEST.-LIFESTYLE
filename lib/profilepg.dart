import 'package:go_router/go_router.dart';
import 'package:project_one/Playerpg.dart';
import 'package:project_one/basehomepg.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'profilepg_model.dart';
export 'profilepg_model.dart';

class ProfilepgWidget extends StatefulWidget {
  const ProfilepgWidget({super.key});

  static String routeName = 'profilepg';
  static String routePath = 'profilepg';

  @override
  State<ProfilepgWidget> createState() => _ProfilepgWidgetState();
}

class _ProfilepgWidgetState extends State<ProfilepgWidget> {
  late ProfilepgModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DocumentReference<Map<String, dynamic>>? currentUserReference;
  dynamic currentUserDocument;
  String currentUserDisplayName = 'User';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilepgModel());

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
        title: 'profilepg',
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
                    'i5drd5l2' /* Profile */,
                  ),
                  textAlign: TextAlign.start,
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
              elevation: 2,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(BasehomepgWidget.routeName);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(330, 0, 0, 0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Container(
                              width: 200,
                              height: 200,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://picsum.photos/seed/875/600',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final selectedMedia =
                                  await selectMediaWithSourceBottomSheet(
                                context: context,
                                maxWidth: 16.00,
                                maxHeight: 9.00,
                                allowPhoto: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                // Enforce minimum file size of 500 bytes
                                final tooSmall = selectedMedia.any((m) =>
                                    (m.bytes == null ||
                                        (m.bytes?.length ?? 0) < 500));
                                if (tooSmall) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'File must be at least 500 bytes.')),
                                  );
                                  return;
                                }
                                safeSetState(() => _model
                                    .isDataUploading_uploadData3xk = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                List<String?> downloadUrls = <String?>[];
                                try {
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  _model.isDataUploading_uploadData3xk = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFile_uploadData3xk =
                                        selectedUploadedFiles.first;
                                    _model.uploadedFileUrl_uploadData3xk =
                                        downloadUrls.first;
                                  });
                                } else {
                                  safeSetState(() {});
                                  return;
                                }
                              }

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                photoUrl: _model.uploadedFileUrl_uploadData3xk,
                              ));
                            },
                            child: Icon(
                              Icons.edit_sharp,
                              color: FlutterFlowTheme.of(context).cerise,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 94, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // AuthUserStreamWidget replacement
                          Builder(
                            builder: (context) => Text(
                              valueOrDefault<String>(
                                formatNumber(
                                  (currentUserDocument?.followers?.toList() ??
                                          [])
                                      .length,
                                  formatType: FormatType.compact,
                                ),
                                '000',
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
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                          Builder(
                            builder: (context) => Text(
                              valueOrDefault<String>(
                                formatNumber(
                                  (currentUserDocument?.likes?.toList() ?? [])
                                      .length,
                                  formatType: FormatType.compact,
                                ),
                                '000',
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
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
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
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'jcvhlyyz' /* Followers */,
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
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'cklktga1' /* Likes */,
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
                                        .secondaryBackground,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ],
                    ),
                    Opacity(
                      opacity: 0.8,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Container(
                          width: 400,
                          height: 290,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).error,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35),
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: Builder(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'display_name':
                                                              FieldValue
                                                                  .delete(),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      currentUserDisplayName,
                                                      'Name',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(200, 0, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'following': FieldValue
                                                            .arrayUnion([
                                                          currentUserReference
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                },
                                                child: Container(
                                                  width: 90,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFBF5AF2),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                      bottomRight:
                                                          Radius.circular(25),
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'w8gn2nab' /* follow */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize: 18,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(30, 0, 0, 0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final selectedMedia =
                                                      await selectMediaWithSourceBottomSheet(
                                                    context: context,
                                                    maxWidth: 6.00,
                                                    maxHeight: 6.00,
                                                    allowPhoto: true,
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    // Enforce minimum file size of 500 bytes
                                                    final tooSmall = selectedMedia
                                                        .any((m) => (m.bytes ==
                                                                null ||
                                                            (m.bytes?.length ??
                                                                    0) <
                                                                500));
                                                    if (tooSmall) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'File must be at least 500 bytes.')),
                                                      );
                                                      return;
                                                    }
                                                    safeSetState(() => _model
                                                            .isDataUploading_uploadDataGye =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];

                                                    List<String?> downloadUrls =
                                                        <String?>[];
                                                    try {
                                                      selectedUploadedFiles =
                                                          selectedMedia
                                                              .map((m) =>
                                                                  FFUploadedFile(
                                                                    name: m
                                                                        .storagePath
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                    blurHash: m
                                                                        .blurHash,
                                                                  ))
                                                              .toList();

                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedMedia.map(
                                                          (m) async =>
                                                              await uploadData(
                                                                  m.storagePath,
                                                                  m.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      _model.isDataUploading_uploadDataGye =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
                                                      safeSetState(() {
                                                        _model.uploadedLocalFile_uploadDataGye =
                                                            selectedUploadedFiles
                                                                .first;
                                                        _model.uploadedFileUrl_uploadDataGye =
                                                            downloadUrls.first;
                                                      });
                                                    } else {
                                                      safeSetState(() {});
                                                      return;
                                                    }
                                                  }

                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'posts': FieldValue
                                                            .arrayUnion([
                                                          _model
                                                              .uploadedFileUrl_uploadData3xk
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.post_add_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '9xoabwip' /* Tap to add post */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 398.71,
                                height: 184,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).error,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                  ),
                                ),
                                child: Builder(
                                  builder: (context) =>
                                      StreamBuilder<List<dynamic>>(
                                    stream: const Stream.empty(),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .error,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<dynamic> gridViewUsersRecordList =
                                          snapshot.data!;

                                      return ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          scrollbars: true,
                                          dragDevices: {
                                            PointerDeviceKind.mouse,
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.stylus,
                                            PointerDeviceKind.unknown,
                                          },
                                        ),
                                        child: Scrollbar(
                                            child: GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 1,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              gridViewUsersRecordList.length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewUsersRecord =
                                                gridViewUsersRecordList[
                                                    gridViewIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(20, 20, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 128.71,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(25),
                                                    bottomRight:
                                                        Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                                      );
                                    },
                                  ),
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
        ));
  }

  ProfilepgModel createModel(
      BuildContext context, ProfilepgModel Function() factoryFn) {
    return factoryFn();
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }

  Future<List<SelectedMedia>?> selectMediaWithSourceBottomSheet({
    required BuildContext context,
    required double maxWidth,
    required double maxHeight,
    required bool allowPhoto,
  }) async {
    // Stub: return null to indicate no selection
    return null;
  }

  bool validateFileFormat(String storagePath, BuildContext context) {
    return true;
  }

  Future<String?> uploadData(String storagePath, List<int>? bytes) async {
    // Stub: return null to indicate failed upload
    return null;
  }

  Map<String, dynamic> createUsersRecordData({required String? photoUrl}) {
    return {'photoUrl': photoUrl};
  }

  Map<String, dynamic> mapToFirestore(Map<String, dynamic> map) {
    return map;
  }

  T valueOrDefault<T>(T? value, T defaultValue) {
    return value ?? defaultValue;
  }

  // Local fallbacks for formatting used in this screen
  String formatNumber(num value, {FormatType? formatType}) {
    // Simple compact-like formatting
    if (value >= 1000000) {
      return (value / 1000000)
              .toStringAsFixed(1)
              .replaceAll(RegExp(r"\.0$"), '') +
          'M';
    }
    if (value >= 1000) {
      return (value / 1000).toStringAsFixed(1).replaceAll(RegExp(r"\.0$"), '') +
          'K';
    }
    return value.toString();
  }
}

enum FormatType { compact }

class FFUploadedFile {
  final String? name;
  final List<int>? bytes;
  final double? height;
  final double? width;
  final String? blurHash;

  FFUploadedFile(
      {this.name, this.bytes, this.height, this.width, this.blurHash});
}

class SelectedMedia {
  final String storagePath;
  final List<int>? bytes;
  final _Dimensions? dimensions;
  final String? blurHash;
  SelectedMedia(
      {required this.storagePath, this.bytes, this.dimensions, this.blurHash});
}

class _Dimensions {
  final double height;
  final double width;
  _Dimensions(this.height, this.width);
}

extension on BuildContext {
  void safePop() {}
}

class ProfilepgModel {
  bool isDataUploading_uploadData3xk = false;
  bool isDataUploading_uploadDataGye = false;
  FFUploadedFile? uploadedLocalFile_uploadData3xk;
  String? uploadedFileUrl_uploadData3xk;
  FFUploadedFile? uploadedLocalFile_uploadDataGye;
  String? uploadedFileUrl_uploadDataGye;

  void dispose() {}
}
