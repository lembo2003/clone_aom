import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/folder_detail_response.dart';
import '../models/folder_list_response.dart';
import 'auth_service.dart';

enum FileType { folder, document, image, other }

class FileItem {
  final String name;
  final String size;
  final DateTime date;
  final FileType type;
  final String? pathFolder;
  final int? id;
  final int? parentId;

  FileItem({
    required this.name,
    required this.size,
    required this.date,
    required this.type,
    this.pathFolder,
    this.id,
    this.parentId,
  });

  static FileType _getFileTypeFromString(String? type) {
    if (type == null) return FileType.other;
    switch (type.toLowerCase()) {
      case 'folder':
        return FileType.folder;
      case 'document':
        return FileType.document;
      case 'image':
        return FileType.image;
      default:
        return FileType.other;
    }
  }

  factory FileItem.fromFolderListContent(FolderListContent content) {
    return FileItem(
      name: content.name ?? '',
      size: content.size != null ? formatFileSize(content.size!) : '--',
      date: DateTime.now(),
      type: FileType.folder,
      pathFolder: content.pathFolder,
      id: content.id,
      parentId: content.parentId,
    );
  }

  factory FileItem.fromFolderDetailContent(FolderDetailContent content) {
    // Try to parse the size string to int, fallback to 0 if fails
    int? sizeInBytes;
    try {
      sizeInBytes = int.tryParse(content.size ?? '0');
    } catch (e) {
      print('Error parsing file size: $e');
    }

    return FileItem(
      name: content.name ?? '',
      size:
          sizeInBytes != null
              ? formatFileSize(sizeInBytes)
              : content.size ?? '0',
      date: content.createDate ?? DateTime.now(),
      type: _getFileTypeFromString(content.type),
      pathFolder: content.path,
      id: content.id,
      parentId: null,
    );
  }

  // Helper method to get display path
  String getDisplayPath() {
    if (pathFolder == null || pathFolder!.isEmpty) {
      return name;
    }
    return pathFolder!;
  }

  static String formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";

    final units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int digitGroups = (log(bytes) / log(1024)).floor();

    return '${NumberFormat("#,##0.#").format(bytes / pow(1024, digitGroups))} ${units[digitGroups]}';
  }
}

class DocumentServices {
  static const String baseUrl = 'http://dev-api.intechno.io.vn/storage';
  final AuthService _authService = AuthService();

  // Add the image preview URL getter
  String getImagePreviewUrl(int imageId) {
    return '$baseUrl/file/preview/$imageId';
  }

  // Fetch image preview with auth headers
  Future<http.Response> fetchImagePreview(int imageId) async {
    try {
      final url = Uri.parse(getImagePreviewUrl(imageId));
      final headers = await _authService.getAuthHeaders();

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      }
      throw Exception(
        'Failed to load image: Server returned ${response.statusCode}',
      );
    } catch (e) {
      print('Error fetching image preview: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      throw Exception('Failed to load image preview: $e');
    }
  }

