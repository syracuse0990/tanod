import 'package:tanod_tractor/data/models/user_model.dart';

import 'admin_booking_model.dart';

class TractorGroupModel {
  int? statusCode;
  var status;
  var message;
  TractorGroupDataModel? data;

  TractorGroupModel({this.statusCode, this.status, this.message, this.data});

  TractorGroupModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new TractorGroupDataModel.fromJson(json['data'])
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

class TractorGroupDataModel {
  List<GroupsModel>? groups;
  var pageNo;
  var totalEntries;
  var totalPages;

  TractorGroupDataModel(
      {this.groups, this.pageNo, this.totalEntries, this.totalPages});

  TractorGroupDataModel.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <GroupsModel>[];
      json['groups'].forEach((v) {
        groups!.add(new GroupsModel.fromJson(v));
      });
    }
    pageNo = json['page_no'];
    totalEntries = json['total_entries'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    data['page_no'] = this.pageNo;
    data['total_entries'] = this.totalEntries;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class GroupsModel {
  var id;

  List<String>? farmerIds;
  List<String>? tractorIds;
  List<String>? deviceIds;

  var name;
  var stateId;
  var typeId;
  var createdAt;
  var updatedAt;
  var createdBy;
  bool? assign;
  List<TractorModel>? tractors;
  List<FarmerModel>? farmers;
  List<DevicesModel>? devices;
  List<BookingModel>? bookings;
  SubAdminModel? subAdmin;


  GroupsModel(
      {this.id,
      this.farmerIds,
      this.tractorIds,
      this.deviceIds,
      this.name,
      this.stateId,
      this.typeId,
      this.subAdmin,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.bookings,
      this.tractors,
      this.farmers,
      this.assign,
      this.devices});

  GroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    farmerIds =
        json['farmer_ids'] != null ? json['farmer_ids'].cast<String>() : null;
    tractorIds =
        json['tractor_ids'] != null ? json['tractor_ids'].cast<String>() : null;
    deviceIds =
        json['device_ids'] != null ? json['device_ids'].cast<String>() : null;

    name = json['name'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    assign = json['assign'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    if (json['tractors'] != null) {
      tractors = <TractorModel>[];
      json['tractors'].forEach((v) {
        tractors!.add(new TractorModel.fromJson(v));
      });
    }
    if (json['farmers'] != null) {
      farmers = <FarmerModel>[];
      json['farmers'].forEach((v) {
        farmers!.add(new FarmerModel.fromJson(v));
      });
    }
    if (json['devices'] != null) {
      devices = <DevicesModel>[];
      json['devices'].forEach((v) {
        devices!.add(new DevicesModel.fromJson(v));
      });
    }

    if (json['bookings'] != null) {
      bookings = <BookingModel>[];
      json['bookings'].forEach((v) {
        bookings!.add(new BookingModel.fromJson(v));
      });
    }

    subAdmin = json['sub_admin'] != null
        ? new SubAdminModel.fromJson(json['sub_admin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_ids'] = this.farmerIds;
    data['tractor_ids'] = this.tractorIds;
    data['device_ids'] = this.deviceIds;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['assign'] = this.assign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    if (this.tractors != null) {
      data['tractors'] = this.tractors!.map((v) => v.toJson()).toList();
    }
    if (this.farmers != null) {
      data['farmers'] = this.farmers!.map((v) => v.toJson()).toList();
    }
    if (this.devices != null) {
      data['devices'] = this.devices!.map((v) => v.toJson()).toList();
    }
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    if (this.subAdmin != null) {
      data['sub_admin'] = this.subAdmin!.toJson();
    }
    return data;
  }
}

class TractorModel {
  var id;
  var driverId;
  var deviceId;
  var groupId;
  var noPlate;
  var idNo;
  var engineNo;
  var fuelConsumption;
  var maintenanceKilometer;
  var totaldistance;
  var path;


  var brand;
  var model;
  var manufactureDate;
  var installationTime;
  var installationAddress;
  var stateId;
  var typeId;
  var createdAt;
  var updatedAt;
  var createdBy;
  bool? isLongPressed;
  bool? isSelected;
  List<Images>? images;

  TractorModel(
      {this.id,
      this.driverId,
      this.deviceId,
      this.groupId,
      this.noPlate,
      this.idNo,
      this.engineNo,
      this.maintenanceKilometer,
      this.fuelConsumption,
      this.totaldistance,
      this.path,
      this.isSelected = false,
      this.isLongPressed = false,
      this.brand,
      this.model,
      this.manufactureDate,
      this.installationTime,
      this.installationAddress,
      this.stateId,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.images});

  TractorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    deviceId = json['device_id'];
    groupId = json['group_id'];
    noPlate = json['no_plate'];
    maintenanceKilometer = json['maintenance_kilometer'];
    idNo = json['id_no'];
    engineNo = json['engine_no'];
    fuelConsumption = json['fuel_consumption'];
    brand = json['brand'];
    totaldistance = json['total_distance'];
    path = json['path'];
    model = json['model'];
    manufactureDate = json['manufacture_date'];
    installationTime = json['installation_time'];
    installationAddress = json['installation_address'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
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
    data['driver_id'] = this.driverId;
    data['device_id'] = this.deviceId;
    data['group_id'] = this.groupId;
    data['no_plate'] = this.noPlate;
    data['maintenanceKilometer'] = this.maintenanceKilometer;
    data['id_no'] = this.idNo;
    data['engine_no'] = this.engineNo;
    data['total_distance'] = totaldistance;
    data['fuel_consumption'] = this.fuelConsumption;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['manufacture_date'] = this.manufactureDate;
    data['installation_time'] = this.installationTime;
    data['installation_address'] = this.installationAddress;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  var path;
  var modelType;
  int? modelId;
  int? stateId;
  int? typeId;
  var createdAt;
  var updatedAt;
  int? createdBy;

  Images(
      {this.id,
      this.path,
      this.modelType,
      this.modelId,
      this.stateId,
      this.typeId,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['path'] = this.path;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class FarmerModel {
  int? id;
  var name;
  var email;
  var phone;
  var twoFactorConfirmedAt;
  int? roleId;
  var gender;
  var profilePhotoPath;
  var emailVerifiedAt;
  var emailVerificationOtp;
  int? deviceType;
  var fcmToken;
  int? stateId;
  int? typeId;
  var deletedAt;
  var createdAt;
  var updatedAt;
  int? createdBy;
  bool? isSelected;
  var profilePhotoUrl;

  FarmerModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.twoFactorConfirmedAt,
      this.roleId,
      this.gender,
      this.profilePhotoPath,
      this.isSelected = false,
      this.emailVerifiedAt,
      this.emailVerificationOtp,
      this.deviceType,
      this.fcmToken,
      this.stateId,
      this.typeId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.profilePhotoUrl});

  FarmerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    roleId = json['role_id'];
    gender = json['gender'];
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
    data['role_id'] = this.roleId;
    data['gender'] = this.gender;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['email_verification_otp'] = this.emailVerificationOtp;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
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

class DevicesModel {
  var id;
  var imeiNo;
  var deviceModal;
  var deviceName;
  var salesTime;
  var subscriptionExpiration;
  var expirationDate;
  var mcType;
  var mcTypeUseScope;
  var sim;
  var activationTime;
  var remark;
  var maintenanceKilometer;
  var stateId;
  var typeId;
  var createdAt;
  var updatedAt;
  var createdBy;
  bool? isSelected;
  bool? isLongPressed;
  DevicesModel(
      {this.id,
      this.imeiNo,
      this.deviceModal,
      this.deviceName,
      this.salesTime,
      this.subscriptionExpiration,
      this.expirationDate,
      this.stateId,
      this.isSelected = false,
      this.isLongPressed = false,
      this.typeId,
      this.sim,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  DevicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imeiNo = json['imei_no'];
    deviceModal = json['device_modal'];
    deviceName = json['device_name'];
    sim = json['sim'];
    salesTime = json['sales_time'];
    subscriptionExpiration = json['subscription_expiration'];
    expirationDate = json['expiration_date'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imei_no'] = this.imeiNo;
    data['device_modal'] = this.deviceModal;
    data['device_name'] = this.deviceName;
    data['sim'] = this.sim;
    data['sales_time'] = this.salesTime;
    data['subscription_expiration'] = this.subscriptionExpiration;
    data['expiration_date'] = this.expirationDate;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class SubAdminModel {
  var id;
  var userId;
  var groupId;
  var typeId;
  var stateId;
  var createdAt;
  var updatedAt;
  var createdBy;
  UserDataModel? user;

  SubAdminModel(
      {this.id,
        this.userId,
        this.groupId,
        this.typeId,
        this.stateId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.user});

  SubAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    typeId = json['type_id'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    user = json['user'] != null ? new UserDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['type_id'] = this.typeId;
    data['state_id'] = this.stateId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

