import '../../app/util/export_file.dart';

class AddDeviceModel {
  int? statusCode;
  String? status;
  String? message;
  DevicesModel?  devicesModel;


  AddDeviceModel({this.statusCode, this.status, this.message,this.devicesModel});

  AddDeviceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    devicesModel = json['data'] != null ? new DevicesModel.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.devicesModel != null) {
      data['data'] = this.devicesModel!.toJson();
    }

    return data;
  }
}
