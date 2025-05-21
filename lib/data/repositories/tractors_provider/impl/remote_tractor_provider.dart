import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:tanod_tractor/data/models/file_exoort_model.dart';

import '../../../../app/util/export_file.dart';
import '../../../models/add_tractor_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';

class RemoteITractorProvider extends DioBaseProvider
    implements ITractorRepository {
  @override
  Future<TractorDataModel> getAllTractorList({map}) async {
    // TODO: implement getAllTractorList
    try {
      var response =
          await dio.post(APIEndpoint.tractorList, data: jsonEncode(map));
      return TractorDataModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddTractorModel> addNewTractor({map, List<File>? listImage}) async {
    // TODO: implement addNewDevices
    try {
      FormData formData = FormData.fromMap(map);
      listImage?.forEach((element) async {
        formData.files.addAll([
          MapEntry(
              "path[]",
              await MultipartFile.fromFile(element?.path ?? "",
                  filename: element?.path.split('/').last))
        ]);
      });

      var response =
          await dio.post(APIEndpoint.createTractorUrl, data: formData);
      return AddTractorModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddTractorModel> getTractorDetails({map}) async {
    // TODO: implement getDeviceDetails
    try {
      var response =
          await dio.get(APIEndpoint.tractorDetailsUrl, queryParameters: map);
      return AddTractorModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddTractorModel> downloadImportFile( ) async {
    // TODO: implement getDeviceDetails
    try {
      var response =
          await dio.get(APIEndpoint.downloadImportFile, );
      return AddTractorModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddTractorModel> uploadImportFile({formData}) async {
    // TODO: implement getDeviceDetails
    try {
      var response =
          await dio.post(APIEndpoint.uploadImportFile,data:  formData);
      return AddTractorModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AddTractorModel> updateTractor({map, List<File>? listImage}) async {
    // TODO: implement updateDevices
    try {
      FormData formData = FormData.fromMap(map);
      if (listImage != null && listImage.length != 0) {
        listImage?.forEach((element) async {
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

      var response =
          await dio.post(APIEndpoint.updateTractorUrl, data: formData);
      return AddTractorModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> deleteTractors({map}) async {
    // TODO: implement deleteDevice
    try {
      var response =
          await dio.post(APIEndpoint.deleteTractorsUrl, data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<FileExportModel> exportReports({map}) async{
    // TODO: implement exportTractorReports
    try {
      var response = await dio.get(APIEndpoint.exportTractorReport,queryParameters: map);
      return FileExportModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<FileExportModel> exportReportsFileExists({map}) async{
    // TODO: implement exportTractorReportsFileExists
    try {
      var response = await dio.get(APIEndpoint.exportTractorReportExits,queryParameters: map);
      return FileExportModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
}
