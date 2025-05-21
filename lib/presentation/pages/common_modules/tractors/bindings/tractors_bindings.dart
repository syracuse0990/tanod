import 'package:get/get.dart';

import '../controller/common_tractors_controller.dart';

class CommonTractorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommonTractorController());
  }
}
