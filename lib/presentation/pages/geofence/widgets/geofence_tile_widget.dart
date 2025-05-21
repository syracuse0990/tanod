import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';

import '../../maintenance/controller/maintenance_controller.dart';


class GeoFenceTileWidget extends GetWidget<MaintenanceController> {
  const GeoFenceTileWidget({
    super.key,
    this.title,
    this.id,
    this.description,
    this.statusBgColor,
  });

  final String? title;
  final String? id;
  final String? description;
  final Color? statusBgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      padding: EdgeInsets.all(6.r),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: AppColors.lightGray.withOpacity(0.3)),
      )),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 35.r,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppSvgAssets.fence)),
                    ),
                    AddSpace.horizontal(12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppSvgAssets.phone),
                            TractorText(
                              text: title ?? ' Kasaka Inc. ',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            SvgPicture.asset(AppSvgAssets.time),
                            TractorText(
                              text: title ?? ' 0.20km',
                              fontSize: 16.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        AddSpace.vertical(8.h),
                        TractorText(
                          textAlign: TextAlign.start,
                          text: description ??
                              'Suite 939 24719 Goodwin Spring,\nReginehaven, MI 25181',
                          fontSize: 14.sp,
                          color: AppColors.lightGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppSvgAssets.more),
              ),
              onSelected: (value) {
                //Todo:
                if (value == 'edit') {
                } else if (value == 'addDevice') {
                } else {}
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppSvgAssets.edit,
                          colorFilter: ColorFilter.mode(
                              AppColors.primary, BlendMode.srcATop),
                        ),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Edit',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'addDevice',
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppSvgAssets.phone,
                          colorFilter: ColorFilter.mode(
                              AppColors.primary, BlendMode.srcATop),
                        ),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Add Device',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'remove',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgAssets.delete),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Remove',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
