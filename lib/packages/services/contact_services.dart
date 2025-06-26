import 'dart:convert';

import 'package:clone_aom/packages/models/contact/employee_response.dart';
import 'package:clone_aom/packages/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/contact/employee_detail_response.dart';

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

      final response = await http.post(url, headers: headers);

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

class EmployeeDetailApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final AuthService _authService = AuthService();

  Future<EmployeeDetailResponse> fetchEmployeeDetail(int employeeId) async {
    try {
      final url = Uri.parse('$baseUrl/hcm/employee/$employeeId/detail');
      print('Fetching employee detail from: $url'); // Debug log

      // Get auth headers with token
      final headers = await _authService.getAuthHeaders();

      final response = await http.get(url, headers: headers);

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EmployeeDetailResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Handle unauthorized error (token expired or invalid)
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch employee detail: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching employee detail: $e'); // Debug log
      throw Exception('Network error: $e');
    }
  }
}
