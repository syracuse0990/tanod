import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class DeviceDataModel {
  int? statusCode;
  String? status;
  String? message;
  DeviceDetailDataModel? data;

  DeviceDataModel({this.statusCode, this.status, this.message, this.data});

  DeviceDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DeviceDetailDataModel.fromJson(json['data']) : null;
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

class DeviceDetailDataModel {
  List<DevicesModel>? tractors;
  var pageNo;
  var totalEntries;
  var totalPages;

  DeviceDetailDataModel({this.tractors, this.pageNo, this.totalEntries, this.totalPages});

  DeviceDetailDataModel.fromJson(Map<String, dynamic> json) {
    if (json['devices'] != null) {
      tractors = <DevicesModel>[];
      json['devices'].forEach((v) {
        tractors!.add(new DevicesModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tractors != null) {
      data['tractors'] = this.tractors!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

