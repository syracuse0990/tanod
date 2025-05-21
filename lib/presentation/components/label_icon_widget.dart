import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';

class AppIconLabel extends StatelessWidget {
  final double? width;
  final double? height;
  final String? svgIcon;
  final Color? bgColor;
  final String? label;
  final double? radius;
  final TextStyle? textStyle;
  final double? fontSize;
  final double? lineHeight;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? svgIconColor;

  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Function? onTab;


  const AppIconLabel(
      {super.key,
      this.svgIcon,
      this.bgColor,
      this.label,
      this.radius,
      this.textStyle,
      this.fontSize,
      this.lineHeight,
      this.textColor,
      this.fontWeight,
      this.margin,
      this.width,
      this.height,
      this.onTab,
      this.textAlign,
      this.padding,
      this.borderColor,
      this.svgIconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTab!=null){
          onTab!();
        }
      },
      child: Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.symmetric(horizontal: 3.r),
        padding: padding ?? EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: bgColor ?? AppColors.textYellow,
          borderRadius: BorderRadius.circular(radius ?? 5.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon ?? AppSvgAssets.off,
              colorFilter: ColorFilter.mode(
                  svgIconColor ?? AppColors.lightGray, BlendMode.srcATop),
            ),
            AddSpace.vertical(8.h),
            TractorText(
              textAlign: textAlign,
              text: label ?? "",
              style: textStyle ??
                  TextStyle(
                      fontFamily: GoogleFonts.plusJakartaSans(
                              fontWeight: fontWeight ?? FontWeight.w500)
                          .fontFamily,
                      fontSize: fontSize ?? 16.sp,
                      fontWeight: fontWeight ?? FontWeight.w500,
                      color: textColor ?? AppColors.lightGray,
                      height: lineHeight //?? 1.19,
                      ),
            )
          ],
        ),
      ),
    );
  }
}
