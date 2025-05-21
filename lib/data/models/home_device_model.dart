import 'package:tanod_tractor/data/models/api_date_model.dart';

class HomeDeviceModel {
  var statusCode;
  String? status;
  String? message;
  List<HomeDeviceDataModel>? data;

  HomeDeviceModel({this.statusCode, this.status, this.message, this.data});

  HomeDeviceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HomeDeviceDataModel>[];
      json['data'].forEach((v) {
        data!.add(new HomeDeviceDataModel.fromJson(v));
      });
    }
  }

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
class HomeDeviceDataModel {
  var id;
  var imeiNo;
  var deviceModal;
  var deviceName;
  var subscriptionExpiration;
  var expirationDate;
  var sim;
  ApiDataModel? apiData;
  var tractor;
  var user;
  var group;
  var diff;
  var minutes;

  HomeDeviceDataModel(
      {this.id,
        this.imeiNo,
        this.deviceModal,
        this.deviceName,
        this.subscriptionExpiration,
        this.expirationDate,
        this.sim,
        this.apiData,
        this.tractor,
        this.user,
        this.group,
        this.diff,
        this.minutes});

  HomeDeviceDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imeiNo = json['imei_no'];
    deviceModal = json['device_modal'];
    deviceName = json['device_name'];
    subscriptionExpiration = json['subscription_expiration'];
    expirationDate = json['expiration_date'];
    sim = json['sim'];
    apiData =
    json['apiData'] != null ? new ApiDataModel.fromJson(json['apiData']) : null;
    tractor = json['tractor'];
    user = json['user'];
    group = json['group'];
    diff = json['diff'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imei_no'] = this.imeiNo;
    data['device_modal'] = this.deviceModal;
    data['device_name'] = this.deviceName;
    data['subscription_expiration'] = this.subscriptionExpiration;
    data['expiration_date'] = this.expirationDate;
    data['sim'] = this.sim;
    if (this.apiData != null) {
      data['apiData'] = this.apiData!.toJson();
    }
    data['tractor'] = this.tractor;
    data['user'] = this.user;
    data['group'] = this.group;
    data['diff'] = this.diff;
    data['minutes'] = this.minutes;
    return data;
  }
}