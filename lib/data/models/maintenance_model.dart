import 'maintenance_detail_model.dart';

class MaintenanceModel {
  var statusCode;
  var status;
  var message;
  MaintenanceDataModel? data;

  MaintenanceModel({this.statusCode, this.status, this.message, this.data});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MaintenanceDataModel.fromJson(json['data']) : null;
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

class MaintenanceDataModel {
  List<MaintenanceDetailModel>? maintenance;
  var pageNo;
  var totalEntries;
  var totalPages;

  MaintenanceDataModel({this.maintenance, this.pageNo, this.totalEntries, this.totalPages});

  MaintenanceDataModel.fromJson(Map<String, dynamic> json) {
    if (json['maintenance'] != null) {
      maintenance = <MaintenanceDetailModel>[];
      json['maintenance'].forEach((v) {
        maintenance!.add(new MaintenanceDetailModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.maintenance != null) {
      data['maintenance'] = this.maintenance!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

