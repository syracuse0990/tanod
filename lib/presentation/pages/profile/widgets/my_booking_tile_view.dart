import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/util/util.dart';
import '../../../../data/models/my_booking_model.dart';
import '../../../components/span_text.dart';

class MyBookingTileView extends StatelessWidget {
  BookingDetailModel? bookingDetailModel;


  MyBookingTileView({this.bookingDetailModel,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTitleAndValue(
              title: 'Booking Number :- ',
              value: bookingDetailModel?.id?.toString() ?? ""),
          showTitleAndValue(
              title: 'Booking Date :- ',
              value: bookingDetailModel?.date?.toString() ?? ""),
          showTitleAndValue(
              title: 'Purpose :- ',
              value: bookingDetailModel?.purpose?.toString() ?? ""),

          showTitleAndValue(
              title: 'Reason :- ',
              value: bookingDetailModel?.reason?.toString() ?? ""),

          showTitleAndValue(
              title: 'State :- ',
              value: getBookingStateTitle(bookingDetailModel?.stateId ?? "")),
        ],
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

