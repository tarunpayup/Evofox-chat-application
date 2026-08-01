class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl =
      "https://agencyanalytics.in/api/auth/api/";

  // Authentication APIs
  static const String register = "${baseUrl}register.php";
  static const String verifyEmail = "${baseUrl}verify_email.php";
  static const String resendVerification = "${baseUrl}resend_verification.php";
}