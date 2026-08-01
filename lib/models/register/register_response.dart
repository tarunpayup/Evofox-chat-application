class RegisterResponse {
  final bool status;
  final String message;
  final RegisterData? data;

  RegisterResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null
          ? RegisterData.fromJson(json["data"])
          : null,
    );
  }
}

class RegisterData {
  final int userId;
  final String uuid;
  final String email;
  final String otpExpiresAt;

  RegisterData({
    required this.userId,
    required this.uuid,
    required this.email,
    required this.otpExpiresAt,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userId: json["user_id"] ?? 0,
      uuid: json["uuid"] ?? "",
      email: json["email"] ?? "",
      otpExpiresAt: json["otp_expires_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "uuid": uuid,
      "email": email,
      "otp_expires_at": otpExpiresAt,
    };
  }
}