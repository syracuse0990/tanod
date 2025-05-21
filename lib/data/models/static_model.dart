import 'package:tanod_tractor/data/models/static_page_data_model.dart';

class StaticPageModel {
  int? statusCode;
  String? status;
  String? message;
  StaticDataModel? data;

  StaticPageModel({this.statusCode, this.status, this.message, this.data});

  StaticPageModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new StaticDataModel.fromJson(json['data']) : null;
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

class StaticDataModel {
  List<StaticPageDataModel>? pages;

  StaticDataModel({this.pages});

  StaticDataModel.fromJson(Map<String, dynamic> json) {
    if (json['pages'] != null) {
      pages = <StaticPageDataModel>[];
      json['pages'].forEach((v) {
        pages!.add(new StaticPageDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pages != null) {
      data['pages'] = this.pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



