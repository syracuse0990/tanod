class UserModel {
  UserDataModel? success;

  UserModel({this.success});

  UserModel.fromJson(Map<String, dynamic> json) {
    success =
    json['success'] != null ? new UserDataModel.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class UserDataModel {
  var id;
  var name;
  String? email;
  var phone;
  var twoFactorConfirmedAt;
  var roleId;
  var gender;
  bool? phoneVerified;
  var profilePhotoPath;
  String? emailVerifiedAt;
  var emailVerificationOtp;
  var deviceType;
  String? fcmToken;
  var stateId;
  var typeId;
  var phoneCountry;
  var countryCode;
  var otp;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var createdBy;
  String? rememberToken;
  String? profilePhotoUrl;

  UserDataModel(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.twoFactorConfirmedAt,
        this.roleId,
        this.gender,
        this.profilePhotoPath,
        this.emailVerifiedAt,
        this.emailVerificationOtp,
        this.deviceType,
        this.phoneVerified,
        this.fcmToken,
        this.stateId,
        this.countryCode,
        this.rememberToken,
        this.typeId,
        this.deletedAt,
        this.otp,
        this.phoneCountry,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.profilePhotoUrl});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneCountry = json['phone_country'];
    countryCode = json['country_code'];
    phone = json['phone'];
    otp = json['otp'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    roleId = json['role_id'];
    gender = json['gender'];
    phoneVerified = json['phone_verified'];
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
    rememberToken = json['remember_token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_country'] = phoneCountry;
    data['phone'] = phone;
    data['otp'] = otp;
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
    data['phone_verified'] = this.phoneVerified;

    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['remember_token'] = this.rememberToken;

    return data;
  }
}
