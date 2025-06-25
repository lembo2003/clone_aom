import 'dart:convert';

import 'package:clone_aom/packages/models/project_list_response.dart';
import 'package:clone_aom/packages/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ProjectApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final AuthService _authService = AuthService();

  //fetch project
  Future<ProjectListResponse> fetchProjects() async {
    try {
      final url = Uri.parse('$baseUrl/pm/project/get-page?page=0&size=10');
      print('Fetching employees from: $url');

      //get auth token with header
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProjectListResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch projects: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching projects: $e');
      throw Exception('Network error: $e');
    }
  }
}
