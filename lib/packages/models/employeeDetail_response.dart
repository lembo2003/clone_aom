class EmployeeDetailResponse {
  final String code;
  final bool success;
  final String title;
  final String message;
  final EmployeeDetailData data;

  EmployeeDetailResponse({
    required this.code,
    required this.success,
    required this.title,
    required this.message,
    required this.data,
  });

  factory EmployeeDetailResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailResponse(
      code: json['code'] ?? '',
      success: json['success'] ?? false,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      data: EmployeeDetailData.fromJson(json['data'] ?? {}),
    );
  }
}

class EmployeeDetailData {
  final EmployeeDetail employee;
  final List<EmployeeAddress> employeeAddress;
  final List<EmployeeAttachment> employeeAttachment;
  final EmployeeBank? employeeBank;
  final IdentityEmployee? identityEmployee;
  final List<EmployeeCertificate> employeeCertificate;
  final List<EmployeeDependent> employeeDependent;
  final EmployeeHealthy? employeeHealthy;
  final List<EmployeeWorkExp> employeeWorkExp;

  EmployeeDetailData({
    required this.employee,
    required this.employeeAddress,
    required this.employeeAttachment,
    this.employeeBank,
    this.identityEmployee,
    required this.employeeCertificate,
    required this.employeeDependent,
    this.employeeHealthy,
    required this.employeeWorkExp,
  });

