import 'package:get/get.dart';

import '../controllers/admin_feedback_controller.dart';

class AdminFeedbackBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AdminFeedbackController(),);
  }
}