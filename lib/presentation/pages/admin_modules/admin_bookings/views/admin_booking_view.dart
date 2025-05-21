import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/repositories/admin_booking_provider/impl/remote_admin_booking_provider.dart';
import '../../../profile/widgets/booking_detail_page.dart';
import '../controller/admin_booking_controller.dart';
import 'admin_booking_tile_view.dart';
import 'rejected_booking_dialog.dart';

//
class AdminBookingView extends GetView<AdminBookingController> {
  Map<String, dynamic>? arguments;

  AdminBookingView({this.arguments}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.iAdminBookingRepository =
          Get.put(RemoteIAdminBookingProvider());
      controller.bookingList?.clear();
      if (arguments != null && arguments?.isNotEmpty == true) {
        if (arguments?.containsKey("hideCalender") == true) {
          controller.hideCalender.value = true;
          controller.hideCalender.refresh();
        }
        if (arguments!['id'] != null) {
          controller.hitApiToGetTractorBookingList(id: arguments!['id']);
        } else {
          controller.hitApiToGetBookingList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TractorBackArrowBar(
          firstLabel: AppStrings.tractorsBooking,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts
                .plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          actions: [
            Obx(() =>
            controller.hideCalender.isTrue
                ? SizedBox()
                : GestureDetector(
              child: calenderView(),
              onTap: () {
                Get.toNamed(RoutePage.tractorCalenderView);
              },
            ))
          ]),
      body: Column(
        children: [
          Obx(() =>
          controller.bookingList?.length != 0
              ? Expanded(
              child: ListView.builder(
                  controller: controller.bookingController,
                  itemCount: controller.bookingList?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(BookingDetailPageView(
                          hideActionButton: true,
                          bookingId: controller.bookingList![index].id,
                        ));
                      },
                      child: AdminBookingTileView(
                        onAccepted: () {
                          controller.hitApiToChangeBookingStatus(
                              id: controller.bookingList![index].id,
                              status: AppStrings.acceptedId,
                              index: index);
                        },
                        onRejected: () {
                          Get.dialog(RejectedReasonDialog(
                            reasonController: TextEditingController(),
                            onSubmitClick: (String? data) {
                              if (data?.isEmpty == true) {
                                showToast(message: "Please enter your reason");
                                return;
                              }
                              Get.back();
                              controller.hitApiToChangeBookingStatus(
                                  id: controller.bookingList![index].id,
                                  status: AppStrings.rejectedId,
                                  reason: data,
                                  index: index);
                            },
                          ));
                        },
                        tractorModel: controller.bookingList![index],
                      ),
                    );
                  }))
              : noDataFoundWidget())
        ],
      ),
    );
  }
}
