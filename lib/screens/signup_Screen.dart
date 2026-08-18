import 'package:evofox_chat_app/providers/signup_provider.dart';
import 'package:evofox_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {

  // --------------------------------------------------
  // TEXT CONTROLLERS
  // --------------------------------------------------

  final usernameController =
      TextEditingController();

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final passwordController =
      TextEditingController();


  // --------------------------------------------------
  // DISPOSE CONTROLLERS
  // --------------------------------------------------

  @override
  void dispose() {

    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();

    super.dispose();
  }


  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //River pod system starts from here
    // Listen to Riverpod state

    final signupState =
        ref.watch(signupProvider);


    // --------------------------------------------------
    // LISTEN FOR SUCCESS / ERROR
    // --------------------------------------------------

    ref.listen<SignupState>(
      signupProvider,
      (previous, next) { // What are the changes happens into the state.
      //Current state is saved or recieved in 'next'.

        // SUCCESS
        if (next.response != null) {

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content: Text(
                next.response!.message,
              ),
              backgroundColor: Colors.green,
            ),

          );

        }


        // ERROR
        if (next.errorMessage != null) {

          ScaffoldMessenger.of(context)
              .showSnackBar(

            SnackBar(
              content: Text(
                next.errorMessage!,
              ),
              backgroundColor: Colors.red,
            ),

          );

        }

      },
    );
//river pod handling overs here
//Implementation of riverpod in ui

    return Scaffold(

      backgroundColor: Colors.black,

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.only(
            top: 20,
            right: 30,
            left: 30,
            bottom: 20,
          ),

          child: SingleChildScrollView(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // --------------------------------------------------
                // BACK ICON
                // --------------------------------------------------

                GestureDetector(

                  onTap: () {

                    Navigator.pop(context);

                  },

                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),

                ),

                const SizedBox(height: 20),


                // --------------------------------------------------
                // TITLE
                // --------------------------------------------------

                const Text(
                  "Sign Up",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),

                ),

                const SizedBox(height: 20),


                // --------------------------------------------------
                // USERNAME
                // --------------------------------------------------

                const Padding(

                  padding:
                      EdgeInsets.only(left: 20),

                  child: Text(
                    "your Username",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                  ),

                ),

                TextField(

                  controller:
                      usernameController,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                      _inputDecoration(
                    "Enter your Username",
                  ),

                ),

                const SizedBox(height: 30),


                // --------------------------------------------------
                // NAME
                // --------------------------------------------------

                const Padding(

                  padding:
                      EdgeInsets.only(left: 20),

                  child: Text(
                    "Name",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                  ),

                ),

                TextField(

                  controller:
                      nameController,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                      _inputDecoration(
                    "Enter your Name",
                  ),

                ),

                const SizedBox(height: 20),


                // --------------------------------------------------
                // EMAIL
                // --------------------------------------------------

                const Padding(

                  padding:
                      EdgeInsets.only(left: 20),

                  child: Text(
                    "your Email",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                  ),

                ),

                TextField(

                  controller:
                      emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                      _inputDecoration(
                    "Enter your Email",
                  ),

                ),

                const SizedBox(height: 20),


                // --------------------------------------------------
                // PHONE
                // --------------------------------------------------

                const Padding(

                  padding:
                      EdgeInsets.only(left: 20),

                  child: Text(
                    "your Phone number",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                  ),

                ),

                TextField(

                  controller:
                      phoneController,

                  keyboardType:
                      TextInputType.phone,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                      _inputDecoration(
                    "Enter your Phone no",
                  ),

                ),

                const SizedBox(height: 20),


                // --------------------------------------------------
                // PASSWORD
                // --------------------------------------------------

                const Padding(

                  padding:
                      EdgeInsets.only(left: 20),

                  child: Text(
                    "your Password",

                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                  ),

                ),

                TextField(

                  controller:
                      passwordController,

                  obscureText: true,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration:
                      _inputDecoration(
                    "Enter your Password",
                  ),

                ),

                const SizedBox(height: 10),


                // --------------------------------------------------
                // LOGIN LINK
                // --------------------------------------------------

                Align(

                  alignment:
                      Alignment.bottomRight,

                  child: InkWell(

                    onTap: () {

                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const LoginScreen(),

                        ),

                      );

                    },

                    child: const Text(

                      "Already have an account Login",

                      style: TextStyle(
                        color: Colors.blue,
                      ),

                    ),

                  ),

                ),

                const SizedBox(height: 40),


                // --------------------------------------------------
                // SIGN UP BUTTON
                // --------------------------------------------------

                GestureDetector(

                  onTap: signupState.isLoading
                      ? null
                      : () {

                          ref
                              .read(
                                signupProvider
                                    .notifier,
                              )
                              .register(

                                fullName:
                                    nameController
                                        .text
                                        .trim(),

                                username:
                                    usernameController
                                        .text
                                        .trim(),

                                email:
                                    emailController
                                        .text
                                        .trim(),

                                phone:
                                    phoneController
                                        .text
                                        .trim(),

                                password:
                                    passwordController
                                        .text
                                        .trim(),

                              );

                        },

                  child: Container(

                    height: 50,

                    width:
                        double.infinity,

                    decoration:
                        BoxDecoration(

                      color:
                          const Color.fromARGB(
                        255,
                        1,
                        163,
                        147,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),

                    ),

                    child: Center(

                      child:
                          signupState.isLoading

                              ? const SizedBox(

                                  height: 25,

                                  width: 25,

                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),

                                )

                              : const Text(

                                  "Sign Up",

                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),

                                ),

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }


  // --------------------------------------------------
  // COMMON INPUT DECORATION
  // --------------------------------------------------

  InputDecoration _inputDecoration(
      String hintText) {

    return InputDecoration(

      hintText: hintText,

      hintStyle:
          const TextStyle(
        color: Colors.grey,
      ),

      filled: true,

      fillColor:
          const Color(0xff2B2B2B),

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      border:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(25),

        borderSide:
            BorderSide.none,

      ),

      focusedBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(25),

        borderSide:
            BorderSide.none,

      ),

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(25),

        borderSide:
            BorderSide.none,

      ),

    );

  }

}