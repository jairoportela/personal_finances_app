import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  ApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> getData({
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

  Future<Map<String, dynamic>> postData({
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

  Future<Map<String, dynamic>> patchData({
    required String apiUrl,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await _httpClient.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(body),
      );
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteData({
    required String apiUrl,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _httpClient.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (error) {
      rethrow;
    }
  }
}