  // Fetch root folders (with null parentId)
  Future<List<FileItem>> fetchRootFolders() async {
    try {
      final url = Uri.parse('$baseUrl/folders/filter');
      print('Fetching root folders from: $url');

      final headers = await _authService.getAuthHeaders();
      print('Headers: $headers');

      final response = await http.post(url, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final folderResponse = FolderListResponse.fromJson(jsonData);

        if (folderResponse.success == true && folderResponse.data != null) {
          // Filter for root folders (null parentId)
          return folderResponse.data!.content
              .where((folder) => folder.parentId == null)
              .map((folder) => FileItem.fromFolderListContent(folder))
              .toList();
        }
        throw Exception('API returned success: false or no data');
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      }
      throw Exception('Server returned status code: ${response.statusCode}');
    } catch (e) {
      print('Error fetching root folders: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      throw Exception('Failed to fetch root folders: $e');
    }
  }

  // Fetch folders by parent ID
  Future<List<FileItem>> fetchFoldersByParentId(int parentId) async {
    try {
      final url = Uri.parse('$baseUrl/folders/filter');
      print('Fetching folders for parent ID $parentId');

      final headers = await _authService.getAuthHeaders();
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final folderResponse = FolderListResponse.fromJson(jsonData);

        if (folderResponse.success == true && folderResponse.data != null) {
          // Filter for folders with matching parentId
          return folderResponse.data!.content
              .where((folder) => folder.parentId == parentId)
              .map((folder) => FileItem.fromFolderListContent(folder))
              .toList();
        }
        throw Exception('API returned success: false or no data');
      }
      throw Exception('Server returned status code: ${response.statusCode}');
    } catch (e) {
      print('Error fetching folders by parent ID: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      throw Exception('Failed to fetch folders: $e');
    }
  }

  // Fetch folder contents (files and subfolders)
  Future<List<FileItem>> fetchFolderContents(int folderId) async {
    try {
      List<FileItem> folders = [];
      List<FileItem> files = [];

      // First get subfolders
      try {
        folders = await fetchFoldersByParentId(folderId);
      } catch (e) {
        print('Error fetching subfolders: $e');
      }

      // Then get files
      try {
        final filesUrl = Uri.parse(
          '$baseUrl/file/$folderId/files?pageIndex=0&pageSize=20',
        );
        final headers = await _authService.getAuthHeaders();

        final filesResponse = await http.get(filesUrl, headers: headers);

        if (filesResponse.statusCode == 200) {
          final jsonData = json.decode(filesResponse.body);
          final folderDetailResponse = FolderDetailResponse.fromJson(jsonData);

          if (folderDetailResponse.success == true &&
              folderDetailResponse.data != null) {
            files =
                folderDetailResponse.data!.content
                    .map((file) => FileItem.fromFolderDetailContent(file))
                    .toList();
          }
        }
      } catch (e) {
        print('Error fetching files: $e');
      }

      // Combine folders and files, with folders first
      return [...folders, ...files];
    } catch (e) {
      print('Error fetching folder contents: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      throw Exception('Failed to fetch folder contents: $e');
    }
  }

  Future<void> uploadFile({
    required String filePath,
    required String fileName,
    required int folderId,
  }) async {
    try {
      // Get auth headers
      final headers = await _authService.getAuthHeaders();

      // Create multipart request
      var uri = Uri.parse('$baseUrl/file/upload/$folderId');
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll(headers);

      // Add file
      var file = await http.MultipartFile.fromPath(
        'file',
        filePath,
        filename: fileName,
      );
      request.files.add(file);

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception(
          'Upload failed: ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      print('Error in uploadFile: $e'); // Debug log
      throw Exception('Failed to upload file: $e');
    }
  }

  Future<void> DeleteFile(int fileId) async {
    try {
      final url = Uri.parse('$baseUrl/file/$fileId');
      print('Deleting file with ID: $fileId');

      final headers = await _authService.getAuthHeaders();
      final response = await http.delete(url, headers: headers);
      final responseBody = response.body;

      if (response.statusCode == 200) {
        // Success - no need to do anything
        return;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('File not found.');
      } else {
        throw Exception(
          'Failed to delete file: Server returned ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      print('Error deleting file: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      rethrow; // Re-throw the exception to let the caller handle it
    }
  }

  Future<void> DeleteFolder(int folderId) async {
    try {
      final url = Uri.parse('$baseUrl/folders/$folderId');
      print('Deleting folder with ID: $folderId');

      final headers = await _authService.getAuthHeaders();
      final response = await http.delete(url, headers: headers);
      final responseBody = response.body;

      if (response.statusCode == 200) {
        // Success - no need to do anything
        return;
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else if (response.statusCode == 404) {
        throw Exception('Folder not found.');
      } else {
        throw Exception(
          'Failed to delete folder: Server returned ${response.statusCode} - $responseBody',
        );
      }
    } catch (e) {
      print('Error deleting folder: $e');
      if (e is SocketException) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      rethrow; // Re-throw the exception to let the caller handle it
    }
  }
}
