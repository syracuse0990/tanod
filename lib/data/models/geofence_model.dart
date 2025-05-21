import 'device_geofence_model.dart';

class GeoFenceModel {
  var statusCode;
  var  status;
  var message;
  GeoFenceDataModel? data;

  GeoFenceModel({this.statusCode, this.status, this.message, this.data});

  GeoFenceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GeoFenceDataModel.fromJson(json['data']) : null;
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

class GeoFenceDataModel {
  List<DeviceGeoFenceModel>? deviceGeoFence;
  var pageNo;
  var totalEntries;
  var totalPages;

  GeoFenceDataModel({this.deviceGeoFence, this.pageNo, this.totalEntries, this.totalPages});

  GeoFenceDataModel.fromJson(Map<String, dynamic> json) {
    if (json['device_geo_fence'] != null) {
      deviceGeoFence = <DeviceGeoFenceModel>[];
      json['device_geo_fence'].forEach((v) {
        deviceGeoFence!.add(new DeviceGeoFenceModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deviceGeoFence != null) {
      data['device_geo_fence'] =
          this.deviceGeoFence!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}


