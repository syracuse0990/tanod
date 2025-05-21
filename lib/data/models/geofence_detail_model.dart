import 'device_geofence_model.dart';

class GeoFenceDetailModel {
  int? statusCode;
  String? status;
  String? message;
  DeviceGeoFenceModel? data;

  GeoFenceDetailModel({this.statusCode, this.status, this.message, this.data});

  GeoFenceDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DeviceGeoFenceModel.fromJson(json['data']) : null;
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


