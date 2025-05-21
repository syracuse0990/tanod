
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:tanod_tractor/data/models/file_exoort_model.dart';

import '../../../../app/util/export_file.dart';
import '../../../../app/util/util.dart';
import '../../../models/add_update_feedback_model.dart';
import '../../../models/feedback_detail_model.dart';
import '../../../models/feedback_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/feedback_repository.dart';

class RemoteIFeedbackProvider extends DioBaseProvider implements IFeedbackRepository {

  @override
  Future<FeedbackModel> getAllFeedBackList({map}) async {
    // TODO: implement getAllDeviceList
    try {
      var response = await dio.get(APIEndpoint.feedbackList,data: jsonEncode(map));
      return FeedbackModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddUpdateFeedbackModel> addNewFeedback({map,List<File>? imageList}) async {
    // TODO: implement addNewDevices
    try {
      FormData formData = FormData.fromMap(map);
      imageList?.forEach((element) async {
        formData.files.addAll([
          MapEntry(
              "path[]",
              await MultipartFile.fromFile(element?.path ?? "",
                  filename: element?.path.split('/').last))
        ]);
      });
      var response = await dio.post(APIEndpoint.createFeedback,data: formData);
      return AddUpdateFeedbackModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }



  @override
  Future<AddUpdateFeedbackModel> updateFeedback({map,List<File>? imageList}) async {
    // TODO: implement updateDevices
    try {
      FormData formData = FormData.fromMap(map);
      if (imageList != null && imageList.length != 0) {
        imageList?.forEach((element) async {
          if (element.path.startsWith("http")) {
            Uint8List bytes =
            (await NetworkAssetBundle(Uri.parse(element?.path ?? ""))
                .load(element?.path ?? ""))
                .buffer
                .asUint8List();
            formData.files.addAll([
              MapEntry(
                  "path[]",
                  await MultipartFile.fromBytes(bytes,
                      filename: element?.path.split('/').last))
            ]);
          } else {
            formData.files.addAll([
              MapEntry(
                  "path[]",
                  await MultipartFile.fromFile(element?.path ?? "",
                      filename: element?.path.split('/').last))
            ]);
          }
        });
      }

      var response = await dio.post(APIEndpoint.updateFeedback,data: formData);
      return AddUpdateFeedbackModel.fromJson(response.data);
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

  @override
  Future<SuccessModel> addFarmerConclusion({map}) async {
    // TODO: implement addFarmerConclusion
    try {
      var response = await dio.post(APIEndpoint.addConclusion,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminFeedbackDetailModel> feedbackDetails({map}) async {
    // TODO: implement feedbackDetails
    try {
      var response = await dio.get(APIEndpoint.feedbackDetails,queryParameters: map);
      return AdminFeedbackDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }



}
