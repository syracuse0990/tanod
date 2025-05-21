
import 'dart:convert';

import 'package:tanod_tractor/data/models/geofence_detail_model.dart';

import '../../../../app/util/util.dart';
import '../../../models/geofence_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/geofence_repository.dart';

class RemoteIGeoFenceProvider extends DioBaseProvider implements IGeoFenceRepository {

  @override
  Future<GeoFenceModel> getAllGeofenceList({map}) async {
    // TODO: implement getAllMaintenanceList
    try {
      var response = await dio.get(APIEndpoint.geoFenceList,data: jsonEncode(map));
      return GeoFenceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<SuccessModel> deleteGeoFence({map}) async {
    // TODO: implement deleteGeoFence
    try {
      var response = await dio.post(APIEndpoint.deleteGeoFence,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<GeoFenceDetailModel> viewGeoFenceDetails({map}) async {
    // TODO: implement viewGeoFenceDetails
    try {
      var response = await dio.get(APIEndpoint.detailGeoFence,queryParameters: map);
      return GeoFenceDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<GeoFenceDetailModel> createNewGeoFence({map}) async {
    // TODO: implement createNewGeoFence
    try {
      var response = await dio.post(APIEndpoint.createGeoFence,data: jsonEncode(map));
      return GeoFenceDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<GeoFenceDetailModel> updateGeoFence({map}) async {
    // TODO: implement updateGeoFence
    try {
      var response = await dio.post(APIEndpoint.updateGeoFence,data: jsonEncode(map));
      return GeoFenceDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<GeoFenceDetailModel> getFenceByDeviceImei({map}) async {
    // TODO: implement getFenceByDeviceImei
    try {
      var response = await dio.get(APIEndpoint.geoFenceImeiData,queryParameters:map);
      return GeoFenceDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

}