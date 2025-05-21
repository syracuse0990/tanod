import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/admin_booking_model.dart';
import '../../admin_bookings/views/admin_booking_tile_view.dart';
import '../../admin_bookings/views/rejected_booking_dialog.dart';
import '../controller/calender_view_controller.dart';

class CalenderTractorListView extends GetView<TractorCalenderController> {
  List<BookingModel>? bookingList =[];
  CalenderTractorListView({this.bookingList,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          controller.bookingList?.clear();
          controller.hitApiToGetBookingList();
          Get.back();
        },
        firstLabel: AppStrings.tractorsBooking,
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

       Obx(() =>  controller.selectedBooking?.length != 0
           ? Expanded(
           child: ListView.builder(
             ///controller: controller.bookingController,
               itemCount:  controller.selectedBooking?.length ?? 0,
               shrinkWrap: true,
               itemBuilder: (context, index) {
                 return AdminBookingTileView(
                   onAccepted: () {
                     controller.  hitApiToBookingStatus(
                         id:  controller.selectedBooking![index].id,
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
                         controller. hitApiToBookingStatus(
                             id:  controller.selectedBooking![index].id,
                             status: AppStrings.rejectedId,
                             reason: data,
                             index: index);
                       },
                     ));

                   },
                   tractorModel:  controller.selectedBooking![index],
                 );
               }))
           : noDataFoundWidget())
        ],
      ),
    );
  }
}
