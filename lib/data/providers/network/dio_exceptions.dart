import 'dart:io';

import 'package:dio/dio.dart';

import '../../../app/util/export_file.dart';
import '../../../presentation/router/route_page_strings.dart';
import '../../repositories/login_provider/impl/remote_login_provider.dart';



class NetworkExceptions {
  static String getDioException(error) {
    String? message;
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.badCertificate:
              //  message=LocaleKeys.ca
              break;
            case DioErrorType.unknown:
              //  message=LocaleKeys.ca
              break;
            case DioErrorType.cancel:
              break;
            case DioErrorType.connectionTimeout:
              message = AppStrings.sendTimeout;
              break;

            case DioErrorType.receiveTimeout:
              message = AppStrings.receiveTimeout;
              break;
            case DioErrorType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  if (error.response != null && error.response!.data != null) {
                    return message = error.response!.data['message'];
                  }
                  break;
                case 401:
                case 302:
                  box.remove(tokenKeys);
                  box.remove(roleType);
                  Get.offAllNamed(RoutePage.signIn);
                  Get.put(RemoteILoginProvider());
                  break;
                case 403:
                  message = AppStrings.unauthorisedRequest;
                  break;
                case 404:
                  message = AppStrings.notFound;
                  break;
                case 409:
                  message = AppStrings.conflict;
                  break;
                case 408:
                  message = AppStrings.requestCancelled;
                  break;
                case 422:
                  if (error.response != null && error.response!.data != null) {
                    return message = error.response!.data['message'];
                  }
                  break;
                case 500:
                  message = AppStrings.internalServerError;
                  break;
                case 503:
                  message = AppStrings.serviceUnavailable;
                  break;
                default:
                  message = error.message;
              }
              break;
            case DioErrorType.sendTimeout:
              message = AppStrings.sendTimeout;
              break;
            case DioErrorType.connectionError:
              //  Get.toNamed(Routes.noInternet);
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          message = AppStrings.noInternetConnection;
        } else {
          message = AppStrings.unexpectedError;
        }
        return message!;
      } on FormatException catch (e) {
        return AppStrings.formatException;
      } catch (_) {
        return AppStrings.unexpectedError;
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return AppStrings.unableProcess;
      } else {
        return AppStrings.unexpectedError;
      }
    }
  }
}
