import 'package:get/get.dart';

import '../controller/admin_booking_controller.dart';

class AdminBookingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminBookingController());
  }
}
