import 'package:get/get.dart';

import '../controllers/feedback_controller.dart';

class FeedbackBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController(),);
  }
}