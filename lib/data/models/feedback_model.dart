import 'package:tanod_tractor/data/models/admin_booking_model.dart';

import '../../app/util/export_file.dart';

class FeedbackModel {
  int? statusCode;
  String? status;
  String? message;
  FeedbackDataModel? data;

  FeedbackModel({this.statusCode, this.status, this.message, this.data});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new FeedbackDataModel.fromJson(json['data'])
        : null;
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

class FeedbackDataModel {
  List<FeedbackDetailModel>? feedback;
  var pageNo;
  var totalEntries;
  var totalPages;

  FeedbackDataModel(
      {this.feedback, this.pageNo, this.totalEntries, this.totalPages});

  FeedbackDataModel.fromJson(Map<String, dynamic> json) {
    if (json['feedback'] != null) {
      feedback = <FeedbackDetailModel>[];
      json['feedback'].forEach((v) {
        feedback!.add(new FeedbackDetailModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feedback != null) {
      data['feedback'] = this.feedback!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class FeedbackDetailModel {
  var id;
  var name;
  var email;
  var issueTypeId;
  var description;
  var conclusion;
  var stateId;
  var typeId;
  var techDetails;
  var createdAt;
  var updatedAt;
  CreatedByModel? createdBy;
  List<int>? pendingStates;
  IssueType? issueType;
  List<Images>? images;

  FeedbackDetailModel(
      {this.id,
      this.name,
      this.email,
      this.issueTypeId,
      this.issueType,
      this.description,
      this.techDetails,
      this.conclusion,
      this.images,
      this.stateId,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.pendingStates,
      });

  FeedbackDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    issueTypeId = json['issue_type_id'];
    description = json['description'];
    conclusion = json['conclusion'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    techDetails = json['tech_details'];

    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
    pendingStates = json['pending_states']!=null? json['pending_states'].cast<int>():null;
    issueType = json['issue_type'] != null
        ? new IssueType.fromJson(json['issue_type'])
        : null;

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['issue_type_id'] = this.issueTypeId;
    data['description'] = this.description;
    data['conclusion'] = this.conclusion;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    data['tech_details'] = this.techDetails;

    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['pending_states'] = this.pendingStates;
    if (this.issueType != null) {
      data['issue_type'] = this.issueType!.toJson();
    }
    return data;
  }
}
class IssueType {
  int? id;
  String? title;
  int? stateId;
  int? typeId;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;
  CreatedByModel? createdBy;

  IssueType(
      {this.id,
        this.title,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.isSelected=false,
        this.createdBy
      });

  IssueType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    stateId = json['state_id'];
    isSelected = json['is_selected'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['is_selected'] = this.isSelected;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    return data;
  }
}
