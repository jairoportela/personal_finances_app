import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  ApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> readData({
    required String apiUrl,
    Map<String, String>? headers,
  }) async {
    try {
      final response =
          await _httpClient.get(Uri.parse(apiUrl), headers: headers);
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> queryData({
    required String apiUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      rethrow;
    }
  }
}
