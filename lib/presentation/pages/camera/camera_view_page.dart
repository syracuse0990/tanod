import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../components/add_space.dart';
import '../../components/tractor_text.dart';
import 'controller/camera_controller.dart';

class CameraPage extends GetView<CameraControllerG> {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () {
        controller.cameraC.dispose();
        Get.back();
        return Future.value(false);
      },
      child: Obx(() {
        print(controller.cameraState.value);
        return switch (controller.cameraState.value) {
          CameraState.loading => Container(
              color: Colors.white,
            ),
          CameraState.error => Container(
              color: Colors.red,
            ),
          CameraState.loaded => Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(controller.cameraC),
                ),
                // Positioned(
                //   bottom: 35,
                //   left: Get.width / 2.33,
                //   child: CircleAvatar(
                //     radius: 33.r,
                //     backgroundColor: AppColors.primary,
                //     child: Bounce(
                //       duration: const Duration(milliseconds: 150),
                //       onPressed: () async {},
                //       child: CircleAvatar(
                //         backgroundColor: AppColors.white,
                //         radius: 30.r,
                //         child: SvgPicture.asset(
                //           AppSvgAssets.camera,
                //           height: 25.r,
                //           width: 25.r,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
        };
      }),
    ));
  }

  void takePhotoFarmWithPlotDialog(VoidCallback onTap) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: onTap,
          //   child: CircleAvatar(
          //     radius: 98.r,
          //     backgroundColor: AppColors.primary,
          //     child: CircleAvatar(
          //       backgroundColor: AppColors.white,
          //       radius: 90.r,
          //       child: SvgPicture.asset(
          //         AppSvgAssets.camera,
          //         height: 90.r,
          //         width: 90.r,
          //       ),
          //     ),
          //   ),
          // ),
          AddSpace.vertical(25.h),
        ],
      ),
    );
  }
}

class _CameraGeoTaggingWidget extends GetView<CameraControllerG> {
  final bool isInvisible;
  final String path;
  const _CameraGeoTaggingWidget({this.isInvisible = false, this.path = ''});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isInvisible) ...[
          Positioned.fill(
            child: CameraPreview(controller.cameraC),
          )
        ],
        if (isInvisible) ...[
          Positioned.fill(
            child: Image.file(File(path)),
          )
        ],
        Positioned(
          bottom: 40.h,
          left: 20.w,
          right: 20.w,
          child: GestureDetector(
            onTap: () {
              controller.getLocation();
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              height: 170.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.black.withOpacity(0.4),
              ),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TractorText(
                              color: AppColors.textYellow,
                              text:
                                  "Lat  :-  ${controller.pos.latitude.toString()}"),
                          TractorText(
                              color: AppColors.white,
                              text: "DateTime :-  ${controller.formattedDate}"),
                        ],
                      ),
                      TractorText(
                          color: AppColors.textYellow,
                          text:
                              "Lng :- ${controller.pos.longitude.toString()}"),
                      Expanded(
                        child: TractorText(
                            text:
                                "Address :- ${controller.currentAddress.value.toString()}"),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
