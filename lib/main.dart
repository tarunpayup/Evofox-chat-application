import 'package:evofox_chat_app/screens/login_screen.dart';
import 'package:evofox_chat_app/screens/signup_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {"/": (context) => const LoginScreen()},
    );
  }
}
