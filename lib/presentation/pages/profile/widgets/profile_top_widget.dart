import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

class ProfileTopWidget extends GetWidget<ProfileController> {
  const ProfileTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.profileBg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AddSpace.vertical(20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Obx(() => Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(10.r),
                    margin: EdgeInsets.all(60.r),
                    decoration: BoxDecoration(
                        color: AppColors.white, shape: BoxShape.circle),
                    child: controller.profileImage.value == null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset(
                          AppPngAssets.noImageFound,
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                        ))
                        : controller.profileImage.value?.path
                        .toString()
                        .startsWith("http") ==
                        true
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                          child: Image.network(
                      controller.profileImage.value?.path ?? "",
                      fit: BoxFit.contain,
                      height: 120,
                      width: 120,
                    ),
                        )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                          child: Image.file(
                      controller.profileImage.value ?? File(""),
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                        ),
                  )),
                  Positioned(
                    top: Get.height * 0.20,
                    child: CircleAvatar(
                      radius: 32.r,
                      backgroundColor: AppColors.white,
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor: AppColors.lightGray.withOpacity(0.2),
                        child: IconButton(
                            onPressed: () {
                              controller.showImageDialog();
                            },
                            icon: SvgPicture.asset(AppSvgAssets.editProfile)),
                      ),
                    ),
                  ),
                ],
              ),

              //  AddSpace.vertical(12.h),
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: ShapeDecoration(
                    color: AppColors.white, shape: const StadiumBorder()),
                child: TractorText(
                  text: controller.userDataModel?.value?.email ?? "",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
              ),
              AddSpace.vertical(20.h),
            ],
          ),
        ));
  }
}
