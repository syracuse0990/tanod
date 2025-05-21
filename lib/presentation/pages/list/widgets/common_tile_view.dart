import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/config/app_colors.dart';
import '../../../components/tractor_text.dart';

class CommonTileView extends StatelessWidget {
  String? title;
  Function? onTab;
  bool? isSelected;


  CommonTileView({this.isSelected, this.title, this.onTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: isSelected == null
                  ? AppColors.lightGray.withOpacity(0.3)
                  : isSelected == true
                      ? AppColors.authGradientTop
                      : AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TractorText(
              text: title ?? "",
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
