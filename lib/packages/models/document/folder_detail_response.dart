// GET http://dev-gateway.intechno.io.vn/storage/file/7607042284593153/files?pageIndex=0&pageSize=20

class FolderDetailResponse {
  FolderDetailResponse({
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
  final FolderDetailData? data;

  factory FolderDetailResponse.fromJson(Map<String, dynamic> json) {
    return FolderDetailResponse(
      code: json["code"],
      success: json["success"],
      title: json["title"],
      message: json["message"],
      data:
          json["data"] == null ? null : FolderDetailData.fromJson(json["data"]),
    );
  }
}

class FolderDetailData {
  FolderDetailData({
    required this.pageSize,
    required this.page,
    required this.total,
    required this.content,
  });

  final int? pageSize;
  final int? page;
  final int? total;
  final List<FolderDetailContent> content;

  factory FolderDetailData.fromJson(Map<String, dynamic> json) {
    return FolderDetailData(
      pageSize: json["pageSize"],
      page: json["page"],
      total: json["total"],
      content:
          json["content"] == null
              ? []
              : List<FolderDetailContent>.from(
                json["content"]!.map((x) => FolderDetailContent.fromJson(x)),
              ),
    );
  }
}

class FolderDetailContent {
  FolderDetailContent({
    required this.id,
    required this.type,
    required this.name,
    required this.path,
    required this.extension,
    required this.size,
    required this.content,
    required this.createDate,
    required this.userId,
    required this.tagId,
    required this.shareExpiredAt,
    required this.secondExpiredAt,
    required this.urlShare,
    required this.viewPermission,
  });

  final int? id;
  final String? type;
  final String? name;
  final String? path;
  final dynamic extension;
  final String? size;
  final dynamic content;
  final DateTime? createDate;
  final String? userId;
  final dynamic tagId;
  final dynamic shareExpiredAt;
  final dynamic secondExpiredAt;
  final dynamic urlShare;
  final String? viewPermission;

  factory FolderDetailContent.fromJson(Map<String, dynamic> json) {
    return FolderDetailContent(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      path: json["path"],
      extension: json["extension"],
      size: json["size"],
      content: json["content"],
      createDate: DateTime.tryParse(json["createDate"] ?? ""),
      userId: json["userId"],
      tagId: json["tagId"],
      shareExpiredAt: json["shareExpiredAt"],
      secondExpiredAt: json["secondExpiredAt"],
      urlShare: json["urlShare"],
      viewPermission: json["viewPermission"],
    );
  }
}
