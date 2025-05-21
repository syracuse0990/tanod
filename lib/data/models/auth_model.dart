// To parse this JSON data, do
//
//     final authModel = authModelFromMap(jsonString);

import 'dart:convert';

import 'package:tanod_tractor/domain/entities/auth.dart';

AuthModel authModelFromMap(String str) => AuthModel.fromMap(json.decode(str));

String authModelToMap(AuthModel data) => json.encode(data.toMap());

class AuthModel extends AuthEntity {
  final int? statusCode;
  final String? status;

  final AuthData? data;

  AuthModel({
    this.statusCode,
    this.status,
    final String? message,
    this.data,
  }) : super(
            message: message,
            token: data?.rememberToken,
            name: data?.name,
            email: data?.email,
            profilePic: data?.profileImage,
            otp: data?.emailVerificationOtp.toString());

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : AuthData.fromMap(json["data"]),
      );
}

class AuthData {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  int? roleId;
  int? gender;
  int? stateId;
  dynamic emailVerificationOtp;
  String? emailVerifiedAt;
  dynamic createdAt;
  String? updatedAt;
  String? rememberToken;

  AuthData({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.roleId,
    this.gender,
    this.stateId,
    this.emailVerificationOtp,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.rememberToken,
  });

  factory AuthData.fromMap(Map<String, dynamic> json) => AuthData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profile_image"],
        phoneNumber: json["phone_number"],
        roleId: json["role_id"],
        gender: json["gender"],
        stateId: json["state_id"],
        emailVerificationOtp: json["email_verification_otp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        rememberToken: json["remember_token"],
      );
}
