import 'package:tanod_tractor/data/models/api_date_model.dart';

class MapModel {
  var statusCode;
  var status;
  var message;
  MapDataModel? data;

  MapModel({this.statusCode, this.status, this.message, this.data});

  MapModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MapDataModel.fromJson(json['data']) : null;
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

class MapDataModel {
  int? code;
  String? message;
  List<ApiDataModel>? result;
  var data;

  MapDataModel({this.code, this.message, this.result, this.data});

  MapDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <ApiDataModel>[];
      json['result'].forEach((v) {
        result!.add(new ApiDataModel.fromJson(v));
      });
    }
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['data'] = this.data;
    return data;
  }
}


