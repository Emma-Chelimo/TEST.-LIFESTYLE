import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> searchSong(String query) async {
  if (query.isEmpty) return [];

  final response = await http.get(
    Uri.parse('https://itunes.apple.com/search?term=${Uri.encodeQueryComponent(query)}&limit=10'),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data['results'] != null && data['results'].isNotEmpty) {
      return data['results'].map<Map<String, dynamic>>((song) => {
        'title': song['trackName'] ?? 'Unknown Title',
        'artist': song['artistName'] ?? 'Unknown Artist',
        'albumArtUrl': song['artworkUrl100'] ?? '',
        'audioUrl': song['previewUrl'] ?? '',
        'collectionName': song['collectionName'] ?? 'Unknown Album',
      }).toList();
    }
  }
  return [];
}
class ApiCallResponse {
  final bool succeeded;
  final dynamic jsonBody;
  final int statusCode;
  ApiCallResponse(
      {required this.succeeded, this.jsonBody, required this.statusCode});
}
