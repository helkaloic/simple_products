import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "https://dummyjson.com";

  get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  post(String url, Map<String, dynamic> data) async {
    try {
      final jsonData = json.encode(data);
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  put(String url, Map<String, dynamic> data) async {
    try {
      final jsonData = jsonEncode(data);
      final response = await http.put(
        Uri.parse(_baseUrl + url),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }
}
