
import 'dart:convert';

import 'package:tanod_tractor/data/models/admin_user_model.dart';

import '../../../../app/util/util.dart';
import '../../../models/admin_user_detail_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/user_management_repository.dart';

class RemoteIUserManagementProvider extends DioBaseProvider implements IUserManagementRepository {

  @override
  Future<AdminUserModel> getAllUserList({map}) async {
    // TODO: implement getAllUserList
    try {
      var response = await dio.post(APIEndpoint.userList,data: jsonEncode(map));
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
      var response = await dio.post(APIEndpoint.deleteUser,data: jsonEncode(map));
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
      var response = await dio.post(APIEndpoint.userDetails,data: jsonEncode(map));
      return AdminUserDetailsModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  @override
  Future<AdminUserDetailsModel> updateUserDetails({formData}) async {
    // TODO: implement updateUserDetails
    try {
      var response = await dio.post(APIEndpoint.userUpdate,data: formData);
      return AdminUserDetailsModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }





}
