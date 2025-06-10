class LoginResponse {
  final String code;
  final bool success;
  final String title;
  final String message;
  final LoginData data;

  LoginResponse({
    required this.code,
    required this.success,
    required this.title,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'] ?? '',
      success: json['success'] ?? false,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginData {
  final String accessToken;
  final int expiresIn;
  final String? userId;

  LoginData({
    required this.accessToken,
    required this.expiresIn,
    this.userId,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['accessToken'] ?? '',
      expiresIn: json['expiresIn'] ?? 0,
      userId: json['userId'],
    );
  }
} 