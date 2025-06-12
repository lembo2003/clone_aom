import 'dart:convert';

import 'package:clone_aom/loginpage/models/employee_response.dart';
import 'package:http/http.dart' as http;

class EmployeeApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';

  //fetch employees
  static Future<EmployeeResponse> fetchEmployees() async {
    try {
      final url = Uri.parse('$baseUrl/hcm/employee/filter?key=&size=10&page=0');
      print('Fetching employees from: $url'); // Debug log

      //Remember, this isnt handling the access token, handle them later.
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Referer': 'http://map.intechno.io.vn/',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36',
        },
      );

      print('Response status code: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return EmployeeResponse.fromJson(jsonData);
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
