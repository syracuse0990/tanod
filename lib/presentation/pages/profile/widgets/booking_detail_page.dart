import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/device_tile_view.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../data/repositories/profile_provider/impl/remote_profile_provider.dart';
import '../../../components/span_text.dart';
import '../../../components/tractor_appbar.dart';
import '../../../components/tractor_text.dart';
import '../../list/widgets/tractor_tile_view.dart';
import '../controller/profile_controller.dart';

class BookingDetailPageView extends GetView<ProfileController> {
  var bookingId;
  bool hideActionButton = false;

  BookingDetailPageView(
      {this.bookingId, this.hideActionButton = false, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

      controller.iProfileRepository = Get.put(RemoteIProfileProvider());
      Future.delayed(Duration(milliseconds: 500),(){controller.hitApiToBookingDetails(bookingId: bookingId);});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: 'Booking Details',
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(20.r),
                    child: showTitleAndValue(
                        title: 'Booking Number :- ',
                        value: controller.bookingDetail.value?.id?.toString() ??
                            "")),
                headerViewWidget(title: AppStrings.tractorDetails),
                TractorTileView(
                  borderRadius: 0.0,
                  margin: EdgeInsets.only(left: 15.w, right: 20.w),
                  tractorModel: controller.bookingDetail.value?.tractor,
                  isAdmin: hideActionButton,
                ),
                SizedBox(
                  height: 20.h,
                ),
                controller.bookingDetail.value?.device!=null? headerViewWidget(title: AppStrings.deviceDetails):SizedBox(),
                controller.bookingDetail.value?.device!=null? DeviceTileView(
                  borderRadius: 0.0,
                  margin: EdgeInsets.only(left: 15.w, right: 20.w),
                  devicesModel: controller.bookingDetail.value?.device,
                  isAdmin: hideActionButton,
                ):SizedBox()
              ],
            ),
          )),
    );
  }

  headerViewWidget({title}) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 20.w),
      padding: EdgeInsets.all(15.r),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
          color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value ?? "",
      firstTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
      lastTextStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[800],
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
    );
  }
}
