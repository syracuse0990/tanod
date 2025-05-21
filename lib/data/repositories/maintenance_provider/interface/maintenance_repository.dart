import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/add_update_maintenance_model.dart';
import '../../../models/maintenance_model.dart';
import '../../../models/tratcor_model.dart';

abstract class IMaintenanceRepository {
  Future<MaintenanceModel> getAllMaintenanceList({map}) {
    throw UnimplementedError();
  }



  Future<MaintenanceUpdateAddModel> createNewMaintenance({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteMaintenance({map}) {
    throw UnimplementedError();
  }


  Future<MaintenanceUpdateAddModel> updateMaintenance({map}) {
    throw UnimplementedError();
  }
  Future<MaintenanceUpdateAddModel> maintenanceDetails({map}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> changeMaintenanceState({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> addMaintenanceConclusion({map}) {
    throw UnimplementedError();
  }


  Future<TractorDataModel> getMaintenanceTractorList({map}) {
    throw UnimplementedError();
  }

  Future<MaintenanceModel> applyFilterOnMaintenance({map}) {
    throw UnimplementedError();
  }


}
