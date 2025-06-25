class ProjectListResponse {
  ProjectListResponse({
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
  final Data? data;

  factory ProjectListResponse.fromJson(Map<String, dynamic> json) {
    return ProjectListResponse(
      code: json["code"],
      success: json["success"],
      title: json["title"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.pageSize,
    required this.page,
    required this.total,
    required this.content,
  });

  final int? pageSize;
  final int? page;
  final int? total;
  final List<Content> content;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pageSize: json["pageSize"],
      page: json["page"],
      total: json["total"],
      content:
          json["content"] == null
              ? []
              : List<Content>.from(
                json["content"]!.map((x) => Content.fromJson(x)),
              ),
    );
  }
}

class Content {
  Content({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.state,
    required this.startDate,
    required this.endDate,
    required this.progressPercent,
    required this.administrator,
    required this.administratorDto,
    required this.teamSize,
  });

  final int? id;
  final String? name;
  final String? code;
  final String? description;
  final String? state;
  final dynamic startDate;
  final DateTime? endDate;
  final int? progressPercent;
  final String? administrator;
  final dynamic administratorDto;
  final int? teamSize;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      description: json["description"],
      state: json["state"],
      startDate: json["startDate"],
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      progressPercent: json["progressPercent"],
      administrator: json["administrator"],
      administratorDto: json["administratorDto"],
      teamSize: json["teamSize"],
    );
  }
}
