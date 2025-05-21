import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

import '../../../../data/repositories/login_provider/impl/remote_login_provider.dart';
import '../../alert/controllers/alter_controller.dart';
import '../../maintenance/controller/maintenance_controller.dart';
import '../../profile/controller/profile_controller.dart';
import 'dishboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => AlertController());
     if (!Get.isRegistered<ListController>()) {
      Get.lazyPut(() => ListController());
    }

    if (!Get.isRegistered<DashboardController>()) {
      Get.lazyPut(() => DashboardController());
    }

    if (!Get.isRegistered<MaintenanceController>()) {
      Get.lazyPut(() => MaintenanceController());
    }

    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut(() => ProfileController());
    }

    if (!Get.isRegistered<RemoteILoginProvider>()) {
      Get.lazyPut(() => RemoteILoginProvider());
    }


  }
}
