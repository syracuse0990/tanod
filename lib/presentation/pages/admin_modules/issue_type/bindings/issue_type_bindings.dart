import 'package:get/get.dart';

import '../controller/issue_type_controller.dart';

class IssueTypeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IssueTypeController());
  }
}
