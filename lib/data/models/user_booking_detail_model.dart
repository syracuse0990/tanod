import 'package:tanod_tractor/data/models/tractor_group_model.dart';

class UserBookingDetailModel {
  int? statusCode;
  String? status;
  String? message;
  UserBookingDetailDataModel? data;

  UserBookingDetailModel(
      {this.statusCode, this.status, this.message, this.data});

  UserBookingDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserBookingDetailDataModel.fromJson(json['data']) : null;
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

class UserBookingDetailDataModel {
  int? id;
  int? tractorId;
  int? deviceId;
  Null? slotId;
  String? purpose;
  String? date;
  int? stateId;
  int? typeId;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  TractorModel? tractor;
  DevicesModel? device;


  UserBookingDetailDataModel(
      {this.id,
        this.tractorId,
        this.deviceId,
        this.slotId,
        this.purpose,
        this.date,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.tractor,
        this.device,
        });

  UserBookingDetailDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tractorId = json['tractor_id'];
    deviceId = json['device_id'];
    slotId = json['slot_id'];
    purpose = json['purpose'];
    date = json['date'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    tractor =
    json['tractor'] != null ? new TractorModel.fromJson(json['tractor']) : null;
    device =
    json['device'] != null ? new DevicesModel.fromJson(json['device']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tractor_id'] = this.tractorId;
    data['device_id'] = this.deviceId;
    data['slot_id'] = this.slotId;
    data['purpose'] = this.purpose;
    data['date'] = this.date;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }

    return data;
  }
}


