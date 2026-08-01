import '../models/verify_email/verify_email_request.dart';
import '../models/verify_email/verify_email_response.dart';
import '../services/verify_email_services.dart';

class VerifyEmailRepository {
  final VerifyEmailService _service = VerifyEmailService();

  Future<VerifyEmailResponse> verifyEmail(
      VerifyEmailRequest request) async {
    try {
      final response = await _service.verifyEmail(request);

      return VerifyEmailResponse.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<VerifyEmailResponse> resendVerification(
      String email) async {
    try {
      final response =
          await _service.resendVerification(email);

      return VerifyEmailResponse.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}