import 'package:get/get.dart';

import '../controllers/device_all_alerts_controller.dart';

class DeviceAllAlertBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DeviceAllAlertsController());
  }

}