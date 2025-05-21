import 'package:tanod_tractor/domain/entities/auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';
import '../providers/network/apis/auth_api.dart';

class AuthenticationRepositoryIml extends AuthenticationRepository {
  @override
  Future<AuthEntity> logIn(dynamic login) async {
    final response = await AuthAPI.logIn(login).request();
    return AuthModel.fromMap(response);
  }

  @override
  Future<AuthEntity> signUp(dynamic signUp) async {
    final response = await AuthAPI.signUp(signUp).request();
    print(response.toString());
    return AuthModel.fromMap(response);
  }

  @override
  Future<AuthEntity> otp(dynamic email) async {
    final response = await AuthAPI.otp(email).request();
    print(response.toString());
    return AuthModel.fromMap(response);
  }
}
