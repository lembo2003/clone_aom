import 'dart:convert';

import 'package:clone_aom/packages/models/project/project_list_response.dart';
import 'package:clone_aom/packages/models/project/project_overview_response.dart';
import 'package:clone_aom/packages/models/project/project_resources_response.dart';
import 'package:clone_aom/packages/models/project/project_wbs_response.dart';
import 'package:clone_aom/packages/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ProjectApiServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn';
  final AuthService _authService = AuthService();

  //fetch project
  Future<ProjectListResponse> fetchProjects() async {
    try {
      final url = Uri.parse('$baseUrl/pm/project/get-page?page=0&size=10');
      print('Fetching projects from: $url');

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

  //fetch overview
  Future<ProjectOverviewResponse> fetchProjectOverview(int projectId) async {
    try {
      final url = Uri.parse('$baseUrl/pm/project/$projectId/detail');
      print('Fetching project with id $projectId from: $url');

      //get auth token with header
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProjectOverviewResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch projects: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching project overview: $e');
      throw Exception('Network error: $e');
    }
  }

  //fetch project wbs
  Future<ProjectWbsResponse> fetchTaskList(int projectId) async {
    try {
      final url = Uri.parse(
        '$baseUrl/pm/task/$projectId/tree/0?page=0&size=10',
      );
      print('Fetching task with projectID $projectId from: $url');

      //get auth token with header
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ProjectWbsResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch tasks list: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching tasks list: $e');
      throw Exception('Network error: $e');
    }
  }

  //fetch resources list
  Future<ProjectResourcesResponse> fetchResourcesList(int projectId) async {
    try {
      final url = Uri.parse('$baseUrl/pm/project/$projectId/get-resource');
      print('Fetching resources with projectID $projectId from: $url');

      //get auth header
      final headers = await _authService.getAuthHeaders();
      final response = await http.get(url, headers: headers);

      print('Resources API Response Status Code: ${response.statusCode}');
      print('Resources API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Decoded JSON Data: $jsonData');
        final resourceResponse = ProjectResourcesResponse.fromJson(jsonData);
        print('Number of resources: ${resourceResponse.data.length}');
        return resourceResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        throw Exception(
          'Failed to fetch resources list: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching resources list: $e');
      throw Exception('Network error: $e');
    }
  }
}
