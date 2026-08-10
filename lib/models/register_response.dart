class RegisterResponse{
  final bool success; //true/false
  final String message;
  final int? userId;
  final String? uuid;
  final String? email;
  final String? otp;
  final String? otpExpiresAt;

  RegisterResponse(
    {
      required this.success,
      required this.message,
      this.userId,
      this.uuid,
      this.email,
      this.otp,
      this.otpExpiresAt
    }
  );

  factory RegisterResponse.fromJson(Map<String,dynamic> json){
    final data = json['data'];

    return RegisterResponse(
      success: json['success']?? false, 
      message: json['message']??'',
      userId: data != null ? data['user_id'] : null,
      uuid: data != null ? data['uuid'] : null,
      email: data != null ? data['email'] : null,
      otp: data != null ? data['otp'] : null,
      otpExpiresAt: data != null ? data['otp_expires_at'] : null,
      );

  }

}
