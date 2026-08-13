import 'package:evofox_chat_app/providers/signup_provider.dart';
import 'package:evofox_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget{
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen>{
  /*Text Controllers*/
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /*Dispose Controllers*/
  @override
  void dispose(){
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  /*Build*/
  @override
  Widget build(BuildContext context){
    final signupState = ref.watch(signupProvider);

    //Listen for success or error
    ref.listen(signupProvider, (previous,next){
      if(next.response != null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            next.response!.message
          ), backgroundColor: Colors.green,)
        );
      }

      if(next.errorMessage != null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            next.errorMessage!
          ), backgroundColor: Colors.red,)
        );        
      }
    });

    return Scaffold();
  }

}