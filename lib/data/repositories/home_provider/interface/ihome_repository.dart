


import '../../../models/add_edit_group_model.dart';
import '../../../models/device_model.dart';
import '../../../models/device_state_model.dart';
import '../../../models/farmer_model.dart';
import '../../../models/group_detail_model.dart';
import '../../../models/my_booking_model.dart';
import '../../../models/success_model.dart';
import '../../../models/suces_model.dart';
import '../../../models/tractor_group_model.dart';
import '../../../models/tratcor_model.dart';
import '../../../models/user_booking_detail_model.dart';

abstract class IHomeRepository {

  Future<TractorGroupModel> getAllGroupTractorList({map}) {
    throw UnimplementedError();
  }

  Future<TractorDataModel> getAllTractorList({map}) {
    throw UnimplementedError();
  }


  Future<DeviceDataModel> getAllDeviceList({map}) {
    throw UnimplementedError();
  }


  Future<BookingSuccessModel> createNewBooking({map}) {
    throw UnimplementedError();
  }


  Future<MyBookingModel> bookingList({map}) {
    throw UnimplementedError();
  }

  Future<UserBookingDetailModel> userBookingDetailApi({map}) {
    throw UnimplementedError();
  }


  Future<FarmerListModel> farmerListApi({map}) {
    throw UnimplementedError();
  }

  Future<AddEditGroupModel> createNewGroup({map}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> deleteGroup({map}) {
    throw UnimplementedError();
  }


  Future<AddEditGroupModel> updateGroup({map}) {
    throw UnimplementedError();
  }

  Future<GroupDetailModel> groupDetailApi({map}) {
    throw UnimplementedError();
  }


  Future<DeviceStateDataModel> getAllDeviceStateList({map}) {
    throw UnimplementedError();
  }




}

