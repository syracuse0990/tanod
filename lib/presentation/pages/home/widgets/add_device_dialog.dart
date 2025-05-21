import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_button.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/components/tractor_textfeild.dart';
import 'package:tanod_tractor/presentation/pages/home/controller/home_controller.dart';

class AddDeviceDialog extends GetWidget<HomeController> {
  const AddDeviceDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(20.r),
      contentPadding: EdgeInsets.all(20.r),
      content: Container(
        height: Get.height * 0.35,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            color: AppColors.white, shape: const ContinuousRectangleBorder()),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AddSpace.vertical(15.h),
                TractorText(
                  text: 'Add Device',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: TractorText(text: 'Enter IMEI')),
                const TractorTextfeild(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  hint: 'Enter IMEI',
                ),
                AddSpace.vertical(32.h),
                TractorButton(
                  text: 'Add Device',
                  textColor: AppColors.primary,
                  color: AppColors.white,
                ),
                AddSpace.vertical(15.h),
                const TractorButton(
                  text: 'Scan QR Code',
                ),
                AddSpace.vertical(25.h),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Bounce(
                duration: const Duration(milliseconds: 180),
                onPressed: () => Get.back(),
                child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 20.r,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
