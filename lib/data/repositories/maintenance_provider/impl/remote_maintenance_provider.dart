
import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../models/add_update_maintenance_model.dart';
import '../../../models/maintenance_model.dart';
import '../../../models/success_model.dart';
import '../../../models/tratcor_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/maintenance_repository.dart';

class RemoteIMaintenanceProvider extends DioBaseProvider implements IMaintenanceRepository {

  @override
  Future<MaintenanceModel> getAllMaintenanceList({map}) async {
    // TODO: implement getAllMaintenanceList
    try {
      var response = await dio.get(APIEndpoint.maintenanceList,data: jsonEncode(map));
      return MaintenanceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<MaintenanceUpdateAddModel> createNewMaintenance({map}) async {
    // TODO: implement createNewMaintenance
    try {
      var response = await dio.post(APIEndpoint.createMaintenance,data: jsonEncode(map));
      return MaintenanceUpdateAddModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<MaintenanceUpdateAddModel> updateMaintenance({map}) async {
    // TODO: implement deleteDevice
    try {
      var response = await dio.post(APIEndpoint.updateMaintenance,data: jsonEncode(map));
      return MaintenanceUpdateAddModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<SuccessModel> deleteMaintenance({map}) async {
    // TODO: implement updateDevices
    try {
      var response = await dio.post(APIEndpoint.deleteMaintenance,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<SuccessModel> changeMaintenanceState({map}) async {
    // TODO: implement addFarmerConclusion
    try {
      var response = await dio.get(APIEndpoint.changeMaintenanceState,queryParameters: map);
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<MaintenanceUpdateAddModel> maintenanceDetails({map}) async {
    // TODO: implement feedbackDetails
    try {
      var response = await dio.get(APIEndpoint.maintenanceDetails,queryParameters: map);
      return MaintenanceUpdateAddModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> addMaintenanceConclusion({map}) async {
    // TODO: implement addMaintenanceConclusion
    try {
      var response = await dio.post(APIEndpoint.addMaintenanceConclusion,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<TractorDataModel> getMaintenanceTractorList({map}) async {
    // TODO: implement getMaintenanceTractorList
    try {
      var response = await dio.get(APIEndpoint.maintenanceTractorList,queryParameters: map);
      return TractorDataModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<MaintenanceModel> applyFilterOnMaintenance({map}) async {
    // TODO: implement applyFilterOnMaintenance
    try {
      var response = await dio.get(APIEndpoint.maintenanceFilter,queryParameters: map);
      return MaintenanceModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

}
