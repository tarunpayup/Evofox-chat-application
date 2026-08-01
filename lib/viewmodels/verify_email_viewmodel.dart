import 'dart:async';

import 'package:flutter/material.dart';

import '../models/verify_email/verify_email_request.dart';
import '../repositories/verify_email_repository.dart';

class VerifyEmailViewModel extends ChangeNotifier {
  final VerifyEmailRepository _repository =
      VerifyEmailRepository();

  VerifyEmailViewModel(this.email);

  final String email;

  // Form Key
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  // Controller
  final TextEditingController otpController =
      TextEditingController();

  // Loading
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Message
  String _message = "";

  String get message => _message;

  // Timer
  Timer? _timer;

  int _secondsRemaining = 60;

  int get secondsRemaining => _secondsRemaining;

  // -----------------------------
  // Start Timer
  // -----------------------------

  void startTimer() {

    _timer?.cancel();

    _secondsRemaining = 60;

    notifyListeners();

    _timer = Timer.periodic(

      const Duration(seconds: 1),

      (timer) {

        if (_secondsRemaining > 0) {

          _secondsRemaining--;

          notifyListeners();

        } else {

          timer.cancel();

        }

      },

    );

  }

  // -----------------------------
  // OTP Validation
  // -----------------------------

  String? validateOTP(String? value) {

    if (value == null || value.trim().isEmpty) {

      return "OTP is required";

    }

    if (value.trim().length != 6) {

      return "OTP must be 6 digits";

    }

    return null;

  }

  // -----------------------------
  // Verify Email
  // -----------------------------

  Future<bool> verifyEmail() async {

    _isLoading = true;

    notifyListeners();

    try {

      VerifyEmailRequest request =
          VerifyEmailRequest(

        email: email,

        otp: otpController.text.trim(),

      );

      final response =
          await _repository.verifyEmail(request);

      _message = response.message;

      _isLoading = false;

      notifyListeners();

      return response.status;

    } catch (e) {

      _message = e.toString();

      _isLoading = false;

      notifyListeners();

      return false;

    }

  }

  // -----------------------------
  // Resend OTP
  // -----------------------------

  Future<bool> resendOTP() async {

    _isLoading = true;

    notifyListeners();

    try {

      final response =
          await _repository.resendVerification(email);

      _message = response.message;

      _isLoading = false;

      if (response.status) {

        startTimer();

      }

      notifyListeners();

      return response.status;

    } catch (e) {

      _message = e.toString();

      _isLoading = false;

      notifyListeners();

      return false;

    }

  }

  @override
  void dispose() {

    otpController.dispose();

    _timer?.cancel();

    super.dispose();

  }

}