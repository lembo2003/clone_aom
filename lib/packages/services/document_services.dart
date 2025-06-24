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

  // Keep the mock data for fallback and testing
  // static Map<String, List<FileItem>> getInitialFolderContents() {
  //   return {
  //     "attachment": [
  //       FileItem(
  //         name: "Documents",
  //         size: "--",
  //         date: DateTime(2025, 6, 17, 10, 34, 28),
  //         type: FileType.folder,
  //         pathFolder: "attachment/Documents",
  //       ),
  //       FileItem(
  //         name: "Images",
  //         size: "--",
  //         date: DateTime(2025, 6, 17, 10, 34, 28),
  //         type: FileType.folder,
  //         pathFolder: "attachment/Images",
  //       ),
  //       FileItem(
  //         name: "Reports",
  //         size: "--",
  //         date: DateTime(2025, 6, 16, 14, 22, 20),
  //         type: FileType.folder,
  //         pathFolder: "attachment/Reports",
  //       ),
  //       FileItem(
  //         name: "JPT_FS_0.docx",
  //         size: formatFileSize(57058), // 55.7 KB
  //         date: DateTime(2025, 6, 17, 10, 34, 28),
  //         type: FileType.document,
  //         pathFolder: "attachment/JPT_FS_0.docx",
  //       ),
  //       FileItem(
  //         name: "profile.jpg",
  //         size: formatFileSize(220518), // 215.4 KB
  //         date: DateTime(2025, 6, 16, 14, 22, 20),
  //         type: FileType.image,
  //         pathFolder: "attachment/profile.jpg",
  //       ),
  //     ],
  //     "attachment/Images": [
  //       FileItem(
  //         name: "Screenshots",
  //         size: "--",
  //         date: DateTime(2025, 6, 17, 11, 00, 00),
  //         type: FileType.folder,
  //         pathFolder: "attachment/Images",
  //       ),
  //       FileItem(
  //         name: "avatar.png",
  //         size: formatFileSize(102400), // 100 KB
  //         date: DateTime(2025, 6, 17, 10, 45, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/avatar.png",
  //       ),
  //       FileItem(
  //         name: "background.jpg",
  //         size: formatFileSize(2097152), // 2 MB
  //         date: DateTime(2025, 6, 17, 10, 40, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/background.jpg",
  //       ),
  //       FileItem(
  //         name: "logo.png",
  //         size: formatFileSize(51200), // 50 KB
  //         date: DateTime(2025, 6, 17, 10, 35, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/logo.png",
  //       ),
  //     ],
  //     "attachment/Images/Screenshots": [
  //       FileItem(
  //         name: "screenshot_1.png",
  //         size: formatFileSize(153600), // 150 KB
  //         date: DateTime(2025, 6, 17, 11, 30, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/Screenshots/screenshot_1.png",
  //       ),
  //       FileItem(
  //         name: "screenshot_2.png",
  //         size: formatFileSize(179200), // 175 KB
  //         date: DateTime(2025, 6, 17, 11, 35, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/Screenshots/screenshot_2.png",
  //       ),
  //       FileItem(
  //         name: "screenshot_3.png",
  //         size: formatFileSize(204800), // 200 KB
  //         date: DateTime(2025, 6, 17, 11, 40, 00),
  //         type: FileType.image,
  //         pathFolder: "attachment/Images/Screenshots/screenshot_3.png",
  //       ),
  //     ],
  //   };
  // }

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
}
