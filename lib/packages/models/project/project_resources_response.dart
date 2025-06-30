class ProjectResourcesResponse {
  ProjectResourcesResponse({
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
  final List<Datum> data;

  factory ProjectResourcesResponse.fromJson(Map<String, dynamic> json) {
    print('Raw JSON data field: ${json["data"]}'); // Debug print
    List<dynamic> dataList = json["data"] ?? [];
    print('Parsed data list length: ${dataList.length}'); // Debug print
    
    return ProjectResourcesResponse(
      code: json["code"],
      success: json["success"],
      title: json["title"],
      message: json["message"],
      data: dataList.map((x) => Datum.fromJson(x)).toList(),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.code,
    required this.humanResource,
    required this.humanResourceDto,
    required this.position,
    required this.projectId,
  });

  final int? id;
  final dynamic name;
  final dynamic code;
  final String? humanResource;
  final HumanResourceDto? humanResourceDto;
  final String? position;
  final int? projectId;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      humanResource: json["humanResource"],
      humanResourceDto:
          json["humanResourceDto"] == null
              ? null
              : HumanResourceDto.fromJson(json["humanResourceDto"]),
      position: json["position"],
      projectId: json["projectId"],
    );
  }
}

class HumanResourceDto {
  HumanResourceDto({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.createDate,
    required this.phone,
    required this.state,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String? id;
  final String? username;
  final String? fullName;
  final String? email;
  final DateTime? createDate;
  final String? phone;
  final String? state;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;

  factory HumanResourceDto.fromJson(Map<String, dynamic> json) {
    return HumanResourceDto(
      id: json["id"],
      username: json["username"],
      fullName: json["fullName"],
      email: json["email"],
      createDate: DateTime.tryParse(json["createDate"] ?? ""),
      phone: json["phone"],
      state: json["state"],
      avatar: json["avatar"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
    );
  }
}
