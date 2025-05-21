import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/admin_booking_model.dart';
import '../../../../../data/repositories/admin_booking_provider/impl/remote_admin_booking_provider.dart';
import '../../../../../data/repositories/admin_booking_provider/interface/iadmin_booking_repository.dart';

class AdminBookingController extends GetxController with BaseController {
  IAdminBookingRepository? iAdminBookingRepository;

  AdminBookingDataModel? adminBookingDataModel;

  RxList<BookingModel>? bookingList=<BookingModel>[].obs;
  ScrollController bookingController = ScrollController();
  RxInt currentPage = 1.obs;

  RxBool hideCalender=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

      addPaginationForDeviceList();
    });
    super.onInit();
  }


  //here we get list base on id
  hitApiToGetTractorBookingList({id}) async {
    showLoading();

    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = currentPage.value;
    map['id'] = id;

    await iAdminBookingRepository?.getAllTractorBookings(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        adminBookingDataModel=value.data;
        bookingList?.addAll(value.data?.bookings ?? []);
        bookingList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }



  hitApiToGetBookingList() async {
    showLoading();

    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = currentPage.value;

    await iAdminBookingRepository?.getAllAdminBookings(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        adminBookingDataModel=value.data;
        bookingList?.addAll(value.data?.bookings ?? []);
        bookingList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }


  addPaginationForDeviceList() {
    bookingController.addListener(() {
      if (bookingController.position.pixels ==
          bookingController.position.maxScrollExtent) {
        if (adminBookingDataModel != null &&
            int.parse(adminBookingDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    adminBookingDataModel?.totalPages?.toString() ?? "1")) {
          currentPage.value = currentPage.value + 1;
          currentPage.refresh();
          hitApiToGetBookingList();
        }
      }
    });
  }

  hitApiToChangeBookingStatus({id,status,index,reason}) async {
    showLoading();

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['status'] = status;
    map['reason'] = reason;

    await iAdminBookingRepository?.changeBookingStatus(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        bookingList?.value[index]=value.data!;
        bookingList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }


}