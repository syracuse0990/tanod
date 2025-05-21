
import '../../../app/core/usecases/pram_usecase.dart';
import '../../entities/auth.dart';
import '../../repositories/auth_repository.dart';

class SignUpUseCase extends ParamUseCase<AuthEntity, dynamic> {
  final AuthenticationRepository _repo;
  SignUpUseCase(this._repo);

  @override
  Future<AuthEntity> execute(dynamic params) {
    return _repo.signUp(params);
  }
  
}
