import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/admin_booking_model.dart';
import '../../../../../data/models/meeting_model.dart';
import '../../../../../data/repositories/admin_booking_provider/impl/remote_admin_booking_provider.dart';
import '../../../../../data/repositories/admin_booking_provider/interface/iadmin_booking_repository.dart';
import '../../admin_bookings/controller/admin_booking_controller.dart';
import '../views/calender_tractor_list_view.dart';

class TractorCalenderController extends GetxController with BaseController {
  IAdminBookingRepository? iAdminBookingRepository;

  RxString selectTractor = "Select Tractor".obs;
  AdminBookingDataModel? adminBookingDataModel;
  RxList<BookingModel>? bookingList = <BookingModel>[].obs;
  RxList<BookingModel> selectedBooking = <BookingModel>[].obs;
  RxList<Meeting>? meetingList = <Meeting>[].obs;

  var tractorController = ScrollController();
  RxList<TractorModel>? tractorList = <TractorModel>[].obs;
  TractorDetailDataModel? tractorDetailDataModel;

  ITractorRepository? iTractorRepository;
  Map<String, dynamic> bookingMap = {};
  RxInt tractorPage = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iAdminBookingRepository = Get.put(RemoteIAdminBookingProvider());
      iTractorRepository = Get.put(RemoteITractorProvider());
      bookingList?.clear();
      hitApiToGetBookingList();
      tractorList?.clear();
      hitApiToGetTractorList();
      addPaginationOnTractorList();
    });
    super.onInit();
  }

  hitApiToGetBookingList() async {
    showLoading();


    bookingMap['records_per_page'] = 10;
    bookingMap['page_no'] = 1;

    await iAdminBookingRepository?.getAllAdminBookings(map: bookingMap).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        adminBookingDataModel = value.data;
        bookingList?.addAll(value.data?.bookings ?? []);
        setDataOnCalender();
        bookingList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  setDataOnCalender() {
    meetingList?.clear();
    if (bookingList != null && bookingList?.length != 0) {
      bookingList?.forEach((element) {
        if(element?.date!=null){
          if (element.stateId?.toString() == AppStrings.activeId?.toString()) {

            meetingList?.add(Meeting(
                element?.createdBy?.email ?? "",
                DateTime.parse(element?.date),
                DateTime.parse(element?.date),
                Colors.blue,
                false));
          } else if (element.stateId?.toString() ==
              AppStrings.acceptedId?.toString()) {
            meetingList?.add(Meeting(
                element?.createdBy?.email ?? "",
                DateTime.parse(element?.date),
                DateTime.parse(element?.date),
                AppColors.primary,
                false));
          } else {
            meetingList?.add(Meeting(
                element?.createdBy?.email ?? "",
                DateTime.parse(element?.date),
                DateTime.parse(element?.date),
                AppColors.red,
                false));
          }
        }

      });
    }
    meetingList;
    meetingList?.refresh();
  }

  getListBasedOnSelection(DateTime? selectedDate) {
    if (bookingList != null && bookingList?.length != 0) {
      String formattedDate =
          DateFormat("yyyy-MM-dd").format(selectedDate ?? DateTime.now());
      selectedBooking.clear();
      selectedBooking.value = bookingList?.value
              .where((element) => element?.date == formattedDate)
              .toList() ??
          [];
      Get.to(CalenderTractorListView(
        bookingList: selectedBooking.value,
      ));
    }
  }

  hitApiToBookingStatus({id, status, index,reason}) async {
    showLoading();

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['status'] = status;
    map['reason'] = reason;

    await iAdminBookingRepository?.changeBookingStatus(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        selectedBooking?.value[index] = value.data!;
        selectedBooking?.refresh();

        Get.lazyPut(() => AdminBookingController());
        Get.find<AdminBookingController>().bookingList?.clear();
        Get.find<AdminBookingController>().hitApiToGetBookingList();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetTractorList() async {
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractorPage.value;
    map['allData'] = 1;

    await iTractorRepository?.getAllTractorList(map: map).then((value) {
      if (value != null && value.data != null) {
        tractorDetailDataModel = value.data;
        tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
        tractorList?.refresh();
        print("check list ${tractorList?.length}");
      }
    }).onError((error, stackTrace) {
      showToast(message: error?.toString());
    });
  }

  addPaginationOnTractorList() {
    tractorController.addListener(() {
      if (tractorController.position.pixels ==
          tractorController.position.maxScrollExtent) {
        if (tractorDetailDataModel != null &&
            int.parse(tractorDetailDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    tractorDetailDataModel?.totalPages?.toString() ?? "1")) {
          tractorPage.value = tractorPage.value + 1;
          tractorPage.refresh();
          hitApiToGetTractorList();
        }
      }
    });
  }


}
