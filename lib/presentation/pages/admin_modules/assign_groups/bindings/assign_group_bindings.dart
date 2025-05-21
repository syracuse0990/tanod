
import '../../../../../app/util/export_file.dart';

class AssignGroupBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => AssignGroupsController());
  }
}