import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/config/app_colors.dart';

class TractorButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? height;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final ShapeBorder? border;
  const TractorButton({
    super.key,
    this.text,
    this.color,
    this.height,
    this.width,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap ?? () {},
      color: color ?? AppColors.primary,
      elevation: 0,
      minWidth: width ?? double.infinity,
      height: height ?? 48,
      shape: border ??
          RoundedRectangleBorder(
              side: BorderSide(width: 2.r, color: AppColors.primary),
              borderRadius: BorderRadius.circular(10.r)),
      child: Text(
        text ?? 'Continue', //AppStrings.signUp,
        style: TextStyle(
            fontSize: fontSize ?? 17.sp,
            color: textColor ?? AppColors.white,
            fontFamily:
                GoogleFonts.poppins(fontWeight: fontWeight ?? FontWeight.w500)
                    .fontFamily),
      ),
    );
  }
}
