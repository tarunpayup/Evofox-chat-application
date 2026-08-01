import '../core/api/api_client.dart';
import '../core/api/api_constants.dart';
import '../models/verify_email/verify_email_request.dart';

class VerifyEmailService {
  final ApiClient _apiClient = ApiClient();

  /// Verify Email API
  Future<Map<String, dynamic>> verifyEmail(
      VerifyEmailRequest request) async {
    final response = await _apiClient.post(
      url: ApiConstants.verifyEmail,
      body: request.toJson(),
    );

    return response;
  }

  /// Resend Verification OTP API
  Future<Map<String, dynamic>> resendVerification(
      String email) async {
    final response = await _apiClient.post(
      url: ApiConstants.resendVerification,
      body: {
        "email": email,
      },
    );

    return response;
  }
}