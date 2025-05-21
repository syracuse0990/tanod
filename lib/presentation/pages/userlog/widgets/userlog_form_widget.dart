import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import '../../../components/add_space.dart';
import '../../../components/tractor_button.dart';
import '../../../components/tractor_text.dart';
import '../../../components/tractor_textfeild.dart';

class UserLogFormWidget extends GetWidget<ProfileController> {
  const UserLogFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TractorText(text: 'Your Name'),
          const TractorTextfeild(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            hint: 'Abid Syeed',
          ),
          AddSpace.vertical(30.h),
          const TractorText(text: 'Contact'),
          const TractorTextfeild(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            hint: '+91 564 454 4561',
          ),
          AddSpace.vertical(30.h),
          const TractorText(text: 'Purpose of Use'),
          AddSpace.vertical(20.h),
          SizedBox(
            height: Get.height * 0.13,
            child: TextField(
              maxLines: 100,
              cursorColor: AppColors.primary,
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                  height: 1.1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                floatingLabelAlignment: FloatingLabelAlignment.center,
                hintText: 'Please Enter details',
                filled: true,
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.lightGray.withOpacity(0.5),
                  height: 0.0,
                  fontFamily:
                      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                          .fontFamily,
                ),
                fillColor: AppColors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.lightGray.withOpacity(0.2),
                  ),
                ),
                focusColor: AppColors.lightGray.withOpacity(0.2),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          AddSpace.vertical(Get.height * 0.1),
          TractorButton(
            text: 'Submit',
            onTap: () {},
          ),
          AddSpace.vertical(40.h),
        ],
      ),
    );
  }
}
