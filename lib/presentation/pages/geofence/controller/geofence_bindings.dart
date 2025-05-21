import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/geofence/controller/geofence_controller.dart';

class GeoFenceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GeoFenceController());
  }
}
