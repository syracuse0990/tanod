import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import '../../../../app/config/app_colors.dart';

class EventCalenderView extends GetView<ProfileController> {
  DateTime? dateTime;
  Function(DateTime)? onTab;
  EventList? eventList;
  EventCalenderView({this.eventList,this.onTab, this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            color: AppColors.primary,
          ),
        ),
        CalendarCarousel<Event>(
          markedDatesMap: controller.eventList.value,
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
            if (onTab != null) {
              onTab!(date);
            }
            /* controller.dateTime.value = date;
        controller.dateTime.refresh();*/
          },
          weekDayBackgroundColor: AppColors.lightGray.withOpacity(0.07),
          weekDayPadding: EdgeInsets.all(10.r),
          weekdayTextStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black),

          daysHaveCircularBorder: false,
          showOnlyCurrentMonthDate: false,
          weekendTextStyle: TextStyle(
            color: AppColors.lightGray,
          ),
          thisMonthDayBorderColor: Colors.grey,
          weekFormat: false,
          //      firstDayOfWeek: 4,
          // markedDatesMap: _markedDateMap,
          height: Get.height * 0.5,
          selectedDateTime: dateTime ?? DateTime.now(),
          targetDateTime: dateTime ?? DateTime.now(),
          customGridViewPhysics: const BouncingScrollPhysics(),
          markedDateCustomShapeBorder:
              const CircleBorder(side: BorderSide(color: Colors.yellow)),
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
          selectedDayButtonColor: AppColors.primary,
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
        )
      ],
    );
  }
}
