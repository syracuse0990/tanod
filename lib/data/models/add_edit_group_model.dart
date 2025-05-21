import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class AddEditGroupModel {
  var statusCode;
  var status;
  String? message;
  GroupsModel? data;

  AddEditGroupModel({this.statusCode, this.status, this.message, this.data});

  AddEditGroupModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];

    data = json['data'] != null ? new GroupsModel.fromJson(json['data']) : null;
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

