import 'feedback_model.dart';

class IssueTypeModel {
  var statusCode;
  var status;
  var message;
  IssueTypeDataModel? data;

  IssueTypeModel({this.statusCode, this.status, this.message, this.data});

  IssueTypeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new IssueTypeDataModel.fromJson(json['data']) : null;
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

class IssueTypeDataModel {
  List<IssueType>? issueType;
  var pageNo;
  var totalEntries;
  var totalPages;

  IssueTypeDataModel({this.issueType, this.pageNo, this.totalEntries, this.totalPages});

  IssueTypeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['issueType'] != null) {
      issueType = <IssueType>[];
      json['issueType'].forEach((v) {
        issueType!.add(new IssueType.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.issueType != null) {
      data['issueType'] = this.issueType!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}



