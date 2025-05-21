import 'dart:convert';

class AuthEntity {
  final String? name;
  final String? profilePic;
  final String? email;
  final String? phoneNumber;
  final String? token;
  final String? password;
  final String? confirmPassword;
  final String? countryCode;
  final String? message;
  final String? fcmtoken;
  final String? otp;
  final String? userId;

  AuthEntity({
    this.name,
    this.profilePic,
    this.email,
    this.phoneNumber,
    this.token,
    this.password,
    this.confirmPassword,
    this.countryCode,
    this.message,
    this.fcmtoken,
    this.otp,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'user_id': userId,
      'otp': otp,
       'device_type': '1',
      'fcm_token': fcmtoken,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());
}
