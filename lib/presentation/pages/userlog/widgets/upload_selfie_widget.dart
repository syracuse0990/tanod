import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

class UploadSelfieWidget extends GetWidget<ProfileController> {
  const UploadSelfieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: AppColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddSpace.vertical(10),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20.r),
                child: CircleAvatar(
                  radius: 89.r,
                  backgroundColor: AppColors.white,
                  child: CircleAvatar(
                    radius: 80.r,
                    backgroundImage: const CachedNetworkImageProvider(
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  ),
                ),
              ),
              Positioned(
                top: Get.height * 0.15,
                left: Get.width * 0.32,
                child: CircleAvatar(
                  radius: 23.r,
                  backgroundColor: AppColors.primary,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.white,
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AppSvgAssets.camera,
                          height: 24.r,
                        )),
                  ),
                ),
              ),
            ],
          ),
          TractorText(
            text: 'Upload Selfie',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          AddSpace.vertical(20.h),
        ],
      ),
    );
  }
}