  factory EmployeeDetailData.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailData(
      employee: EmployeeDetail.fromJson(json['employee'] ?? {}),
      employeeAddress:
          (json['employeeAddress'] as List<dynamic>?)
              ?.map((e) => EmployeeAddress.fromJson(e))
              .toList() ??
          [],
      employeeAttachment:
          (json['employeeAttachment'] as List<dynamic>?)
              ?.map((e) => EmployeeAttachment.fromJson(e))
              .toList() ??
          [],
      employeeBank:
          json['employeeBank'] != null
              ? EmployeeBank.fromJson(json['employeeBank'])
              : null,
      identityEmployee:
          json['identityEmployee'] != null
              ? IdentityEmployee.fromJson(json['identityEmployee'])
              : null,
      employeeCertificate:
          (json['employeeCertificate'] as List<dynamic>?)
              ?.map((e) => EmployeeCertificate.fromJson(e))
              .toList() ??
          [],
      employeeDependent:
          (json['employeeDependent'] as List<dynamic>?)
              ?.map((e) => EmployeeDependent.fromJson(e))
              .toList() ??
          [],
      employeeHealthy:
          json['employeeHealthy'] != null
              ? EmployeeHealthy.fromJson(json['employeeHealthy'])
              : null,
      employeeWorkExp:
          (json['employeeWorkExp'] as List<dynamic>?)
              ?.map((e) => EmployeeWorkExp.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class EmployeeDetail {
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
  final dynamic department;
  final int? workplaceId;

  EmployeeDetail({
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
    this.department,
    this.workplaceId,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) {
    return EmployeeDetail(
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
      department: json['department'],
      workplaceId: json['workplaceId'],
    );
  }
}

class EmployeeAddress {
  final int id;
  final int employeeId;
  final String? wardCode;
  final String? districtCode;
  final String? provinceCode;
  final String? addressDetail;
  final String? type;

  EmployeeAddress({
    required this.id,
    required this.employeeId,
    this.wardCode,
    this.districtCode,
    this.provinceCode,
    this.addressDetail,
    this.type,
  });

  factory EmployeeAddress.fromJson(Map<String, dynamic> json) {
    return EmployeeAddress(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      wardCode: json['wardCode'],
      districtCode: json['districtCode'],
      provinceCode: json['provinceCode'],
      addressDetail: json['addressDetail'],
      type: json['type'],
    );
  }
}

class EmployeeAttachment {
  final int? id;
  final int? employeeId;
  final String? fileName;
  final String? fileType;
  final String? filePath;

  EmployeeAttachment({
    this.id,
    this.employeeId,
    this.fileName,
    this.fileType,
    this.filePath,
  });

  factory EmployeeAttachment.fromJson(Map<String, dynamic> json) {
    return EmployeeAttachment(
      id: json['id'],
      employeeId: json['employeeId'],
      fileName: json['fileName'],
      fileType: json['fileType'],
      filePath: json['filePath'],
    );
  }
}

class EmployeeBank {
  final int id;
  final int employeeId;
  final String cardNumber;
  final String bank;
  final String accountName;
  final String? state;

  EmployeeBank({
    required this.id,
    required this.employeeId,
    required this.cardNumber,
    required this.bank,
    required this.accountName,
    this.state,
  });

  factory EmployeeBank.fromJson(Map<String, dynamic> json) {
    return EmployeeBank(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      cardNumber: json['cardNumber'] ?? '',
      bank: json['bank'] ?? '',
      accountName: json['accountName'] ?? '',
      state: json['state'],
    );
  }
}

class IdentityEmployee {
  final int id;
  final int employeeId;
  final String no;
  final String? type;
  final String issueDate;
  final String issuePlace;

  IdentityEmployee({
    required this.id,
    required this.employeeId,
    required this.no,
    this.type,
    required this.issueDate,
    required this.issuePlace,
  });

  factory IdentityEmployee.fromJson(Map<String, dynamic> json) {
    return IdentityEmployee(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      no: json['no'] ?? '',
      type: json['type'],
      issueDate: json['issueDate'] ?? '',
      issuePlace: json['issuePlace'] ?? '',
    );
  }
}

class EmployeeCertificate {
  final int id;
  final int employeeId;
  final String? type;
  final String name;
  final String classification;
  final String? issueDate;
  final String? year;
  final String? state;

  EmployeeCertificate({
    required this.id,
    required this.employeeId,
    this.type,
    required this.name,
    required this.classification,
    this.issueDate,
    this.year,
    this.state,
  });

  factory EmployeeCertificate.fromJson(Map<String, dynamic> json) {
    return EmployeeCertificate(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      type: json['type'],
      name: json['name'] ?? '',
      classification: json['classification'] ?? '',
      issueDate: json['issueDate'],
      year: json['year'],
      state: json['state'],
    );
  }
}

class EmployeeDependent {
  final int id;
  final int employeeId;
  final String fullName;
  final String phone;
  final String relationship;
  final String identityNo;
  final String? issueDate;
  final String issuePlace;
  final bool isDependent;
  final String? dateDependent;
  final String personalTaxCode;

  EmployeeDependent({
    required this.id,
    required this.employeeId,
    required this.fullName,
    required this.phone,
    required this.relationship,
    required this.identityNo,
    this.issueDate,
    required this.issuePlace,
    required this.isDependent,
    this.dateDependent,
    required this.personalTaxCode,
  });

  factory EmployeeDependent.fromJson(Map<String, dynamic> json) {
    return EmployeeDependent(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      relationship: json['relationship'] ?? '',
      identityNo: json['identityNo'] ?? '',
      issueDate: json['issueDate'],
      issuePlace: json['issuePlace'] ?? '',
      isDependent: json['isDependent'] ?? false,
      dateDependent: json['dateDependent'],
      personalTaxCode: json['personalTaxCode'] ?? '',
    );
  }
}

class EmployeeHealthy {
  final int id;
  final int employeeId;
  final String height;
  final String weight;
  final String blood;

  EmployeeHealthy({
    required this.id,
    required this.employeeId,
    required this.height,
    required this.weight,
    required this.blood,
  });

  factory EmployeeHealthy.fromJson(Map<String, dynamic> json) {
    return EmployeeHealthy(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      height: json['height'] ?? '',
      weight: json['weight'] ?? '',
      blood: json['blood'] ?? '',
    );
  }
}

class EmployeeWorkExp {
  final int id;
  final int employeeId;
  final String company;
  final String role;
  final String fromDate;
  final String toDate;
  final String reasonOff;

  EmployeeWorkExp({
    required this.id,
    required this.employeeId,
    required this.company,
    required this.role,
    required this.fromDate,
    required this.toDate,
    required this.reasonOff,
  });

  factory EmployeeWorkExp.fromJson(Map<String, dynamic> json) {
    return EmployeeWorkExp(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      reasonOff: json['reasonOff'] ?? '',
    );
  }
}
