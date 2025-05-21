import 'package:get/get.dart';

import '../controller/static_page_controller.dart';

class StaticPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StaticPageController());
  }
}
