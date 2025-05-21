import 'package:get/get.dart';

import '../controller/common_device_controller.dart';

class CommonDeviceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommonDeviceController());
  }
}
