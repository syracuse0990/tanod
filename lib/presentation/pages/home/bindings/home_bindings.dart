import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/home/controller/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
