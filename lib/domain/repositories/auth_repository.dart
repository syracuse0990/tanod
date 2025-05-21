import '../entities/auth.dart';

abstract class AuthenticationRepository {
  Future<AuthEntity> otp(dynamic email);
  Future<AuthEntity> signUp(dynamic signUp);
  Future<AuthEntity> logIn(dynamic login);
}
