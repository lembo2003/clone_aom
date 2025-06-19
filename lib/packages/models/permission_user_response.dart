// GET http://dev-gateway.intechno.io.vn/storage/permission-resource/user

class PermissionUserResponse {
  PermissionUserResponse({
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
  final List<dynamic> data;

  factory PermissionUserResponse.fromJson(Map<String, dynamic> json) {
    return PermissionUserResponse(
      code: json["code"],
      success: json["success"],
      title: json["title"],
      message: json["message"],
      data:
          json["data"] == null
              ? []
              : List<dynamic>.from(json["data"]!.map((x) => x)),
    );
  }
}
