import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore-backed data access for music content shown on the home page
/// and elsewhere in the app. Collections used:
///   - songs:     { title, artist, coverUrl, audioUrl, albumId, duration }
///   - albums:    { title, artist, coverUrl, songIds: [songId, ...] }
///   - playlists: { name, coverUrl, ownerId, songIds: [songId, ...], createdAt }
class MusicService {
  MusicService._();
  static final MusicService instance = MusicService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _songs =>
      _db.collection('songs');
  CollectionReference<Map<String, dynamic>> get _albums =>
      _db.collection('albums');
  CollectionReference<Map<String, dynamic>> get _playlists =>
      _db.collection('playlists');

  Future<List<Map<String, dynamic>>> fetchPlaylists({int limit = 10}) async {
    final snap = await _playlists.limit(limit).get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAlbums({int limit = 10}) async {
    final snap = await _albums.limit(limit).get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  /// "Recommended" is just the song catalog for now; swap for real
  /// recommendation logic later (e.g. based on listening history).
  Future<List<Map<String, dynamic>>> fetchRecommendedSongs(
      {int limit = 10}) async {
    final snap = await _songs.limit(limit).get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> fetchSongsByIds(
      List<dynamic> songIds) async {
    if (songIds.isEmpty) return [];
    final ids = songIds.map((e) => e.toString()).toList();
    // Firestore whereIn supports up to 30 values per query.
    final chunks = <List<String>>[];
    for (var i = 0; i < ids.length; i += 30) {
      chunks.add(ids.sublist(i, i + 30 > ids.length ? ids.length : i + 30));
    }
    final results = <Map<String, dynamic>>[];
    for (final chunk in chunks) {
      final snap = await _songs
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      results.addAll(snap.docs.map((d) => {'id': d.id, ...d.data()}));
    }
    return results;
  }

  /// Most recently played song for a user, used to populate the
  /// "now playing" pill on first load. Falls back to null if the
  /// user has no history yet or isn't signed in.
  Future<Map<String, dynamic>?> fetchLastPlayed(String? uid) async {
    if (uid == null) return null;
    final snap = await _db
        .collection('users')
        .doc(uid)
        .collection('recentlyPlayed')
        .orderBy('playedAt', descending: true)
        .limit(1)
        .get();
    if (snap.docs.isEmpty) return null;
    final songId = snap.docs.first.data()['songId'] as String?;
    if (songId == null) return null;
    final songDoc = await _songs.doc(songId).get();
    if (!songDoc.exists) return null;
    return {'id': songDoc.id, ...songDoc.data()!};
  }

  Future<List<Map<String, dynamic>>> fetchAllSongs({int limit = 50}) async {
    final snap = await _songs.limit(limit).get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  Future<List<Map<String, dynamic>>> fetchFavorites(String? uid) async {
    if (uid == null) return [];
    final snap = await _db
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();
    final ids = snap.docs.map((d) => d.id).toList();
    return fetchSongsByIds(ids);
  }

  Future<void> toggleFavorite(String? uid, String songId, bool isFav) async {
    if (uid == null) return;
    final ref = _db
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(songId);
    if (isFav) {
      await ref.set({'addedAt': FieldValue.serverTimestamp()});
    } else {
      await ref.delete();
    }
  }
}
