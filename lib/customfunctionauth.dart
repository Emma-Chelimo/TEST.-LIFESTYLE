import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> spotifyAuth(String clientId, String clientSecret, String redirectUri) async {
  final authUrl = 'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=user-modify-playback-state';
  final result = await FlutterWebAuth.authenticate(url: authUrl, callbackUrlScheme: 'yourapp');

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