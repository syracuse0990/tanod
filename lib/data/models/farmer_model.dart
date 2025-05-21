import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class FarmerListModel {
  int? statusCode;
  String? status;
  String? message;
  FarmerDataModel? data;

  FarmerListModel({this.statusCode, this.status, this.message, this.data});

  FarmerListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new FarmerDataModel.fromJson(json['data']) : null;
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

class FarmerDataModel {
  List<FarmerModel>? farmers;
  var pageNo;
  var totalEntries;
  var totalPages;

  FarmerDataModel({this.farmers, this.pageNo, this.totalEntries, this.totalPages});

  FarmerDataModel.fromJson(Map<String, dynamic> json) {
    if (json['farmers'] != null) {
      farmers = <FarmerModel>[];
      json['farmers'].forEach((v) {
        farmers!.add(new FarmerModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmers != null) {
      data['farmers'] = this.farmers!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

