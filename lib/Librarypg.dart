import 'package:go_router/go_router.dart';
import 'package:project_one/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'Librarypg_model.dart';

class LibrarypgWidget extends StatefulWidget {
  const LibrarypgWidget({super.key});

  static String routeName = 'librarypg';
  static String routePath = 'librarypg';

  @override
  State<LibrarypgWidget> createState() => _LibrarypgWidgetState();
}

class _LibrarypgWidgetState extends State<LibrarypgWidget> {
  late LibrarypgModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = LibrarypgModel();
    _model.addListener(_onModelChanged);
    _model.initialize();

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

  Widget _categoryPill(String label, IconData icon, LibraryCategory category) {
    final selected = _model.selectedCategory == category;
    return GestureDetector(
      onTap: () => _model.selectCategory(category),
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: selected
              ? FlutterFlowTheme.of(context).error
              : FlutterFlowTheme.of(context).error.withOpacity(0.45),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    fontSize: 20,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Icon(
                icon,
                color: FlutterFlowTheme.of(context).secondaryBackground,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coverTile(Map<String, dynamic> item, String titleKey,
      VoidCallback onTap, {bool showFavoriteIcon = false}) {
    final songId = item['id'] as String?;
    final isFav = songId != null && _model.isFavorite(songId);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  item['coverUrl'] ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 100,
                    height: 100,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
              ),
              if (showFavoriteIcon)
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _model.toggleFavorite(item),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: const Color(0xFFFF6482),
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              item[titleKey] ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    color: FlutterFlowTheme.of(context).alternate,
                    fontSize: 13,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryGrid() {
    final items = _model.currentCategoryItems;
    final titleKey = _model.selectedCategory == LibraryCategory.playlists
        ? 'name'
        : 'title';

    if (_model.isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            'Nothing here yet',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(),
                  color: FlutterFlowTheme.of(context).alternate,
                ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.start,
        children: items.map((item) {
          return _coverTile(
            item,
            titleKey,
            () {
              if (_model.selectedCategory == LibraryCategory.playlists) {
                final songsInPlaylist = item['songs'] as List? ?? [];
                if (songsInPlaylist.isNotEmpty) {
                  final song = songsInPlaylist.first as Map<String, dynamic>;
                  _model.playSong(song);
                  context.pushNamed('playerpg', extra: song);
                }
              } else {
                _model.playSong(item);
                context.pushNamed('playerpg', extra: item);
              }
            },
            showFavoriteIcon: _model.selectedCategory == LibraryCategory.songs ||
                _model.selectedCategory == LibraryCategory.favorites,
          );
        }).toList(),
      ),
    );
  }

  Widget _horizontalRow(String headerText, List<Map<String, dynamic>> items,
      String titleKey) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              headerText,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, i) {
                final item = items[i];
                return _coverTile(item, titleKey, () {
                  if (titleKey == 'name') {
                    final songsInPlaylist = item['songs'] as List? ?? [];
                    if (songsInPlaylist.isNotEmpty) {
                      final song = songsInPlaylist.first as Map<String, dynamic>;
                      _model.playSong(song);
                      context.pushNamed('playerpg', extra: song);
                    }
                  } else {
                    _model.playSong(item);
                    context.pushNamed('playerpg', extra: item);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        title: 'librarypg',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryText,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  '2xlh5z8y' /* Library */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.interTight(),
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Category pills, row 1
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _categoryPill(
                                FFLocalizations.of(context)
                                    .getText('np4khfph' /* Songs */),
                                Icons.music_note,
                                LibraryCategory.songs),
                            _categoryPill(
                                FFLocalizations.of(context)
                                    .getText('n8tq9gzt' /* Albums */),
                                Icons.album_rounded,
                                LibraryCategory.albums),
                          ],
                        ),
                      ),
                      // Category pills, row 2
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _categoryPill(
                                FFLocalizations.of(context)
                                    .getText('42laj7f6' /* Playlists */),
                                Icons.playlist_play,
                                LibraryCategory.playlists),
                            _categoryPill(
                                FFLocalizations.of(context)
                                    .getText('ulvg8t63' /* Favorites */),
                                Icons.favorite,
                                LibraryCategory.favorites),
                          ],
                        ),
                      ),

                      if (_model.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            _model.errorMessage!,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),

                      // Selected category content
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: _categoryGrid(),
                      ),

                      _horizontalRow('Recently Added', _model.recentlyAdded,
                          'name'),
                      _horizontalRow('Recently Played', _model.recentlyPlayed,
                          'title'),

                      const SizedBox(height: 24),
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
