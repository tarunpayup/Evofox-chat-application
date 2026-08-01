import '../models/register/register_request.dart';
import '../models/register/register_response.dart';
import '../services/register_service.dart';

class RegisterRepository {
  final RegisterService _registerService = RegisterService();

  Future<RegisterResponse> register(
      RegisterRequest request) async {
    try {
      final response = await _registerService.register(request);

      return RegisterResponse.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}