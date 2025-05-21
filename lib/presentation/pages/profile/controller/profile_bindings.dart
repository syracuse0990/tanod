import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
