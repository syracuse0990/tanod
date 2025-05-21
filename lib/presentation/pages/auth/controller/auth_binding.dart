import 'package:get/get.dart';
import 'package:tanod_tractor/domain/usecases/auth/otp_use_case.dart';

import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/usecases/auth/login_use_case.dart';
import '../../../../domain/usecases/auth/signup_use_case.dart';
import '../../splash/controllers/splash_controller.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.lazyPut(() => LogInUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.lazyPut(() => OtpUseCase(Get.find<AuthenticationRepositoryIml>()));

    Get.put(
        AuthController(
          Get.find(),
          Get.find(),
          Get.find(),
        ),
        permanent: true);
  /// DashboardBindings().dependencies();
  }
}
