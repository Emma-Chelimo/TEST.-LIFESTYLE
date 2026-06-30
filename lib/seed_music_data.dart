// One-time script to populate Firestore with sample music data so the
// home page has real content to render during development.
//
// Run with:
//   dart run lib/scripts/seed_music_data.dart
// (or `flutter run -t lib/scripts/seed_music_data.dart` if `dart run`
// can't resolve Firebase plugins in your environment)
//
// Safe to re-run: it overwrites the same fixed document IDs rather than
// duplicating data.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBindingShim.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final db = FirebaseFirestore.instance;

  final songs = <String, Map<String, dynamic>>{
    'song_1': {
      'title': 'Praise the Lord',
      'artist': 'Asap Rocky',
      'coverUrl': 'https://picsum.photos/seed/song1/400',
      'audioUrl': '',
      'albumId': 'album_1',
      'duration': 198,
    },
    'song_2': {
      'title': 'Not Like Us',
      'artist': 'Kendrick Lamar',
      'coverUrl': 'https://picsum.photos/seed/song2/400',
      'audioUrl': '',
      'albumId': 'album_2',
      'duration': 274,
    },
    'song_3': {
      'title': 'Birds of a Feather',
      'artist': 'Billie Eilish',
      'coverUrl': 'https://picsum.photos/seed/song3/400',
      'audioUrl': '',
      'albumId': 'album_3',
      'duration': 210,
    },
    'song_4': {
      'title': 'Bundle by Bundle',
      'artist': 'Burna Boy',
      'coverUrl': 'https://picsum.photos/seed/song4/400',
      'audioUrl': '',
      'albumId': 'album_1',
      'duration': 189,
    },
    'song_5': {
      'title': 'Come Closer',
      'artist': 'Wizkid ft Drake',
      'coverUrl': 'https://picsum.photos/seed/song5/400',
      'audioUrl': '',
      'albumId': 'album_2',
      'duration': 230,
    },
    'song_6': {
      'title': 'Essence',
      'artist': 'Wizkid ft Tems',
      'coverUrl': 'https://picsum.photos/seed/song6/400',
      'audioUrl': '',
      'albumId': 'album_3',
      'duration': 250,
    },
  };

  final albums = <String, Map<String, dynamic>>{
    'album_1': {
      'title': 'The Weeknd',
      'artist': 'The Weeknd',
      'coverUrl': 'https://picsum.photos/seed/album1/400',
      'songIds': ['song_1', 'song_4'],
    },
    'album_2': {
      'title': 'Chris Brown',
      'artist': 'Chris Brown',
      'coverUrl': 'https://picsum.photos/seed/album2/400',
      'songIds': ['song_2', 'song_5'],
    },
    'album_3': {
      'title': 'Ariana Grande',
      'artist': 'Ariana Grande',
      'coverUrl': 'https://picsum.photos/seed/album3/400',
      'songIds': ['song_3', 'song_6'],
    },
  };

  final playlists = <String, Map<String, dynamic>>{
    'playlist_1': {
      'name': 'Pop Mix',
      'coverUrl': 'https://picsum.photos/seed/playlist1/400',
      'ownerId': null,
      'songIds': ['song_3', 'song_5'],
      'createdAt': FieldValue.serverTimestamp(),
    },
    'playlist_2': {
      'name': 'Chill Mix',
      'coverUrl': 'https://picsum.photos/seed/playlist2/400',
      'ownerId': null,
      'songIds': ['song_1', 'song_6'],
      'createdAt': FieldValue.serverTimestamp(),
    },
    'playlist_3': {
      'name': 'Daily Mix',
      'coverUrl': 'https://picsum.photos/seed/playlist3/400',
      'ownerId': null,
      'songIds': ['song_2', 'song_4'],
      'createdAt': FieldValue.serverTimestamp(),
    },
    'playlist_4': {
      'name': 'Vryota Mix',
      'coverUrl': 'https://picsum.photos/seed/playlist4/400',
      'ownerId': null,
      'songIds': ['song_5', 'song_6'],
      'createdAt': FieldValue.serverTimestamp(),
    },
    'playlist_5': {
      'name': 'Shallipopi Mix',
      'coverUrl': 'https://picsum.photos/seed/playlist5/400',
      'ownerId': null,
      'songIds': ['song_1', 'song_2'],
      'createdAt': FieldValue.serverTimestamp(),
    },
    'playlist_6': {
      'name': 'Afro Pop Jams',
      'coverUrl': 'https://picsum.photos/seed/playlist6/400',
      'ownerId': null,
      'songIds': ['song_3', 'song_4'],
      'createdAt': FieldValue.serverTimestamp(),
    },
  };

  for (final entry in songs.entries) {
    await db.collection('songs').doc(entry.key).set(entry.value);
    print('Seeded song: ${entry.key}');
  }
  for (final entry in albums.entries) {
    await db.collection('albums').doc(entry.key).set(entry.value);
    print('Seeded album: ${entry.key}');
  }
  for (final entry in playlists.entries) {
    await db.collection('playlists').doc(entry.key).set(entry.value);
    print('Seeded playlist: ${entry.key}');
  }

  print('Done seeding Firestore music data.');
}

/// Minimal shim so this script can run via `dart run` without pulling in
/// the full Flutter widgets binding. If running via `flutter run -t`,
/// Flutter's own binding initialization takes over and this is a no-op.
class WidgetsFlutterBindingShim {
  static void ensureInitialized() {}
}
