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
    this.isVisible = false,
    this.height,
    this.isSufix = false,
    this.bgColor,
    this.isPrefix = false,
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
      height: height ?? 60.h, // Slightly taller for floating label
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly ?? false,
        enabled: isEnabned,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.primary,
          height: 1.2,
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
        ),
        inputFormatters: inputFormatters,
        validator: (data) {
          if (onValidator != null) {
            onValidator!(data ?? '');
          }
          return null;
        },
        textAlign: TextAlign.justify,
        obscureText: obscureText!,
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        controller: controller,
        decoration: InputDecoration(
          labelText: hint, // Floating label
          labelStyle: TextStyle(
            fontSize: 15.sp,
            color: AppColors.lightGray.withOpacity(0.8),
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: isSufix
              ? GestureDetector(
                  onTap: onSufixTap ?? () {},
                  child: suffixWidget ??
                      Container(
                        margin: EdgeInsets.only(right: 15.w),
                        padding: EdgeInsets.all(8.r),
                        child: isVisible == false
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
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.lightGray.withOpacity(0.5), width: 1),
          ),
        ),
      ),
    );
  }
}
