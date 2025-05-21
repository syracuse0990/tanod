import 'package:get/get.dart';

import '../controller/user_management_controller.dart';

class UserManagementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserManagementController());
  }
}
