import 'dart:convert';

import 'package:clone_aom/loginpage/models/employee_response.dart';
import 'package:clone_aom/loginpage/services/auth_service.dart';
import 'package:http/http.dart' as http;

class EmployeeApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final AuthService _authService = AuthService();

  //fetch employees
  Future<EmployeeResponse> fetchEmployees() async {
    try {
      final url = Uri.parse('$baseUrl/hcm/employee/filter?key=&size=10&page=0');
      print('Fetching employees from: $url'); // Debug log

      // Get auth headers with token
      final headers = await _authService.getAuthHeaders();
      
      final response = await http.post(
        url,
        headers: headers,
      );

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EmployeeResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Handle unauthorized error (token expired or invalid)
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch employees: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching employees: $e'); // Debug log
      throw Exception('Network error: $e');
    }
  }

  //other functions
}
