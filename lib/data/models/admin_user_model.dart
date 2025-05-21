import 'package:tanod_tractor/data/models/user_model.dart';

class AdminUserModel {
  int? statusCode;
  String? status;
  String? message;
  AdminUserDataModel? data;

  AdminUserModel({this.statusCode, this.status, this.message, this.data});

  AdminUserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AdminUserDataModel.fromJson(json['data']) : null;
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
class AdminUserDataModel {
  List<UserDataModel>? farmers;
  var pageNo;
  var totalEntries;
  var totalPages;

  AdminUserDataModel({this.farmers, this.pageNo, this.totalEntries, this.totalPages});

  AdminUserDataModel.fromJson(Map<String, dynamic> json) {
    if (json['farmers'] != null) {
      farmers = <UserDataModel>[];
      json['farmers'].forEach((v) {
        farmers!.add(new UserDataModel.fromJson(v));
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
