import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

class ListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListController());
  }
}
