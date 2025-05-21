import 'package:tanod_tractor/data/models/static_page_data_model.dart';

class AdminStaticDetailModel {
  int? statusCode;
  String? status;
  String? message;
  StaticPageDataModel? data;

  AdminStaticDetailModel({this.statusCode, this.status, this.message, this.data});

  AdminStaticDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new StaticPageDataModel.fromJson(json['data']) : null;
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




