class Validators {
  Validators._();

  // Full Name Validation
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full Name is required";
    }

    if (value.trim().length < 3) {
      return "Full Name must be at least 3 characters";
    }

    return null;
  }

  // Username Validation
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.trim().length < 4) {
      return "Username must be at least 4 characters";
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value.trim())) {
      return "Only letters, numbers and underscore (_) are allowed";
    }

    return null;
  }

  // Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(value.trim())) {
      return "Enter a valid email address";
    }

    return null;
  }

  // Phone Validation
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone Number is required";
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
      return "Enter a valid 10-digit phone number";
    }

    return null;
  }

  // Password Validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number";
    }

    if (!RegExp(r'[!@#\$&*~%^()_+=\-{}[\]:;<>,.?/]').hasMatch(value)) {
      return "Password must contain at least one special character";
    }

    return null;
  }
}