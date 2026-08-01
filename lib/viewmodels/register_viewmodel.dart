import 'package:flutter/material.dart';

import '../models/register/register_request.dart';
import '../models/register/register_response.dart';
import '../repositories/register_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository _repository = RegisterRepository();

  // Controllers
  final TextEditingController fullNameController =
      TextEditingController();

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  // Form Key
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  // Loading
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Password Visibility
  bool _obscurePassword = true;

  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Register API
  Future<RegisterResponse> register() async {
    _isLoading = true;
    notifyListeners();

    try {
      RegisterRequest request = RegisterRequest(
        fullName: fullNameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
      );

      RegisterResponse response =
          await _repository.register(request);

      _isLoading = false;
      notifyListeners();

      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      return RegisterResponse(
        status: false,
        message: e.toString(),
        data: null,
      );
    }
  }

  // Clear Form
  void clearForm() {
    fullNameController.clear();
    usernameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();

    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}