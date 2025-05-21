
import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../../main.dart';
import '../../../models/alert_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../../../providers/network/local_keys.dart';
import '../interface/alert_repository.dart';

class RemoteAlertProvider extends DioBaseProvider implements IAlertRepository {

  @override
  Future<AlertModel> getAllAlertList({map}) async {
    // TODO: implement getAllStaticList
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": box.read(tokenKeys) != null ? "Bearer ${box.read(
            tokenKeys)}" : null
      };
      var response = await dio.post(APIEndpoint.alertList,data: jsonEncode(map));
      return AlertModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AlertModel> getAllAlertBasedOnImei({map}) async {
    // TODO: implement getAllAlertBasedOnImei
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": box.read(tokenKeys) != null ? "Bearer ${box.read(
            tokenKeys)}" : null
      };
      var response = await dio.get(APIEndpoint.alertBaseOnImei,data: jsonEncode(map));
      return AlertModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }



}
