import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/app/util/mock.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

class ListTileWidget extends GetWidget<ListController> {
  const ListTileWidget({
    super.key,
    this.text,
    this.id,
    this.status,
    this.statusBgColor,
  });

  final String? text;
  final String? id;
  final String? status;
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
                      radius: 40.r,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppSvgAssets.tractor)),
                    ),
                    AddSpace.horizontal(12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TractorText(
                          text: text ?? randomText(20),
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        AddSpace.vertical(8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                          decoration: ShapeDecoration(
                            color: AppColors.lightGray.withOpacity(0.1),
                            shape: const StadiumBorder(),
                          ),
                          child: TractorText(
                            text: id ?? randomUuid(),
                            fontSize: 14.sp,
                            color: AppColors.lightGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 15.w),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      decoration: ShapeDecoration(
                        color: statusBgColor ?? randomColor(),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      child: TractorText(
                        text: status ?? '',
                        fontSize: 13.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                if (value == 'playback') {
                } else if (value == 'details') {
                } else {}
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: 'playback',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgAssets.playBack),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Playback',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'details',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgAssets.details),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Details',
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'tracking',
                    child: Row(
                      children: [
                        SvgPicture.asset(AppSvgAssets.tracking),
                        AddSpace.horizontal(10.w),
                        TractorText(
                          text: 'Tracking',
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
