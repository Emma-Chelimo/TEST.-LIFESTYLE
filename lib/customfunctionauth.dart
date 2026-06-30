import 'package:app_links/app_links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> spotifyAuth(String clientId, String clientSecret, String redirectUri) async {
  final authUrl = 'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=user-modify-playback-state';
  final Uri? initialUri = await AppLinks().getInitialAppLink();
  if (initialUri == null) {
    throw Exception('Authentication failed: no redirect URI received.');
  }
  final result = initialUri.toString();

  final code = Uri.parse(result).queryParameters['code'];
  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    body: {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': redirectUri,
      'client_id': clientId,
      'client_secret': clientSecret,
    },
  );
  return json.decode(response.body);
}

extension on AppLinks {
  Future<Uri?> getInitialAppLink() async {
    return null;
  }
}