import 'package:get/get.dart';

import '../controllers/alter_controller.dart';

class AlertBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlertController());
  }

}