import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api.dart';
import '../models/register_response.dart';
import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return AuthRepository();
});

