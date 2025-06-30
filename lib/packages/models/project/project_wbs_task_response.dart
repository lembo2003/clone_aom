class ProjectWbsTaskResponse {
  ProjectWbsTaskResponse({
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

  factory ProjectWbsTaskResponse.fromJson(Map<String, dynamic> json) {
    return ProjectWbsTaskResponse(
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
    required this.orders,
    required this.description,
    required this.priority,
    required this.state,
    required this.projectId,
    required this.parentId,
    required this.startDate,
    required this.dueDate,
    required this.estimatedTime,
    required this.overTimeHours,
    required this.progressPercent,
    required this.assigneeIds,
    required this.assignees,
    required this.count,
    required this.endDate,
  });

  final int? id;
  final String? name;
  final String? code;
  final int? orders;
  final String? description;
  final String? priority;
  final String? state;
  final int? projectId;
  final int? parentId;
  final DateTime? startDate;
  final DateTime? dueDate;
  final int? estimatedTime;
  final int? overTimeHours;
  final int? progressPercent;
  final List<String> assigneeIds;
  final List<Assignee> assignees;
  final int? count;
  final DateTime? endDate;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      orders: json["orders"],
      description: json["description"],
      priority: json["priority"],
      state: json["state"],
      projectId: json["projectId"],
      parentId: json["parentId"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      dueDate: DateTime.tryParse(json["dueDate"] ?? ""),
      estimatedTime: json["estimatedTime"],
      overTimeHours: json["overTimeHours"],
      progressPercent: json["progressPercent"],
      assigneeIds:
          json["assigneeIds"] == null
              ? []
              : List<String>.from(json["assigneeIds"]!.map((x) => x)),
      assignees:
          json["assignees"] == null
              ? []
              : List<Assignee>.from(
                json["assignees"]!.map((x) => Assignee.fromJson(x)),
              ),
      count: json["count"],
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
    );
  }
}

class Assignee {
  Assignee({
    required this.id,
    required this.avatar,
    required this.username,
    required this.fullName,
    required this.email,
    required this.createDate,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.state,
  });

  final String? id;
  final String? avatar;
  final String? username;
  final String? fullName;
  final String? email;
  final DateTime? createDate;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final String? state;

  factory Assignee.fromJson(Map<String, dynamic> json) {
    return Assignee(
      id: json["id"],
      avatar: json["avatar"],
      username: json["username"],
      fullName: json["fullName"],
      email: json["email"],
      createDate: DateTime.tryParse(json["createDate"] ?? ""),
      phone: json["phone"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
      state: json["state"],
    );
  }
}

//Currently skipped
