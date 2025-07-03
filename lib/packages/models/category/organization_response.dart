class OrganizationResponse {
  OrganizationResponse({
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

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) {
    return OrganizationResponse(
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
    required this.parentId,
    required this.path,
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.description,
    required this.function,
    required this.task,
    required this.state,
    required this.managerId,
    required this.children,
    required this.employeeDto,
  });

  final int? parentId;
  final String? path;
  final int? id;
  final String? name;
  final String? code;
  final String? type;
  final String? description;
  final String? function;
  final String? task;
  final String? state;
  final int? managerId;
  final List<Content> children;
  final EmployeeDto? employeeDto;

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parentId: json["parentId"],
      path: json["path"],
      id: json["id"],
      name: json["name"],
      code: json["code"],
      type: json["type"],
      description: json["description"],
      function: json["function"],
      task: json["task"],
      state: json["state"],
      managerId: json["managerId"],
      children:
          json["children"] == null
              ? []
              : List<Content>.from(
                json["children"]!.map((x) => Content.fromJson(x)),
              ),
      employeeDto:
          json["employeeDto"] == null
              ? null
              : EmployeeDto.fromJson(json["employeeDto"]),
    );
  }
}

class EmployeeDto {
  EmployeeDto({
    required this.id,
    required this.code,
    required this.fullName,
    required this.email,
    required this.workEmail,
    required this.mobile,
    required this.birthDate,
    required this.gender,
    required this.placeOfBirth,
    required this.nationality,
    required this.ethnicGroup,
    required this.maritalStatus,
    required this.religion,
    required this.highSchoolLevel,
    required this.specialization,
    required this.personalTaxCode,
    required this.state,
    required this.workplace,
    required this.orgId,
    required this.jobId,
    required this.positionId,
    required this.rankId,
    required this.department,
    required this.workplaceId,
  });

  final int? id;
  final String? code;
  final String? fullName;
  final String? email;
  final dynamic workEmail;
  final String? mobile;
  final DateTime? birthDate;
  final String? gender;
  final String? placeOfBirth;
  final dynamic nationality;
  final String? ethnicGroup;
  final dynamic maritalStatus;
  final dynamic religion;
  final dynamic highSchoolLevel;
  final dynamic specialization;
  final dynamic personalTaxCode;
  final dynamic state;
  final dynamic workplace;
  final int? orgId;
  final dynamic jobId;
  final dynamic positionId;
  final dynamic rankId;
  final dynamic department;
  final dynamic workplaceId;

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      id: json["id"],
      code: json["code"],
      fullName: json["fullName"],
      email: json["email"],
      workEmail: json["workEmail"],
      mobile: json["mobile"],
      birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
      gender: json["gender"],
      placeOfBirth: json["placeOfBirth"],
      nationality: json["nationality"],
      ethnicGroup: json["ethnicGroup"],
      maritalStatus: json["maritalStatus"],
      religion: json["religion"],
      highSchoolLevel: json["highSchoolLevel"],
      specialization: json["specialization"],
      personalTaxCode: json["personalTaxCode"],
      state: json["state"],
      workplace: json["workplace"],
      orgId: json["orgId"],
      jobId: json["jobId"],
      positionId: json["positionId"],
      rankId: json["rankId"],
      department: json["department"],
      workplaceId: json["workplaceId"],
    );
  }
}
