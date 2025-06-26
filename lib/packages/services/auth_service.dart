import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth/login_response.dart';
import 'token_storage.dart';

class AuthService {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final TokenStorage _tokenStorage = TokenStorage();

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/control/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Referer': 'http://map.intechno.io.vn/',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(jsonDecode(response.body));
        if (loginResponse.success) {
          // Save token and user ID
          await _tokenStorage.saveToken(loginResponse.data.accessToken);
          if (loginResponse.data.userId != null) {
            await _tokenStorage.saveUserId(loginResponse.data.userId!);
          }
        }
        return loginResponse;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await _tokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Referer': 'http://map.intechno.io.vn/',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36',
    };
  }

  Future<void> logout() async {
    await _tokenStorage.clearToken();
  }
}
