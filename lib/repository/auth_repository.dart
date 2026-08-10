import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register_response.dart';
import '../api.dart';

class AuthRepository{
  final String registerUrl = registerApiUrl;

  Future<RegisterResponse> register(
   {
    required String fullName,
    required String username,
    required String email,
    required String phone,
    required String password
   }) async{
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {
        "Content-Type":"application/json",
      },
      body: jsonEncode({
        "full_name":fullName,
        "username":username,
        "email":email,
        "phone":phone,
        "password":password
      }),
      );
      final Map<String,dynamic> json = jsonDecode(response.body);

      return RegisterResponse.fromJson(json);
   }
}