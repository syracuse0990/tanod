import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/user_management/controller/user_management_controller.dart';

class AdminUserProfileView extends GetView<UserManagementController> {
  var userId;

  AdminUserProfileView({this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r)),
        border: Border.all(color: AppColors.lightGray.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Obx(() => Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(3.r),
                    margin: EdgeInsets.all(60.r),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primary, width: 2.0),
                        color: AppColors.white,
                        shape: BoxShape.circle),
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
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  controller.profileImage.value?.path ?? "",
                                  fit: BoxFit.cover,
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
                          controller.showImageDialog(userId: userId);
                        },
                        icon: SvgPicture.asset(AppSvgAssets.editProfile)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
