import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_state_handler/page_state_handler.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_button.dart';
import 'package:tanod_tractor/presentation/pages/geofence/controller/geofence_controller.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/app_assets.dart';
import '../../components/tractor_appbar.dart';
import '../../components/tractor_text.dart';
import 'widgets/geofence_tile_widget.dart';

class GeoFencePage extends GetView<GeoFenceController> {
  const GeoFencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: 'Geo Fence',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          actions: [
            Bounce(
              duration: const Duration(milliseconds: 180),
              onPressed: () {},
              child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: AppColors.white,
                  child: SvgPicture.asset(
                    AppSvgAssets.addMenu,
                    height: 13.h,
                  )),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.w),
                  height: Get.height * 0.05,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppSvgAssets.dropDown),
                      AddSpace.horizontal(10.w),
                      TractorText(
                        textAlign: TextAlign.start,
                        text: 'Default Group',
                        fontSize: 14.sp,
                        color: AppColors.lightGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageStateHandler(
                    controller: controller.pageStateController,
                    onRefresh: () => Future(() => controller.retry()),
                    // onRetry: () => controller.fetchgeofence(),
                    rColor: AppColors.primary,
                    loading: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.h, bottom: 120.h),
                        itemCount: 20,
                        itemBuilder: (c, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: const GeoFenceTileWidget(),
                          );
                        }),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(27.r),
                child: TractorButton(
                  height: 60.h,
                  text: 'Add Geofence',
                ),
              ),
            )
          ],
        ));
  }
}
