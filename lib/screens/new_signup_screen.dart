import 'package:evofox_chat_app/core/utils/validators.dart';
import 'package:evofox_chat_app/screens/login_screen.dart';
import 'package:evofox_chat_app/viewmodels/register_viewmodel.dart';
import 'package:evofox_chat_app/screens/verify_email_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(

        child: Form(

          key: vm.formKey,

          child: Padding(

            padding: const EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
              bottom: 20,
            ),

            child: SingleChildScrollView(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  InkWell(

                    onTap: (){
                      Navigator.pop(context);
                    },

                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),

                  ),

                  const SizedBox(height: 20),

                  const Text(

                    "Sign Up",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                  const SizedBox(height: 30),

                  //--------------------------------------------------
                  // Username
                  //--------------------------------------------------

                  const Padding(

                    padding: EdgeInsets.only(left: 20),

                    child: Text(

                      "Username",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.usernameController,

                    validator: Validators.validateUsername,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(

                      hintText: "Enter Username",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red),
                      ),

                    ),

                  ),

                  const SizedBox(height: 25),

                  //--------------------------------------------------
                  // Full Name
                  //--------------------------------------------------

                  const Padding(

                    padding: EdgeInsets.only(left: 20),

                    child: Text(

                      "Full Name",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.fullNameController,

                    validator: Validators.validateFullName,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(

                      hintText: "Enter Full Name",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red),
                      ),

                    ),

                  ),

                  const SizedBox(height: 25),
                  //--------------------------------------------------
                  // Email
                  //--------------------------------------------------

                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.emailController,

                    validator: Validators.validateEmail,

                    keyboardType: TextInputType.emailAddress,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(

                      hintText: "Enter Email",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red),
                      ),

                    ),

                  ),

                  const SizedBox(height: 25),

                  //--------------------------------------------------
                  // Phone Number
                  //--------------------------------------------------

                  const Padding(

                    padding: EdgeInsets.only(left: 20),

                    child: Text(

                      "Phone Number",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.phoneController,

                    validator: Validators.validatePhone,

                    keyboardType: TextInputType.phone,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(

                      hintText: "Enter Phone Number",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red),
                      ),

                    ),

                  ),

                  const SizedBox(height: 25),

                  //--------------------------------------------------
                  // Password
                  //--------------------------------------------------

                  const Padding(

                    padding: EdgeInsets.only(left: 20),

                    child: Text(

                      "Password",

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),

                    ),

                  ),

                  const SizedBox(height: 8),

                  TextFormField(

                    controller: vm.passwordController,

                    validator: Validators.validatePassword,

                    obscureText: vm.obscurePassword,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(

                      hintText: "Enter Password",

                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),

                      filled: true,

                      fillColor: const Color(0xff2B2B2B),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),

                      suffixIcon: IconButton(

                        onPressed: () {
                          vm.togglePasswordVisibility();
                        },

                        icon: Icon(

                          vm.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,

                          color: Colors.grey,

                        ),

                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.red),
                      ),

                    ),

                  ),

                  const SizedBox(height: 20),
                  //--------------------------------------------------
                  // Already have account
                  //--------------------------------------------------

                  Align(

                    alignment: Alignment.centerRight,

                    child: InkWell(

                      onTap: () {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(

                            builder: (_) => const LoginScreen(),

                          ),

                        );

                      },

                      child: const Text(

                        "Already have an account? Login",

                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),

                      ),

                    ),

                  ),

                  const SizedBox(height: 35),

                  //--------------------------------------------------
                  // Register Button
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

                              final response =
                                  await vm.register();

                              if (!context.mounted) return;

                              if (response.status) {

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(

                                  SnackBar(

                                    content: Text(
                                      response.message,
                                    ),

                                    backgroundColor:
                                        Colors.green,

                                  ),

                                );

                                Navigator.pushReplacement(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        VerifyEmailScreen(

                                      email: response
                                              .data?.email ??
                                          "",

                                    ),

                                  ),

                                );

                              } else {

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(

                                  SnackBar(

                                    content: Text(
                                      response.message,
                                    ),

                                    backgroundColor:
                                        Colors.red,

                                  ),

                                );

                              }

                            },

                      child: vm.isLoading

                          ? const SizedBox(

                              height: 25,

                              width: 25,

                              child:
                                  CircularProgressIndicator(

                                strokeWidth: 3,

                                color: Colors.white,

                              ),

                            )

                          : const Text(

                              "Sign Up",

                              style: TextStyle(

                                color: Colors.white,

                                fontSize: 17,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                    ),

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