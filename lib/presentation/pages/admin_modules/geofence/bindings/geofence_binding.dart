import 'package:get/get.dart';

import '../controller/geofence_controller.dart';

class GeoFenceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminGeoFenceController());
  }
}
