import 'package:go_router/go_router.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/auth/firebase_auth/auth_util.dart';

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

  @override
  void initState() {
    super.initState();
    _model = ProfilepgModel();
    _model.addListener(_onModelChanged);

    // Load profile for the currently signed-in user
    final uid = getCurrentUser()?.uid;
    if (uid != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
      _model.initialize(userRef);
    }

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

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}M';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}K';
    }
    return count.toString();
  }

  void _showEditNameDialog() {
    final controller =
        TextEditingController(text: _model.userDisplayName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF21005D),
        title: const Text('Edit Name',
            style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Display name',
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).error)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              _model.updateDisplayName(controller.text.trim());
              Navigator.pop(ctx);
            },
            child: Text('Save',
                style:
                    TextStyle(color: FlutterFlowTheme.of(context).error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Profile',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/basehomepg');
                }
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText('i5drd5l2' /* Profile */),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.interTight(),
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 0,
                  ),
            ),
            centerTitle: true,
            elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Container(
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
              child: _model.isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(color: Colors.white))
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 24),

                          // ── Avatar + edit icon ──
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle),
                                child: _model.userPhotoUrl != null
                                    ? Image.network(
                                        _model.userPhotoUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) =>
                                            _avatarPlaceholder(),
                                      )
                                    : _avatarPlaceholder(),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _showEditNameDialog,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .error,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.edit,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // ── Display name ──
                          GestureDetector(
                            onTap: _showEditNameDialog,
                            child: Text(
                              _model.userDisplayName,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w700),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          // ── Email sub-label ──
                          Text(
                            getCurrentUser()?.email ?? '',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  font: GoogleFonts.inter(),
                                  color: Colors.white54,
                                ),
                          ),

                          const SizedBox(height: 20),

                          // ── Followers / Posts / Likes row ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _statColumn(
                                  _formatCount(_model.followersCount),
                                  'Followers'),
                              _statColumn(
                                  _formatCount(_model.posts.length),
                                  'Posts'),
                              _statColumn(
                                  _formatCount(_model.likesCount), 'Likes'),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // ── Follow button ──
                          GestureDetector(
                            onTap: () {
                              // Follow/unfollow self is disabled;
                              // wire this for visiting another user's profile.
                            },
                            child: Container(
                              width: 110,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBF5AF2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  FFLocalizations.of(context)
                                      .getText('w8gn2nab' /* follow */),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ── About card ──
                          Opacity(
                            opacity: 0.9,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).error,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name + follow header inside card
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _model.userDisplayName,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFBF5AF2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'follow',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // About text
                                  Text(
                                    _model.currentUserDocument?['about'] ??
                                        'Music lover. Playlist curator. Always finding the next big sound.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(),
                                          color: Colors.white70,
                                        ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Posts label
                                  Text(
                                    'Posts',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                  ),

                                  const SizedBox(height: 12),

                                  // Posts grid
                                  _model.posts.isEmpty
                                      ? Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            child: Text(
                                              'No posts yet',
                                              style: const TextStyle(
                                                  color: Colors.white54),
                                            ),
                                          ),
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                          ),
                                          itemCount: _model.posts.length,
                                          itemBuilder: (context, index) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                _model.posts[index],
                                                fit: BoxFit.cover,
                                                errorBuilder: (c, e, s) =>
                                                    Container(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ── Sign out ──
                          GestureDetector(
                            onTap: () async {
                              await _model.signOut();
                              if (context.mounted) {
                                context.go('/loginpg');
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: Colors.white24, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.logout,
                                      color: Colors.white70, size: 20),
                                  SizedBox(width: 8),
                                  Text('Sign out',
                                      style:
                                          TextStyle(color: Colors.white70)),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          if (_model.errorMessage != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                _model.errorMessage!,
                                style: const TextStyle(
                                    color: Colors.redAccent),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarPlaceholder() {
    return Container(
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: const Icon(Icons.person, color: Colors.white54, size: 60),
    );
  }

  Widget _statColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.w700),
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.inter(),
                color: Colors.white60,
              ),
        ),
      ],
    );
  }
}
