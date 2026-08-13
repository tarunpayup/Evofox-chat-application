import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';
import '../models/register_response.dart';
import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepository();
});

class SignupState{ //-> State -> Loading (isLoading), Success (response), Error (errorMessage)
  final bool isLoading;
  final String? errorMessage;
  final RegisterResponse? response;

  SignupState({
    this.isLoading = false,
    this.errorMessage,
    this.response
  });
}

class SignupNotifier extends StateNotifier<SignupState>{
  final AuthRepository repository;
  SignupNotifier(this.repository):super(SignupState());
  

  Future<void> register({
    required String fullName,
    required String username,
    required String email,
    required String phone,
    required String password
  }) async{ //-> Asynchronous programming -> Background thread
    state = SignupState(
      isLoading: true
    );
    try{
      final response = await repository.register(fullName: fullName, username: username, email: email, phone: phone, password: password);

      if(response.success){
        state = SignupState(
          isLoading: false,
          response: response
        );
      }else{
        state = SignupState(
          isLoading: false,
          errorMessage: response.message
        );
      }
    }catch(e){
      state = SignupState(
        isLoading: false,
        errorMessage: "Something went wrong. Please try again later"
      );
    }
  }


}

final signupProvider = StateNotifierProvider<SignupNotifier,SignupState>((ref){
  final repository = ref.read(authRepositoryProvider);
  return SignupNotifier(repository);
});