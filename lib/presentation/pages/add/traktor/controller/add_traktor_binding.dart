import 'package:tanod_tractor/presentation/pages/add/device/controller/add_device_controller.dart';
import 'package:tanod_tractor/presentation/pages/add/traktor/controller/add_traktor_controller.dart';

import '../../../../../app/util/export_file.dart';

class AddTraktorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTraktorController());
  }
}
