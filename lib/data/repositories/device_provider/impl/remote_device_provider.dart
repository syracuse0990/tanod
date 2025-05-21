
import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../models/add_device_model.dart';
import '../../../models/device_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/idevice_repository.dart';

class RemoteIDeviceProvider extends DioBaseProvider implements IDeviceRepository {

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
  Future<AddDeviceModel> addNewDevices({map}) async {
    // TODO: implement addNewDevices
    try {
      var response = await dio.post(APIEndpoint.createDeviceUrl,data: jsonEncode(map));
      return AddDeviceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddDeviceModel> getDeviceDetails({map}) async {
    // TODO: implement getDeviceDetails
    try {
      var response = await dio.get(APIEndpoint.deviceDetailsUrl,queryParameters: map);
      return AddDeviceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddDeviceModel> updateDevices({map}) async {
    // TODO: implement updateDevices
    try {
      var response = await dio.post(APIEndpoint.updateDeviceUrl,data: jsonEncode(map));
      return AddDeviceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> deleteDevice({map}) async {
    // TODO: implement deleteDevice
    try {
      var response = await dio.post(APIEndpoint.deleteDeviceUrl,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

}
