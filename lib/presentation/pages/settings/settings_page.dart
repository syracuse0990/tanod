import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/pages/settings/controller/settings_controller.dart';
import 'package:tanod_tractor/presentation/pages/settings/widgets/settings_tile_widget.dart';

import '../../components/span_text.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: TractorBackArrowBar(
          firstLabel: 'Settings',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
          decoration: BoxDecoration(color: AppColors.white),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            ...List.generate(controller.settingsTiles.length, (index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                  } else if (index == 1) {
                  } else if (index == 2) {
                  } else if (index == 3) {
                  } else if (index == 4) {
                  } else if (index == 5) {
                    //
                  } else if (index == 6) {
                    //
                  } else if (index == 7) {
                    //
                  }
                },
                child: SettingsTilesWidget(
                  index: index,
                ),
              );
            }),
            const Spacer(),
            const TractorSpanText(
              firstLabel: '© 2023 |',
              secondLabel: ' TanodTractor',
            )
          ]),
        ));
  }
}
