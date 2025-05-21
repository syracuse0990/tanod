import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/presentation/components/span_text.dart';

import '../../app/config/app_colors.dart';

class TractorBackArrowBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextStyle? firstTextStyle;
  final TextStyle? lastTextStyle;
  final String? firstLabel, secondLabel;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Widget? leading;

  const TractorBackArrowBar({
    this.firstLabel,
    this.secondLabel,
    this.firstTextStyle,
    this.lastTextStyle,
    Key? key,
    this.onMenuPressed,
    this.onBackPressed,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20.h,
              left: 20.w,
              bottom: 10.h,
              right: 20.w),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) ...[
                  leading!
                ] else ...[
                  GestureDetector(
                    onTap: onBackPressed ?? () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 25.r,
                      color: AppColors.white,
                    ),
                  ),
                ],
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: TractorSpanText(
                        firstLabel: firstLabel ?? '',
                        secondLabel: secondLabel ?? '',
                        firstTextStyle: firstTextStyle ??
                            TextStyle(
                                fontSize: 24.sp,
                                color: AppColors.white,
                                fontFamily: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily),
                        lastTextStyle: lastTextStyle ??
                            TextStyle(
                                fontSize: 24.sp,
                                color: AppColors.textYellow,
                                fontFamily: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600)
                                    .fontFamily),
                      ),
                    ),
                  ),
                ),
                Row(children: actions ?? [])
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}
