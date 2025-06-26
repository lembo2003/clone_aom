class EmployeeResponse {
  final String code;
  final bool success;
  final String title;
  final String message;
  final EmployeeData data;

  EmployeeResponse({
    required this.code,
    required this.success,
    required this.title,
    required this.message,
    required this.data,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      code: json['code'] ?? '',
      success: json['success'] ?? false,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      data: EmployeeData.fromJson(json['data'] ?? {}),
    );
  }
}

class EmployeeData {
  final int pageSize;
  final int page;
  final int total;
  final List<Employee> content;

  EmployeeData({
    required this.pageSize,
    required this.page,
    required this.total,
    required this.content,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      pageSize: json['pageSize'] ?? 0,
      page: json['page'] ?? 0,
      total: json['total'] ?? 0,
      content:
          (json['content'] as List<dynamic>?)
              ?.map((item) => Employee.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Employee {
  final int id;
  final String code;
  final String fullName;
  final String email;
  final String? workEmail;
  final String mobile;
  final String birthDate;
  final String gender;
  final String? placeOfBirth;
  final String? nationality;
  final String? ethnicGroup;
  final String? maritalStatus;
  final String? religion;
  final String? highSchoolLevel;
  final String? specialization;
  final String? personalTaxCode;
  final String? state;
  final String? workplace;
  final int orgId;
  final int? jobId;
  final int? positionId;
  final int? rankId;
  final Department department;
  final int? workplaceId;
  Employee({
    required this.id,
    required this.code,
    required this.fullName,
    required this.email,
    this.workEmail,
    required this.mobile,
    required this.birthDate,
    required this.gender,
    this.placeOfBirth,
    this.nationality,
    this.ethnicGroup,
    this.maritalStatus,
    this.religion,
    this.highSchoolLevel,
    this.specialization,
    this.personalTaxCode,
    this.state,
    this.workplace,
    required this.orgId,
    this.jobId,
    this.positionId,
    this.rankId,
    required this.department,
    this.workplaceId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      workEmail: json['workEmail'],
      mobile: json['mobile'] ?? '',
      birthDate: json['birthDate'] ?? '',
      gender: json['gender'] ?? '',
      placeOfBirth: json['placeOfBirth'],
      nationality: json['nationality'],
      ethnicGroup: json['ethnicGroup'],
      maritalStatus: json['maritalStatus'],
      religion: json['religion'],
      highSchoolLevel: json['highSchoolLevel'],
      specialization: json['specialization'],
      personalTaxCode: json['personalTaxCode'],
      state: json['state'],
      workplace: json['workplace'],
      orgId: json['orgId'] ?? 0,
      jobId: json['jobId'],
      positionId: json['positionId'],
      rankId: json['rankId'],
      department: Department.fromJson(json['department'] ?? {}),
      workplaceId: json['workplaceId'],
    );
  }
}

class Department {
  final Organization organization;
  final dynamic job;
  final dynamic position;
  final dynamic rank;

  Department({required this.organization, this.job, this.position, this.rank});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      organization: Organization.fromJson(json['organization'] ?? {}),
      job: json['job'],
      position: json['position'],
      rank: json['rank'],
    );
  }
}

class Organization {
  final int? parentId;
  final String? path;
  final int id;
  final String name;
  final String code;
  final String type;
  final String description;
  final String function;
  final String task;
  final String state;
  final int managerId;

  Organization({
    this.parentId,
    this.path,
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.description,
    required this.function,
    required this.task,
    required this.state,
    required this.managerId,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      parentId: json['parentId'],
      path: json['path'],
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      function: json['function'] ?? '',
      task: json['task'] ?? '',
      state: json['state'] ?? '',
      managerId: json['managerId'] ?? 0,
    );
  }
}
