import 'package:get/get.dart';

import '../controller/create_group_controller.dart';

class CreateGroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateGroupController());
  }
}
