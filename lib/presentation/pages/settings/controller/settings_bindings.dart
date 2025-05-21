import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/settings/controller/settings_controller.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
