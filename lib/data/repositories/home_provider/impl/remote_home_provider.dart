
import 'dart:convert';

import 'package:tanod_tractor/data/models/user_booking_detail_model.dart';

import '../../../../app/util/util.dart';
import '../../../../main.dart';
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
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../../../providers/network/local_keys.dart';
import '../interface/ihome_repository.dart';

class RemoteIHomeProvider extends DioBaseProvider implements IHomeRepository {

  @override
  Future<TractorDataModel> getAllTractorList({map}) async {
    // TODO: implement getAllTractorList
    try {
      var response = await dio.post(APIEndpoint.tractorList,data: jsonEncode(map));
      return TractorDataModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<DeviceDataModel> getAllDeviceList({map}) async {
    // TODO: implement getAllDeviceList
    try {
      var response = await dio.post(APIEndpoint.deviceList,data: jsonEncode(map));
      return DeviceDataModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<TractorGroupModel> getAllGroupTractorList({map}) async {
    // TODO: implement getAllGroupTractorList
    try {
      dio.options.headers={
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.post(APIEndpoint.groupList,data: jsonEncode(map));
      return TractorGroupModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<BookingSuccessModel> createNewBooking({map}) async {
    // TODO: implement createNewBooking
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
        box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
      };
      var response = await dio.post(APIEndpoint.createBookingUrl,data: jsonEncode(map));
      return BookingSuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<MyBookingModel> bookingList({map}) async {
    // TODO: implement bookingList
    try {
      var response = await dio.post(APIEndpoint.bookingListUrl,data: jsonEncode(map));
      return MyBookingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<UserBookingDetailModel> userBookingDetailApi({map}) async {
    // TODO: implement userBookingDetailApi
    try {
      var response = await dio.post(APIEndpoint.bookingDetailUrl,data: jsonEncode(map));
      return UserBookingDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<FarmerListModel> farmerListApi({map}) async {
    // TODO: implement farmerListApi
    try {
      var response = await dio.post(APIEndpoint.farmerListUrl,data: jsonEncode(map));
      return FarmerListModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddEditGroupModel> createNewGroup({map}) async {
    // TODO: implement createNewGroup
    try {
      var response = await dio.post(APIEndpoint.createGroupUrl,data: jsonEncode(map));
      return AddEditGroupModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> deleteGroup({map}) async {
    // TODO: implement deleteGroup
    try {
      var response = await dio.post(APIEndpoint.deleteGroupUrl,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<GroupDetailModel> groupDetailApi({map}) async {
    // TODO: implement groupDetailApi
    try {
      var response = await dio.post(APIEndpoint.groupDetailUrl,data: jsonEncode(map));
      return GroupDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddEditGroupModel> updateGroup({map}) async {
    // TODO: implement updateGroup
    try {
      var response = await dio.post(APIEndpoint.updateGroupUrl,data: jsonEncode(map));
      return AddEditGroupModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<DeviceStateDataModel> getAllDeviceStateList({map}) async {
    // TODO: implement getAllDeviceStateList
    try {
      var response = await dio.get(APIEndpoint.getDeviceListState,queryParameters: map);
      return DeviceStateDataModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


}
