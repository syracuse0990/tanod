


import 'dart:io';

import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/login_model.dart';
import '../../../models/otp_model.dart';

abstract class ILoginRepository {

  Future<UserModel> loginApi({map}) {
    throw UnimplementedError();
  }

  Future<UserModel> signUpApi({map}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> logoutApi() {
    throw UnimplementedError();
  }


  Future<SuccessModel> updateUserProfile({File? file}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> forgotPasswordApi({map}) {
    throw UnimplementedError();
  }

  Future<OtpModel> sendOtpApi({map}) {
    throw UnimplementedError();
  }


  Future<UserModel> verifyMobileOtpApi({map}) {
    throw UnimplementedError();
  }



}

