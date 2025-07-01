import 'dart:convert';

import 'package:clone_aom/packages/models/category/organization_response.dart';
import 'package:clone_aom/packages/services/auth_service.dart';
import 'package:http/http.dart' as http;

class CategoryApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final AuthService _authService = AuthService();

  //fetch org
  Future<OrganizationResponse> fetchOrg() async {
    try {
      final url = Uri.parse('$baseUrl/category/org/get-all');
      print('Fetching org from: $url');

      //get auth token with header
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return OrganizationResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch org: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetch orgs: $e');
      throw Exception('Network error: $e');
    }
  }
}
