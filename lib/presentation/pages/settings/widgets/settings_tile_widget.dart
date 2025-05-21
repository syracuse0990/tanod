import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/settings/controller/settings_controller.dart';

class SettingsTilesWidget extends GetWidget<SettingController> {
  const SettingsTilesWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(1.r),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundColor: AppColors.white,
            child: CircleAvatar(
              radius: 26.r,
              backgroundColor: AppColors.profileBg.withOpacity(0.6),
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(controller.settingsTiles[index].icon)),
            ),
          ),
          AddSpace.horizontal(8.w),
          TractorText(
            text: controller.settingsTiles[index].title,
            fontSize: 16.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          TractorText(
            text: controller.settingsTiles[index].description!,
            fontSize: 14.sp,
            color: AppColors.lightGray,
            fontWeight: FontWeight.w500,
          ),
          AddSpace.horizontal(5.w),
          Icon(
            Icons.arrow_forward_ios,
            size: 17,
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}
