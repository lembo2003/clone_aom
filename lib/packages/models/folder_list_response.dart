// POST http://dev-gateway.intechno.io.vn/storage/folders/filter

class FolderListResponse {
  FolderListResponse({
    required this.code,
    required this.success,
    required this.title,
    required this.message,
    required this.data,
  });

  final String? code;
  final bool? success;
  final String? title;
  final String? message;
  final FolderListData? data;

  factory FolderListResponse.fromJson(Map<String, dynamic> json) {
    return FolderListResponse(
      code: json["code"],
      success: json["success"],
      title: json["title"],
      message: json["message"],
      data: json["data"] == null ? null : FolderListData.fromJson(json["data"]),
    );
  }
}

class FolderListData {
  FolderListData({
    required this.pageSize,
    required this.page,
    required this.total,
    required this.content,
  });

  final int? pageSize;
  final int? page;
  final int? total;
  final List<FolderListContent> content;

  factory FolderListData.fromJson(Map<String, dynamic> json) {
    return FolderListData(
      pageSize: json["pageSize"],
      page: json["page"],
      total: json["total"],
      content:
          json["content"] == null
              ? []
              : List<FolderListContent>.from(
                json["content"]!.map((x) => FolderListContent.fromJson(x)),
              ),
    );
  }
}

class FolderListContent {
  FolderListContent({
    required this.parentId,
    required this.path,
    required this.id,
    required this.name,
    required this.pathFolder,
    required this.userId,
    required this.size,
    required this.type,
    required this.bucket,
  });

  final int? parentId;
  final String? path;
  final int? id;
  final String? name;
  final String? pathFolder;
  final String? userId;
  final int? size;
  final String? type;
  final String? bucket;

  factory FolderListContent.fromJson(Map<String, dynamic> json) {
    return FolderListContent(
      parentId: json["parentId"],
      path: json["path"],
      id: json["id"],
      name: json["name"],
      pathFolder: json["pathFolder"],
      userId: json["userId"],
      size: json["size"],
      type: json["type"],
      bucket: json["bucket"],
    );
  }
}
