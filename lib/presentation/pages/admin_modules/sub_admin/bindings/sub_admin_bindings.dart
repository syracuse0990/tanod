
import '../../../../../app/util/export_file.dart';

class SubAdminBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SubAdminController());
  }
}