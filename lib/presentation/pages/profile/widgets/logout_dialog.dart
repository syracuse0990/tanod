import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_button.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

class LogoutDialog extends GetWidget<ProfileController> {
  Function? onLogout;
  LogoutDialog({
    super.key,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r))),
      insetPadding:
          EdgeInsets.only(left: 20.w, right: 20.2, top: Get.height * 0.44),
      contentPadding: EdgeInsets.all(20.r),
      content: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            color: AppColors.white,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(29))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppPngAssets.logout),
            AddSpace.vertical(15.h),
            TractorText(
              text: 'Are You Sure?',
              fontSize: 24.sp,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
            AddSpace.vertical(10.h),
            TractorText(
              textAlign: TextAlign.center,
              text:
                  'Are you sure you want to logout from this\naccount? you can logging back in easily.',
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              lineHeight: 1.7,
            ),
            const Spacer(),
            AddSpace.vertical(32.h),
            TractorButton(
              text: 'Cancel',
              onTap: () {
                Get.back();
              },
            ),
            AddSpace.vertical(15.h),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: AppColors.lightGray.withOpacity(0.07),
                    spreadRadius: 12,
                    blurRadius: 10,
                    blurStyle: BlurStyle.normal)
              ]),
              child: TractorButton(
                text: 'Logout',
                textColor: AppColors.red,
                color: AppColors.white,
                border: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                onTap: () {
                  if(onLogout!=null){
                    onLogout!();
                  }


                },
              ),
            ),
            AddSpace.vertical(25.h),
          ],
        ),
      ),
    );
  }
}
