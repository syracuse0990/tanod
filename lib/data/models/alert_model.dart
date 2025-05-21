import 'alert_detail_model.dart';

class AlertModel {
  int? statusCode;
  String? status;
  String? message;
  AlertDataModel? data;

  AlertModel({this.statusCode, this.status, this.message, this.data});

  AlertModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AlertDataModel.fromJson(json['data']) : null;
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

class AlertDataModel {
  List<AlertDetailModel>? alerts;
  var pageNo;
  var totalEntries;
  var totalPages;

  AlertDataModel({this.alerts, this.pageNo, this.totalEntries, this.totalPages});

  AlertDataModel.fromJson(Map<String, dynamic> json) {
    if (json['alerts'] != null) {
      alerts = <AlertDetailModel>[];
      json['alerts'].forEach((v) {
        alerts!.add(new AlertDetailModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alerts != null) {
      data['alerts'] = this.alerts!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}


