import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/verify_email_viewmodel.dart';
import 'login_screen.dart';

class VerifyEmailScreen extends StatelessWidget {

  final String email;

  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => VerifyEmailViewModel(email),

      child: const VerifyEmailView(),

    );

  }
}

class VerifyEmailView extends StatefulWidget {

  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() =>
      _VerifyEmailViewState();
}

class _VerifyEmailViewState
    extends State<VerifyEmailView> {

  Timer? timer;

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      Provider.of<VerifyEmailViewModel>(
        context,
        listen: false,
      ).startTimer();

    });

  }

  @override
  void dispose() {

    timer?.cancel();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final vm =
        Provider.of<VerifyEmailViewModel>(context);

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(

        child: Form(

          key: vm.formKey,

          child: Padding(

            padding: const EdgeInsets.only(

              left: 30,
              right: 30,
              top: 20,
              bottom: 20,

            ),

            child: SingleChildScrollView(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  InkWell(

                    onTap: () {

                      Navigator.pop(context);

                    },

                    child: const Icon(

                      Icons.arrow_back,

                      color: Colors.white,

                    ),

                  ),

                  const SizedBox(height: 25),

                  const Text(

                    "Verify Email",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 10),

                  Text(

                    "Verification code has been sent to",

                    style: TextStyle(

                      color: Colors.grey.shade400,

                    ),

                  ),

                  const SizedBox(height: 5),

                  Text(

                    vm.email,

                    style: const TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 40),
                  //--------------------------------------------------
                  // OTP
                  //--------------------------------------------------

                  const Padding(

                    padding: EdgeInsets.only(left: 20),

                    child: Text(

                      "Enter OTP",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.otpController,

                    validator: vm.validateOTP,

                    keyboardType: TextInputType.number,

                    maxLength: 6,

                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 8,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),

                    decoration: InputDecoration(

                      counterText: "",

                      hintText: "------",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        letterSpacing: 8,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                    ),

                  ),

                  const SizedBox(height: 30),

                  //--------------------------------------------------
                  // Timer
                  //--------------------------------------------------

                  Center(

                    child: Text(

                      vm.secondsRemaining > 0
                          ? "Resend OTP in ${vm.secondsRemaining} sec"
                          : "Didn't receive the OTP?",

                      style: TextStyle(

                        color: Colors.grey.shade400,

                        fontSize: 14,

                      ),

                    ),

                  ),

                  const SizedBox(height: 10),

                  //--------------------------------------------------
                  // Resend OTP
                  //--------------------------------------------------

                  Center(

                    child: TextButton(

                      onPressed: vm.secondsRemaining == 0
                          ? () async {

                              bool status =
                                  await vm.resendOTP();

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(

                                SnackBar(

                                  backgroundColor:
                                      status
                                          ? Colors.green
                                          : Colors.red,

                                  content: Text(

                                    vm.message,

                                  ),

                                ),

                              );

                            }
                          : null,

                      child: Text(

                        "Resend OTP",

                        style: TextStyle(

                          color: vm.secondsRemaining == 0
                              ? Colors.blue
                              : Colors.grey,

                          fontWeight: FontWeight.bold,

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(height: 35),
                  //--------------------------------------------------
                  // Verify Button
                  //--------------------------------------------------

                  SizedBox(

                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(

                        backgroundColor: const Color(0xff01A393),

                        shape: RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(30),

                        ),

                      ),

                      onPressed: vm.isLoading
                          ? null
                          : () async {

                              FocusScope.of(context).unfocus();

                              if (!vm.formKey.currentState!
                                  .validate()) {
                                return;
                              }

                              bool status =
                                  await vm.verifyEmail();

                              if (!context.mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(

                                SnackBar(

                                  backgroundColor: status
                                      ? Colors.green
                                      : Colors.red,

                                  content: Text(
                                    vm.message,
                                  ),

                                ),

                              );

                              if (status) {

                                Navigator.pushAndRemoveUntil(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        const LoginScreen(),

                                  ),

                                  (route) => false,

                                );

                              }

                            },

                      child: vm.isLoading

                          ? const SizedBox(

                              width: 25,

                              height: 25,

                              child:
                                  CircularProgressIndicator(

                                color: Colors.white,

                                strokeWidth: 3,

                              ),

                            )

                          : const Text(

                              "Verify Email",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 17,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                    ),

                  ),

                  const SizedBox(height: 25),
                  //--------------------------------------------------
                  // Back to Login
                  //--------------------------------------------------

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Text(

                        "Already Verified? ",

                        style: TextStyle(
                          color: Colors.white70,
                        ),

                      ),

                      InkWell(

                        onTap: () {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>
                                  const LoginScreen(),

                            ),

                          );

                        },

                        child: const Text(

                          "Login",

                          style: TextStyle(

                            color: Colors.blue,

                            fontWeight: FontWeight.bold,

                          ),

                        ),

                      ),

                    ],

                  ),

                  const SizedBox(height: 20),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}                                                      