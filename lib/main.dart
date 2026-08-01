import 'package:evofox_chat_app/repository/auth_repository.dart';
import 'package:evofox_chat_app/screens/login_screen.dart';
import 'package:evofox_chat_app/screens/signup_Screen.dart';
import 'package:flutter/material.dart';

void main() {
    registerUser();
}
final AuthRepository authRepository = AuthRepository();

void registerUser() async{

    var response = await authRepository.register(

      fullName: "Tarun Bansal",

      username: "tarunpayup",

      email: "tarun@gmail.com",

      phone: "9821354741",

      password: "Tb@123456"

    );

    print(response);

}