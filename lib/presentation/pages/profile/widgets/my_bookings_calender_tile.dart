import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/util/util.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import '../../../../app/config/app_colors.dart';
import '../../../components/tractor_appbar.dart';
import 'booking_detail_page.dart';
import 'my_booking_tile_view.dart';

class MyBookingCalenderTileView extends GetView<ProfileController> {
  MyBookingCalenderTileView({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: 'My Bookings',
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),

      ),
      body: Column(
        children: [

          Expanded(
              child: Obx(() =>controller.selectedBookingList?.length!=0? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.selectedBookingList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.to(BookingDetailPageView(bookingId: controller.selectedBookingList![index].id ,));
                      },
                      child: MyBookingTileView(

                        bookingDetailModel: controller.selectedBookingList![index],
                      ),
                    );
                  }):noDataFoundWidget()))
        ],
      ),
    );
  }

 }
