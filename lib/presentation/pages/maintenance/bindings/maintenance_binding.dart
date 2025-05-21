import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/maintenance/controller/maintenance_controller.dart';

class MaintenanceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MaintenanceController());
  }
}
