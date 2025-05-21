import 'package:get/get.dart';

import '../../data/repositories/auth_repository_impl.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(
      () => AuthenticationRepositoryIml(),
    );

  }
}
