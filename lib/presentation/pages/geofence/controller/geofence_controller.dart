import 'package:get/get.dart';
import 'package:page_state_handler/page_state_handler.dart';
import 'package:tanod_tractor/presentation/pages/base/base_controller.dart';

import '../../../../app/util/mock.dart';

class GeoFenceController extends GetxController with BaseController {
  PageStateController pageStateController = PageStateController();
  @override
  void onInit() {
    super.onInit();
    retry();
  }

  /// Testing
  void fetchgeofence() async {
    try {
      showLoading();
      await Future<void>.delayed(const Duration(seconds: 2));
      hideLoading();
      pageStateController.onStateUpdate(PageState.loaded);

      throw Exception('asdf');
    } catch (e) {
      handleError(e, () {}, isBack: false);
      pageStateController.onError('Somthing went wasdfasdfasf');
    }
  }

  void retry() async {
    pageStateController.onStateUpdate(
      PageState.loading,
    );
    await Future.delayed(const Duration(seconds: 2));
    pageStateController.onStateUpdate(
      randomBool()
          ? PageState.loaded
          : randomBool()
              ? PageState.empty
              : PageState.error,
    );
  }
}
