import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../app/util/export_file.dart';

abstract class DioBaseProvider extends GetxController{
  final dio = Dio();
  Duration timezone = DateTime.now().timeZoneOffset;

  DioBaseProvider() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    dio
      ..options.baseUrl = APIEndpoint.baseUrl
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 20000));

    return;
  }
}
