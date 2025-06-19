import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/home/controller/home_controller.dart';

import '../../../../data/repositories/map_provider/impl/remote_map_provider.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() => GoogleMap(
              markers: Set<Marker>.from(controller.markers),
              initialCameraPosition:
                  controller.kGooglePlex.value ?? controller.test,
              mapType: controller.mapType.value ?? MapType.normal,
              onMapCreated: (GoogleMapController mapController) async {
                controller.completeController.complete(mapController);
                // if (!controller.completeController.isCompleted) {

                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  controller.iMapRepository = Get.put(RemoteIMapProvider());

                  if (box.read(tokenKeys) != null) {}
                });
                //}

                //  controller.setMapType();
              },
            )),
        mapIconsWidget

        /* Positioned.fill(
          child: Image.asset(
            AppPngAssets.homebg,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: 15.w,
          top: Get.height * 0.1,
          child: MapSideIcons(
            onAdd: () {
              Get.dialog(
                const AddDeviceDialog(),
                arguments: Alignment.center,
              );
            },
            onTractorGroup: () {
              Get.toNamed(RoutePage.tractorGroups);
            },
          ),
        ),
        Positioned(
          left: 15.w,
          bottom: Get.height * 0.2,
          child: AppIconLabel(
            borderColor: AppColors.red,
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            radius: 8.r,
            bgColor: AppColors.white,
            svgIcon: AppSvgAssets.redAlert,
            textColor: AppColors.red,
            textAlign: TextAlign.center,
            label: 'Device is\n disconnected\n from tractor',
          ),
        ),*/

        /* const Align(
          alignment: Alignment.bottomCenter,
          child: HomeFarmerDialog(),
        )*/
      ],
    );
  }

  Widget get mapIconsWidget => Positioned(
        top: 100,
        right: 10,
        child: Container(
          padding: EdgeInsets.only(top: 8.h, bottom: 42.h),
          decoration: BoxDecoration(
              color: AppColors.transparentColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.changeMapType();
                },
                child: Image.asset(
                  AppPngAssets.switchMapImage,
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              Image.asset(
                AppPngAssets.mapRefreshImage,
                height: 50.h,
                width: 50.h,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.getLocation();
                },
                child: Image.asset(
                  AppPngAssets.mapCurrentLocation,
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
}
