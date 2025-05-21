import 'dart:convert';
import 'dart:io';

import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/otp_model.dart';
import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/login_model.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/ilogin_repository.dart';

class RemoteILoginProvider extends DioBaseProvider implements ILoginRepository {
  @override
  Future<UserModel> loginApi({map}) async {
    // TODO: implement loginApi
    try {
      var response = await dio.post(APIEndpoint.login, data: jsonEncode(map));
      return UserModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> logoutApi({map}) async {
    // TODO: implement logoutApi
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
            box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
      };
      var response = await dio.post(
        APIEndpoint.logoutApiUrl,
      );
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> updateUserProfile({File? file}) async {
    // TODO: implement updateUserProfile
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
            box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
      };

      FormData formData = FormData.fromMap({
        'profile_photo_path': await MultipartFile.fromFile(file?.path ?? "",
            filename: file?.path.split('/').last)
      });

      var response =
          await dio.post(APIEndpoint.updateProfileUrl, data: formData);
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<SuccessModel> forgotPasswordApi({map}) async {
    // TODO: implement forgotPasswordApi
    try {
      var response =
          await dio.post(APIEndpoint.forgotPasswordUrl, data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<OtpModel> sendOtpApi({map}) async{
    // TODO: implement sendOtpApi
    try {
      var response = await dio.post(APIEndpoint.sendMobileOtp,data: jsonEncode(map));
      return OtpModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<UserModel> signUpApi({map})async {
    // TODO: implement signUpApi
    try {
      var response = await dio.post(APIEndpoint.signUp, data: jsonEncode(map));
      return UserModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
//verifyMobileOtp
  @override
  Future<UserModel> verifyMobileOtpApi({map}) async {
    // TODO: implement verifyMobileOtpApi
    try {
      var response = await dio.post(APIEndpoint.verifyMobileOtp, data: jsonEncode(map));
      return UserModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
}
