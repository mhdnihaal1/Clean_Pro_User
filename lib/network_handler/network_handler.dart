import 'dart:convert';
import 'package:clean_pro_user/constants/urls.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

class NetworkHandler {
  static const String _baseUrl = AppUrls.baseUrl;
  // 'https://clean-pro.onrender.com/api/user'; // Replace with your API base URL
//https://clean-pro.onrender.com/api/user
  static Future<dynamic> get(String endpoint) async {
    try {
      final http.Response response =
          await http.get(Uri.parse('$_baseUrl/$endpoint'));
      return jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> post(
      String endpoint, Map<String, dynamic> body) async {
    final http.Response response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    // if (await isInternetConnected()) {
    final http.Response response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> delete(String endpoint) async {
    // if (await isInternetConnected()) {
    final http.Response response =
        await http.delete(Uri.parse('$_baseUrl/$endpoint'));
    return jsonDecode(response.body);
  }
  // else {
  //   throw Exception('No internet connection');
  // }
  // }
}
