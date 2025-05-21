import '../../../models/alert_model.dart';

abstract class IAlertRepository {
  Future<AlertModel> getAllAlertList({map}) {
    throw UnimplementedError();
  }

  Future<AlertModel> getAllAlertBasedOnImei({map}) {
    throw UnimplementedError();
  }



}
