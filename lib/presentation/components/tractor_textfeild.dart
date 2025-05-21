import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/config/app_colors.dart';

class TractorTextfeild extends StatelessWidget {
  final String? svgIcon;
  final String? hint;
  final Color? bgColor;
  final TextEditingController? controller;
  final double? height;
  final bool isSufix;
  final bool isPrefix;
  final bool? isHint;
  final bool? obscureText;
  final Widget? countryPicker;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onSufixTap;
  final bool? isEnabned;
  final String? sufixIcons;
  final double? suficIconHeight;
  final bool? readOnly;
  final bool? isVisible;
  final Widget? suffixWidget;

  final Function(String)? onChanged;
  final Function(String)? onValidator;

  const TractorTextfeild({
    super.key,
    this.controller,
    this.svgIcon,
    this.hint,
    this.isVisible=false,
    this.height,
    this.isSufix = false,
    this.bgColor,
    this.isPrefix = false,
    this.isHint = true,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.countryPicker,
    this.onSufixTap,
    this.isEnabned = true,
    this.sufixIcons,
    this.suficIconHeight,
    this.readOnly,
    this.suffixWidget,
    this.onChanged,
    this.onValidator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        enabled: isEnabned,
        style: TextStyle(
          fontSize: 18.sp,
          color: AppColors.primary,
          height: 1.0,
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
        ),
        inputFormatters: inputFormatters,
        validator:(data){
        if(onValidator!=null){
          onValidator!(data!);
        }
        },
        textAlign: TextAlign.justify,
        obscureText: obscureText!,
        textInputAction: textInputAction ?? TextInputAction.done,
        decoration: InputDecoration(
            suffixIcon: isSufix
                ? GestureDetector(
                    onTap: onSufixTap ?? () {},
                    child: suffixWidget??Container(
                      margin: EdgeInsets.only(right: 15.w),
                      padding: EdgeInsets.all(8.r),
                      child: isVisible==false
                          ? Icon(
                              Icons.visibility_off,
                              color: AppColors.primary,
                              size: 25.r,
                            )
                          : Icon(
                              Icons.visibility,
                              color: AppColors.primary,
                              size: 25.r,
                            ),
                    ),
                  )
                : const SizedBox.shrink(),
            hintText: hint,
            focusedBorder: const UnderlineInputBorder(),
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.lightGray.withOpacity(0.5),
              height: 0.0,
              fontFamily:
                  GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                      .fontFamily,
            )),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        controller: controller,
      ),
    );
  }
}
