import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class TractorDataModel {
  int? statusCode;
  String? status;
  String? message;
  TractorDetailDataModel? data;

  TractorDataModel({this.statusCode, this.status, this.message, this.data});

  TractorDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new TractorDetailDataModel.fromJson(json['data']) : null;
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

class TractorDetailDataModel {
  List<TractorModel>? tractors;
  var pageNo;
  var totalEntries;
  var totalPages;

  TractorDetailDataModel({this.tractors, this.pageNo, this.totalEntries, this.totalPages});

  TractorDetailDataModel.fromJson(Map<String, dynamic> json) {
    if (json['tractors'] != null) {
      tractors = <TractorModel>[];
      json['tractors'].forEach((v) {
        tractors!.add(new TractorModel.fromJson(v));
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


