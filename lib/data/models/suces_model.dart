class BookingSuccessModel {
  int? statusCode;
  String? status;
  String? message;
  BookingSuccessDataModel? data;

  BookingSuccessModel({this.statusCode, this.status, this.message, this.data});

  BookingSuccessModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new BookingSuccessDataModel.fromJson(json['data']) : null;
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

class BookingSuccessDataModel {
  var tractorId;
  var deviceId;
  var date;
  var purpose;
  var stateId;
  var createdBy;
  var updatedAt;
  var createdAt;
  var id;

  BookingSuccessDataModel(
      {this.tractorId,
        this.deviceId,
        this.date,
        this.purpose,
        this.stateId,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id});

  BookingSuccessDataModel.fromJson(Map<String, dynamic> json) {
    tractorId = json['tractor_id'];
    deviceId = json['device_id'];
    date = json['date'];
    purpose = json['purpose'];
    stateId = json['state_id'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tractor_id'] = this.tractorId;
    data['device_id'] = this.deviceId;
    data['date'] = this.date;
    data['purpose'] = this.purpose;
    data['state_id'] = this.stateId;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
