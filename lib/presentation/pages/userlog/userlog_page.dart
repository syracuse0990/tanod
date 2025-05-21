import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';
import 'package:tanod_tractor/presentation/pages/userlog/widgets/upload_selfie_widget.dart';
import 'package:tanod_tractor/presentation/pages/userlog/widgets/userlog_form_widget.dart';

class UserLogPage extends GetView<ProfileController> {
  const UserLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: TractorBackArrowBar(
          firstLabel: 'Tractor  User Log',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: const SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              UploadSelfieWidget(),
              UserLogFormWidget(),
            ],
          ),
        ));
  }
}
