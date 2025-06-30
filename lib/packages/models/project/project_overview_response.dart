class ProjectOverviewResponse {
  ProjectOverviewResponse({
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

  factory ProjectOverviewResponse.fromJson(Map<String, dynamic> json) {
    return ProjectOverviewResponse(
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
  final dynamic code;
  final String? description;
  final String? state;
  final dynamic startDate;
  final DateTime? endDate;
  final int? progressPercent;
  final String? administrator;
  final AdministratorDto? administratorDto;
  final int? teamSize;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      description: json["description"],
      state: json["state"],
      startDate: json["startDate"],
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      progressPercent: json["progressPercent"],
      administrator: json["administrator"],
      administratorDto:
          json["administratorDto"] == null
              ? null
              : AdministratorDto.fromJson(json["administratorDto"]),
      teamSize: json["teamSize"],
    );
  }
}

class AdministratorDto {
  AdministratorDto({
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

  factory AdministratorDto.fromJson(Map<String, dynamic> json) {
    return AdministratorDto(
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
