import '../core/api/api_client.dart';
import '../core/api/api_constants.dart';
import '../models/register/register_request.dart';

class RegisterService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> register(
      RegisterRequest request) async {

    final response = await _apiClient.post(
      url: ApiConstants.register,
      body: request.toJson(),
    );

    return response;
  }
}