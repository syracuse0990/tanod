

import '../../../../../app/util/export_file.dart';
import '../controller/calender_view_controller.dart';

class TractorCalenderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TractorCalenderController());
  }
}
