import 'package:tanod_tractor/data/models/user_model.dart';

class OtpModel {
  int? statusCode;
  String? status;
  String? message;
  UserDataModel? data;

  OtpModel({this.statusCode, this.status, this.message, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
