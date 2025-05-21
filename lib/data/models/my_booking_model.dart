class MyBookingModel {
  int? statusCode;
  String? status;
  String? message;
  MyBookingDataModel? data;

  MyBookingModel({this.statusCode, this.status, this.message, this.data});

  MyBookingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new MyBookingDataModel.fromJson(json['data']) : null;
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

class MyBookingDataModel {
  List<BookingDetailModel>? bookings;

  MyBookingDataModel({this.bookings});

  MyBookingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <BookingDetailModel>[];
      json['bookings'].forEach((v) {
        bookings!.add(new BookingDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingDetailModel {
  var id;
  var tractorId;
  var deviceId;
  var slotId;
  var purpose;
  var date;
  var stateId;
  var reason;
  var typeId;
  var createdAt;
  var updatedAt;
  var createdBy;

  BookingDetailModel(
      {this.id,
        this.tractorId,
        this.deviceId,
        this.slotId,
        this.purpose,
        this.reason,
        this.date,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy});

  BookingDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tractorId = json['tractor_id'];
    deviceId = json['device_id'];
    slotId = json['slot_id'];
    purpose = json['purpose'];
    reason = json['reason'];
    date = json['date'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tractor_id'] = this.tractorId;
    data['device_id'] = this.deviceId;
    data['slot_id'] = this.slotId;
    data['purpose'] = this.purpose;
    data['date'] = this.date;
    data['reason'] = this.reason;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}
