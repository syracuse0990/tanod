import 'package:tanod_tractor/data/models/device_track_model.dart';
import 'package:tanod_tractor/data/models/device_tracking_model.dart';
import 'package:tanod_tractor/data/models/home_device_model.dart';
import 'package:tanod_tractor/data/models/map_api_data.dart';

import '../../../../app/util/export_file.dart';
import '../../../models/admin_booking_model.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/imap_repository.dart';

class RemoteIMapProvider extends DioBaseProvider implements IMapRepository {
  @override
  Future<AdminBookingModel> getAllAcceptedBookings() async {
    // TODO: implement getAllAcceptedBookings
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.get(APIEndpoint.acceptedBookingList);
      return AdminBookingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<MapModel> getTractorLatLng({map}) async {
    // TODO: implement getTractorLatLng
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.post(APIEndpoint.deviceLocation, data: map);
      return MapModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminBookingModel> getAllDeviceBasedList({map}) async {
    // TODO: implement getAllDeviceBasedList
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response =
          await dio.get(APIEndpoint.deviceBasedBooking, queryParameters: map);
      return AdminBookingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<DeviceTrackingModel> getDeviceTrackingData({map}) async {
    // TODO: implement getDeviceTrackingData
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.post(APIEndpoint.deviceTrackUrl, data: map);
      return DeviceTrackingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<DeviceTrackingModel> updateLatLng({map}) async {
    // TODO: implement updateLatLng
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.post(APIEndpoint.updatedLatLngUrl, data: map);
      return DeviceTrackingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<HomeDeviceModel> getAllHomeDevices() async {
    // TODO: implement getAllHomeDevices
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.get(APIEndpoint.homeDeviceAPI,);
      return HomeDeviceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<DeviceTrackModel> saveDeviceTrack({map}) async {
    // TODO: implement saveDeviceTrack
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.post(APIEndpoint.deviceTrackApi,data: FormData.fromMap(map));
      return DeviceTrackModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
}
