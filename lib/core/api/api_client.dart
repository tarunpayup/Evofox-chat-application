import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers ??
            {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
        body: jsonEncode(body),
      );

      if (response.body.isEmpty) {
        throw Exception("Empty response from server.");
      }

      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body);

      return jsonResponse;
    } on http.ClientException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } on FormatException {
      throw Exception("Invalid JSON response from server.");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}