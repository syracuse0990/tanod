import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/components/tractor_button.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';
import 'package:tanod_tractor/presentation/pages/reservation/controller/reservation_controller.dart';
import 'package:tanod_tractor/presentation/pages/reservation/tractor_view.dart';
import 'package:tanod_tractor/presentation/pages/reservation/widgets/common_tractor_device_tile.dart';

import '../../../data/models/tractor_group_model.dart';
import 'device_view.dart';
import 'widgets/reservation_checkbox_widget.dart';

class ReservationPage extends GetView<ReservationController> {
  // const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: 'Reserve Tractor',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TractorText(
                      textAlign: TextAlign.center,
                      text: 'Date',
                      fontSize: 16.sp,
                    ),
                    SvgPicture.asset(AppSvgAssets.calendar)
                  ],
                ),
                AddSpace.vertical(12.h),
                Row(
                  children: [
                    const ReservationCheckBoxWidget(
                      label: 'AM',
                      value: false,
                    ),
                    AddSpace.horizontal(14.w),
                    const ReservationCheckBoxWidget(
                      label: 'PM',
                      value: false,
                    ),
                    AddSpace.horizontal(14.w),
                    const ReservationCheckBoxWidget(
                      label: 'Whole day',
                      value: true,
                    ),
                  ],
                ),
                AddSpace.vertical(30.h),
                const TractorText(text: 'Purpose of Use'),
                AddSpace.vertical(20.h),
                SizedBox(
                  height: Get.height * 0.13,
                  child: TextField(
                    controller: controller.purposeDetailController,
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
                        fontFamily: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500)
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
                AddSpace.vertical(20.h),
                const TractorText(text: 'Select Tractor'),
                AddSpace.vertical(20.h),
                Obx(
                  () => CommonTractorTileView(
                      title: controller.selectTractor.value,
                      onTab: () async {
                        TractorModel? data = await Get.to(TractorView());

                        if (data != null) {
                          controller.selectTractor.value =
                              data?.idNo?.toString() ?? "";
                          controller.update();
                        }
                      }),
                ),
                AddSpace.vertical(20.h),
                const TractorText(text: 'Select Device'),
                AddSpace.vertical(20.h),
                Obx(
                  () => CommonTractorTileView(
                      title: controller.selectDevice.value,
                      onTab: () async {
                        DevicesModel? deviceModel = await Get.to(DeviceView());
                        if (deviceModel != null) {
                          controller.selectDevice.value =
                              deviceModel.deviceName ?? "";
                          controller.update();
                        }
                      }),
                ),
                AddSpace.vertical(20.h),
                Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                    )),
                    Container(
                      height: Get.height * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r)),
                        color: AppColors.primary,
                      ),
                    ),
                    Obx(() => CalendarCarousel<Event>(
                          showHeaderButton: true,
                          showHeader: true,
                          headerTextStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),

                          leftButtonIcon: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.primary,
                              size: 18.r,
                            ),
                          ),
                          rightButtonIcon: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primary,
                              size: 18.r,
                            ),
                          ),
                          todayBorderColor: Colors.green,
                          onDayPressed: (date, events) {
                            controller.dateTime.value = date;
                            controller.dateTime.refresh();
                          },
                          weekDayBackgroundColor:
                              AppColors.lightGray.withOpacity(0.07),
                          weekDayPadding: EdgeInsets.all(10.r),
                          weekdayTextStyle: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black),

                          daysHaveCircularBorder: false,
                          showOnlyCurrentMonthDate: true,
                          weekendTextStyle: TextStyle(
                            color: AppColors.lightGray,
                          ),
                          thisMonthDayBorderColor: Colors.grey,
                          weekFormat: false,

                          height: Get.height * 0.436,
                          selectedDateTime:
                              controller.dateTime.value ?? DateTime.now(),
                          targetDateTime:
                              controller.dateTime.value ?? DateTime.now(),
                          customGridViewPhysics: const BouncingScrollPhysics(),
                          markedDateCustomShapeBorder: const CircleBorder(
                              side: BorderSide(color: Colors.yellow)),
                          markedDateCustomTextStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                          todayTextStyle: TextStyle(
                            color: AppColors.white,
                          ),

                          todayButtonColor: AppColors.primary,
                          selectedDayTextStyle: TextStyle(
                            color: AppColors.white,
                          ),
                          prevDaysTextStyle: TextStyle(
                            fontSize: 16,
                            color: AppColors.lightGray,
                          ),
                          selectedDayBorderColor: AppColors.lightGray,
                          selectedDayButtonColor: AppColors.primary.withOpacity(0.3),
                          markedDateIconBorderColor: AppColors.white,

                          inactiveDaysTextStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),

                          onCalendarChanged: (DateTime date) {
                            print('onCalendarChanged $date');
                          },
                          onDayLongPressed: (DateTime date) {
                            print('long pressed date $date');
                          },
                        )),
                  ],
                ),
                AddSpace.vertical(15.w),

                TractorButton(
                  onTap: () {
                    controller.hitApiToAddSlots();
                  },
                  text: 'Submit',
                ),
                AddSpace.vertical(20.h),
              ],
            ),
          ),
        ));
  }


}
