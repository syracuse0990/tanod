import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../data/repositories/login_provider/interface/ilogin_repository.dart';
import '../../admin_modules/geofence/controller/geofence_controller.dart';
import '../../admin_modules/geofence/views/add_new_geofence_view.dart';
import '../../admin_modules/geofence/views/admin_geofence_detail_view.dart';
import '../../full_details/common_controller.dart';
import '../../full_details/tractor_full_details.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/widgets/booking_detail_page.dart';

class DashboardController extends GetxController{
  ILoginRepository? loginRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    // Get.lazyPut(() => DashBoardPage(), fenix: false);
   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
     checkBackgroundMessage();
   });


    print("on init called ");
    super.onInit();
  }

  checkBackgroundMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      if (remoteMessage?.data['notification_type']?.toString() == APIEndpoint.typeEnterGeoFence || remoteMessage?.data['notification_type'] == APIEndpoint.typeExitGeofence) {
        if (!Get.isRegistered<AdminGeoFenceController>()) {
          Get.lazyPut(() => AdminGeoFenceController());
        }
        if (            box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole
        ) {
          Get.to(AdminGeoFenceDetailView(geoFenceId: remoteMessage?.data['imei']));
        } else {
          Get.to(() => AddNewGeoFenceView( isFromHome: true, deviceImei: remoteMessage?.data['imei'],));
        }
      }else{
        if(!Get.isRegistered<CommonController>()){
          Get.lazyPut(() =>CommonController());
        }
        Get.to(TractorFullDetails(tractorModel: TractorModel(id: remoteMessage?.data['tractor_id']),));
      }
    });
  }

}
