import 'dart:convert';

import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../models/admin_user_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';

class RemoteISubAdminProvider extends DioBaseProvider
    implements ISubAdminRepository {
  @override
  Future<AdminUserDetailsModel> createNewSubAdmin({map}) async {
    // TODO: implement createNewSubAdmin
    try {
      var response =
          await dio.post(APIEndpoint.createSubAdmin, data: jsonEncode(map));

      return AdminUserDetailsModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminUserModel> getAllUserList({map}) async {
    // TODO: implement getAllUserList
    try {
      var response =
          await dio.post(APIEndpoint.userList, data: jsonEncode(map));
      return AdminUserModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> deleteUser({map}) async {
    // TODO: implement updateDevices
    try {
      var response =
          await dio.post(APIEndpoint.deleteUser, data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminUserDetailsModel> userDetails({map}) async {
    // TODO: implement feedbackDetails
    try {
      var response =
          await dio.post(APIEndpoint.userDetails, data: jsonEncode(map));
      return AdminUserDetailsModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminUserDetailsModel> updateSubAdmin({map}) async {
    // TODO: implement updateSubAdmin
    try {
      var response =
          await dio.post(APIEndpoint.updateSubAdmin, data: jsonEncode(map));

      return AdminUserDetailsModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<TractorGroupModel> getAllGroupList({map}) async {
    // TODO: implement getAllGroupTractorList
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
            box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
      };
      var response =
          await dio.get(APIEndpoint.assignGroups, queryParameters: map);
      return TractorGroupModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AssignedModel> assignGroupToSubAdmin({map}) async {
    // TODO: implement assignGroupToSubAdmin
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
        box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
      };
      var response =
          await dio.post(APIEndpoint.assignGroupToSubAdmin, data: jsonEncode(map));
      return AssignedModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
}
