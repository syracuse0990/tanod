import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/config/app_colors.dart';

// ignore: must_be_immutable
class TractorSpanText extends StatelessWidget {
  final String? firstLabel, secondLabel;
  final TextStyle? firstTextStyle, lastTextStyle;
  final Alignment? align;
  final VoidCallback? onFirstTap;
  final VoidCallback? onTap;
  final TextSpan? third;
  const TractorSpanText(
      {this.firstLabel,
      this.secondLabel,
      this.firstTextStyle,
      this.lastTextStyle,
      this.align,
      Key? key,
      this.onFirstTap,
      this.onTap,
      this.third})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        recognizer: TapGestureRecognizer()..onTap = onFirstTap,
        text: firstLabel ?? "",
        style: firstTextStyle ??
            TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily:
                  GoogleFonts.mulish(fontWeight: FontWeight.w700).fontFamily,
              color: AppColors.lightGray,
              fontSize: 14.sp,
            ),
        children: <InlineSpan>[
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: secondLabel ?? "",
              style: lastTextStyle ??
                  TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily:
                        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)
                            .fontFamily,
                    color: AppColors.primary,
                    fontSize: 14.sp,
                  ),
              children: [if (third != null) third!])
        ]));
  }
}
