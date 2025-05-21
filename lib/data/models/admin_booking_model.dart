import 'package:tanod_tractor/app/util/export_file.dart';

import 'api_date_model.dart';

class AdminBookingModel {
  var statusCode;
  var status;
  var message;
  AdminBookingDataModel? data;

  AdminBookingModel({this.statusCode, this.status, this.message, this.data});

  AdminBookingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AdminBookingDataModel.fromJson(json['data']) : null;
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

class AdminBookingDataModel {
  List<BookingModel>? bookings;
  var pageNo;
  var totalEntries;
  var totalPages;

  AdminBookingDataModel({this.bookings, this.pageNo, this.totalEntries, this.totalPages});

  AdminBookingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <BookingModel>[];
      json['bookings'].forEach((v) {
        bookings!.add(new BookingModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class BookingModel {
  var id;
  var tractorId;
  var deviceId;
  var slotId;
  var purpose;
  var date;
  var stateId;
  var typeId;
  var createdAt;
  var updatedAt;
  var group;
  CreatedByModel? createdBy;
  TractorModel? tractor;
  DevicesModel? device;

  List<ApiDataModel>? apiData;

  BookingModel(
      {this.id,
        this.tractorId,
        this.deviceId,
        this.slotId,
        this.purpose,
        this.group,
        this.apiData,
        this.date,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.tractor,
        this.device});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tractorId = json['tractor_id'];
    deviceId = json['device_id'];
    slotId = json['slot_id'];
    purpose = json['purpose'];
    date = json['date'];
    group = json['group'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
    tractor =
    json['tractor'] != null ? new TractorModel.fromJson(json['tractor']) : null;
    device =
    json['device'] != null ? new DevicesModel.fromJson(json['device']) : null;
    if (json['api_data'] != null) {
      apiData = <ApiDataModel>[];
      json['api_data'].forEach((v) {
        apiData!.add(new ApiDataModel.fromJson(v));
      });
    }
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
    data['group'] = this.group;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    if (this.tractor != null) {
      data['tractor'] = this.tractor!.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device!.toJson();
    }
    if (this.apiData != null) {
      data['api_data'] = this.apiData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedByModel {
  var id;
  var name;
  var email;
  var phone;
  var twoFactorConfirmedAt;
  var apiAccessToken;
  var apiTokenTime;
  var roleId;
  var gender;
  var profilePhotoPath;
  var emailVerifiedAt;
  var emailVerificationOtp;
  var deviceType;
  var fcmToken;
  var stateId;
  var typeId;
  var deletedAt;
  var createdAt;
  var updatedAt;
  var createdBy;
  var pendingState;

  var profilePhotoUrl;

  CreatedByModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.twoFactorConfirmedAt,
        this.apiAccessToken,
        this.apiTokenTime,
        this.roleId,
        this.gender,
        this.profilePhotoPath,
        this.emailVerifiedAt,
        this.emailVerificationOtp,
        this.deviceType,
        this.fcmToken,
        this.stateId,
        this.pendingState,
        this.typeId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.profilePhotoUrl});

  CreatedByModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    apiAccessToken = json['api_access_token'];
    apiTokenTime = json['api_token_time'];
    roleId = json['role_id'];
    gender = json['gender'];
    pendingState = json['pending_state'];
    profilePhotoPath = json['profile_photo_path'];
    emailVerifiedAt = json['email_verified_at'];
    emailVerificationOtp = json['email_verification_otp'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['api_access_token'] = this.apiAccessToken;
    data['api_token_time'] = this.apiTokenTime;
    data['role_id'] = this.roleId;
    data['gender'] = this.gender;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    data['pending_state'] = this.pendingState;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
