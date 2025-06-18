import 'package:intl/intl.dart';
import 'dart:math';

enum FileType {
  folder,
  document,
  image,
  other,
}

class FileItem {
  final String name;
  final String size;
  final DateTime date;
  final FileType type;
  final int? itemCount;
  final String path;

  FileItem({
    required this.name,
    required this.size,
    required this.date,
    required this.type,
    this.itemCount,
    required this.path,
  });
}

class DocumentServices {
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    
    final units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int digitGroups = (log(bytes) / log(1024)).floor();
    
    return NumberFormat("#,##0.#").format(bytes / pow(1024, digitGroups)) + ' ' + units[digitGroups];
  }

  static Map<String, List<FileItem>> getInitialFolderContents() {
    return {
      "attachment": [
        FileItem(
          name: "Documents",
          size: "--",
          date: DateTime(2025, 6, 17, 10, 34, 28),
          type: FileType.folder,
          itemCount: 5,
          path: "attachment/Documents",
        ),
        FileItem(
          name: "Images",
          size: "--",
          date: DateTime(2025, 6, 17, 10, 34, 28),
          type: FileType.folder,
          itemCount: 12,
          path: "attachment/Images",
        ),
        FileItem(
          name: "Reports",
          size: "--",
          date: DateTime(2025, 6, 16, 14, 22, 20),
          type: FileType.folder,
          itemCount: 3,
          path: "attachment/Reports",
        ),
        FileItem(
          name: "JPT_FS_0.docx",
          size: formatFileSize(57058), // 55.7 KB
          date: DateTime(2025, 6, 17, 10, 34, 28),
          type: FileType.document,
          path: "attachment/JPT_FS_0.docx",
        ),
        FileItem(
          name: "profile.jpg",
          size: formatFileSize(220518), // 215.4 KB
          date: DateTime(2025, 6, 16, 14, 22, 20),
          type: FileType.image,
          path: "attachment/profile.jpg",
        ),
      ],
      "attachment/Images": [
        FileItem(
          name: "Screenshots",
          size: "--",
          date: DateTime(2025, 6, 17, 11, 00, 00),
          type: FileType.folder,
          itemCount: 3,
          path: "attachment/Images/Screenshots",
        ),
        FileItem(
          name: "avatar.png",
          size: formatFileSize(102400), // 100 KB
          date: DateTime(2025, 6, 17, 10, 45, 00),
          type: FileType.image,
          path: "attachment/Images/avatar.png",
        ),
        FileItem(
          name: "background.jpg",
          size: formatFileSize(2097152), // 2 MB
          date: DateTime(2025, 6, 17, 10, 40, 00),
          type: FileType.image,
          path: "attachment/Images/background.jpg",
        ),
        FileItem(
          name: "logo.png",
          size: formatFileSize(51200), // 50 KB
          date: DateTime(2025, 6, 17, 10, 35, 00),
          type: FileType.image,
          path: "attachment/Images/logo.png",
        ),
      ],
      "attachment/Images/Screenshots": [
        FileItem(
          name: "screenshot_1.png",
          size: formatFileSize(153600), // 150 KB
          date: DateTime(2025, 6, 17, 11, 30, 00),
          type: FileType.image,
          path: "attachment/Images/Screenshots/screenshot_1.png",
        ),
        FileItem(
          name: "screenshot_2.png",
          size: formatFileSize(179200), // 175 KB
          date: DateTime(2025, 6, 17, 11, 35, 00),
          type: FileType.image,
          path: "attachment/Images/Screenshots/screenshot_2.png",
        ),
        FileItem(
          name: "screenshot_3.png",
          size: formatFileSize(204800), // 200 KB
          date: DateTime(2025, 6, 17, 11, 40, 00),
          type: FileType.image,
          path: "attachment/Images/Screenshots/screenshot_3.png",
        ),
      ],
    };
  }
} 