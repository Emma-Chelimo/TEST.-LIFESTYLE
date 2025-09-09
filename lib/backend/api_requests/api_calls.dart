import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCallResponse {
  final bool succeeded;
  final dynamic jsonBody;
  final int statusCode;
  ApiCallResponse(
      {required this.succeeded, this.jsonBody, required this.statusCode});
}

class SearchspotifyCall {
  static Future<ApiCallResponse> call({String query = 'test'}) async {
    try {
      final uri = Uri.parse(
          'https://itunes.apple.com/search?term=${Uri.encodeQueryComponent(query)}');
      final res = await http.get(uri);
      final body = json.decode(res.body);
      return ApiCallResponse(
          succeeded: res.statusCode == 200,
          jsonBody: body,
          statusCode: res.statusCode);
    } catch (e) {
      return ApiCallResponse(
          succeeded: false, jsonBody: {'error': e.toString()}, statusCode: 500);
    }
  }
}
