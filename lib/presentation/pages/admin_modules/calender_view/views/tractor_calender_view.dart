import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/meeting_data_source.dart';
import '../controller/calender_view_controller.dart';
import 'admin_tractor_view.dart';

class TractorCalenderView extends GetView<TractorCalenderController> {
  const TractorCalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: AppStrings.calenderView,
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
            Obx(() => Padding(
                  padding: EdgeInsets.all(15.r),
                  child: CommonTractorTileView(
                      title: controller.selectTractor.value,
                      onTab: () async {
                        var data = await Get.to(() => AdminTractorView());
                        if (data != null) {
                          controller.selectTractor.value = controller.tractorList ?.where( (element) => element?.isSelected == true)  .toList()  ?.map((element) => element?.noPlate).toList()?.join(",") ?? "";

                          var id=  controller.tractorList ?.where( (element) => element?.isSelected == true)  .toList()  ?.map((element) => element?.id).toList()?.join(",") ?? "";

                          controller.update();
                          controller.bookingList?.clear();
                          controller. bookingMap['tractor_id'] = id;
                           controller.hitApiToGetBookingList();                        }
                      }),
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.r),
                child: Obx(() => controller.meetingList?.length != 0
                    ? SfCalendar(
                        onSelectionChanged: (details) {
                          controller.getListBasedOnSelection(details?.date);
                        },
                        view: CalendarView.month,
                        headerStyle: CalendarHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800),
                            backgroundColor: AppColors.primary),
                        onTap: (CalendarTapDetails? details) {
                          print("check all infor ${details?.appointments}");
                        },
                        dataSource:
                            MeetingDataSource(controller.meetingList ?? []),
                        monthViewSettings: MonthViewSettings(
                            appointmentDisplayMode:
                                MonthAppointmentDisplayMode.appointment),
                      )
                    : SfCalendar(
                        onSelectionChanged: (details) {
                          controller.getListBasedOnSelection(details?.date);
                        },
                        view: CalendarView.month,
                        headerStyle: CalendarHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w800),
                            backgroundColor: AppColors.primary),
                        dataSource:
                            MeetingDataSource(controller.meetingList ?? []),
                        monthViewSettings: MonthViewSettings(
                            appointmentDisplayMode:
                                MonthAppointmentDisplayMode.appointment),
                      )),
              ),
            ),
            SizedBox(height: 20.h,)
          ],
        ));
  }
}
