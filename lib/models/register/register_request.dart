class RegisterRequest {
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String password;

  const RegisterRequest({
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    };
  }
}