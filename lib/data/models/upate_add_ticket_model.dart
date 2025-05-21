import 'package:tanod_tractor/data/models/ticket_model.dart';

class UpdateAddTicketModel {
  int? statusCode;
  String? status;
  String? message;
  TicketDetailModel? data;

  UpdateAddTicketModel({this.statusCode, this.status, this.message, this.data});

  UpdateAddTicketModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new TicketDetailModel.fromJson(json['data']) : null;
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
