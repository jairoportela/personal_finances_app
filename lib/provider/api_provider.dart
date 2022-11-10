import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  ApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> readData(
    String apiUrl,
    Map<String, String>? headers,
  ) async {
    try {
      final response =
          await _httpClient.get(Uri.parse(apiUrl), headers: headers);
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      rethrow;
    }
  }
}
