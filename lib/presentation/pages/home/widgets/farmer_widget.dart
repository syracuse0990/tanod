import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/util/mock.dart';
import '../../../components/add_space.dart';
import '../../../components/label_icon_widget.dart';
import '../../../components/tractor_text.dart';

class HomeFarmerWidget extends GetWidget {
  const HomeFarmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: Colors.white,
      height: Get.height * 0.18,
      width: Get.width,
      child: Column(
        children: [
          Container(
            height: 2.1.h,
            width: Get.width * 0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.lightGray,
                shape: BoxShape.rectangle),
          ),
          AddSpace.vertical(10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back_ios),
                TractorText(
                  text: 'Farmer Coop 1',
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: randomColor().withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: const TractorText(text: '564787984454'),
                )
              ],
            ),
          ),
          AddSpace.vertical(10.h),
          SizedBox(
            height: 80.h,
            child: Row(
              children: [
                AddSpace.horizontal(30.w),
                Container(
                  padding: EdgeInsets.all(10.r),
                  child: Column(
                    children: [
                      TractorText(
                        text: 'Stopped',
                        color: AppColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      const Spacer(),
                      TractorText(
                        text: '4hr',
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return AspectRatio(
                          aspectRatio: 1 / 0.89,
                          child: AppIconLabel(
                            bgColor: randomColor().withOpacity(0.2),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
