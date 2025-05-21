
import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../models/add_update_issue_model.dart';
import '../../../models/issue_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/issue_repository.dart';

class RemoteIIssueProvider extends DioBaseProvider implements IIssueRepository {

  @override
  Future<IssueTypeModel> getAllIssueTypeList({map}) async {
    // TODO: implement getAllDeviceList
    try {
      var response = await dio.get(APIEndpoint.issueList,data: jsonEncode(map));
      return IssueTypeModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddUpdateIssueModel> addNewIssue({map}) async {
    // TODO: implement addNewDevices
    try {
      var response = await dio.post(APIEndpoint.createNewIssue,data: jsonEncode(map));
      return AddUpdateIssueModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }



  @override
  Future<AddUpdateIssueModel> updateNewIssue({map}) async {
    // TODO: implement updateDevices
    try {
      var response = await dio.post(APIEndpoint.updateIssueUrl,data: jsonEncode(map));
      return AddUpdateIssueModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> deleteIssueTitle({map}) async {
    // TODO: implement deleteDevice
    try {
      var response = await dio.post(APIEndpoint.deleteIssueTitle,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

}
