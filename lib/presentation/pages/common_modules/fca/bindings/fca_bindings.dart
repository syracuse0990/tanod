import 'package:get/get.dart';

import '../controller/FCAController.dart';




class FCABindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FCAController());
  }
}
