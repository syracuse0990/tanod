import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

class ProfileTilesWidget extends GetWidget<ProfileController> {
  final int index;
  final bool? isShowIcon;

  const ProfileTilesWidget({
    super.key,
    required this.index,
    this.isShowIcon,
  });

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
                  child: controller.profileTiles[index].isIcon == null
                      ? IconButton(
                          onPressed: () {},
                          icon: (SvgPicture.asset(
                              controller.profileTiles[index].icon)))
                      : Image.asset(controller.profileTiles[index].icon,height: 25.h,width: 25.w,color: Colors.grey,))),
          AddSpace.horizontal(8.w),
          TractorText(
            text: controller.profileTiles[index].title,
            fontSize: 16.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
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
