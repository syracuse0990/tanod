import 'dart:io';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum AuthType { login, logout, signup, otp }

class AuthAPI implements APIRequestRepresentable {
  final AuthType type;
  dynamic jsonData;

  AuthAPI._({
    required this.type,
    required this.jsonData,
  });

  AuthAPI.logIn(dynamic jsonData)
      : this._(type: AuthType.login, jsonData: jsonData);
  AuthAPI.signUp(dynamic jsonData)
      : this._(type: AuthType.signup, jsonData: jsonData);
  AuthAPI.otp(dynamic jsonData)
      : this._(type: AuthType.otp, jsonData: jsonData);

  @override
  String get baseUrl => APIEndpoint.baseUrl;

  @override
  String get endPoint {
    switch (type) {
      case AuthType.login:
        return APIEndpoint.login;
      case AuthType.logout:
        return "/logout";
      case AuthType.signup:
        return APIEndpoint.signUp;
      case AuthType.otp:
        return APIEndpoint.otp;
      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, String> get headers =>
      {HttpHeaders.contentTypeHeader: 'application/json'};

  @override
  Map<String, dynamic> get query {
    return jsonData;
  }

  @override
  get body => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => baseUrl + endPoint;
}
