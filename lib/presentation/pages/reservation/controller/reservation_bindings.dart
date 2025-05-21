import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/reservation/controller/reservation_controller.dart';

class ReservationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReservationController());
  }
}
