import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class DeviceStateDataModel {
  int? statusCode;
  String? status;
  String? message;
  List<DevicesModel>? data;

  DeviceStateDataModel({this.statusCode, this.status, this.message, this.data});

  DeviceStateDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DevicesModel>[];
      json['data'].forEach((v) {
        data!.add(new DevicesModel.fromJson(v));
      });
    }  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


