import 'package:tanod_tractor/presentation/pages/admin_modules/admin_bookings/views/rejected_booking_dialog.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import '../../../../app/util/export_file.dart';
import '../../../../data/models/admin_booking_model.dart';
import '../../admin_modules/admin_bookings/views/admin_booking_tile_view.dart';
import '../../profile/widgets/booking_detail_page.dart';
import '../controller/list_controller.dart';

class BookingListScreen extends GetView<ListController> {
  List<BookingModel>? bookingList = [];
  ScrollController? farmerController = ScrollController();
  bool? isSelected;

  Function(int)? onTab;

  BookingListScreen(
      {this.onTab,
      this.bookingList,
      this.isSelected = false,
      this.farmerController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return bookingList?.length != null && bookingList?.length != 0
        ? ListView.builder(
            itemCount: bookingList?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!Get.isRegistered<ProfileController>()) {
                    Get.lazyPut(() => ProfileController());
                  }
                  Get.to(BookingDetailPageView(
                    hideActionButton: true,
                    bookingId: bookingList![index].id,
                  ));
                },
                child: AdminBookingTileView(
                  onAccepted: () {
                    controller.hitApiToChangeBookingStatus(bookingList,
                        id: bookingList![index].id,
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
                        controller.hitApiToChangeBookingStatus(bookingList,
                            id: bookingList![index].id,
                            reason: data,
                            status: AppStrings.rejectedId,
                            index: index);
                      },
                    ));
                  },
                  tractorModel: bookingList![index],
                ),
              );
            })
        : noDataFoundWidget();
  }
}
