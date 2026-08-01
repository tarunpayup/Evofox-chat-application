class VerifyEmailResponse {
  final bool status;
  final String message;
  final dynamic data;

  VerifyEmailResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory VerifyEmailResponse.fromJson(
      Map<String, dynamic> json) {
    return VerifyEmailResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data,
    };
  }
}