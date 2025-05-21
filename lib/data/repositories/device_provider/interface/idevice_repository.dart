import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/add_device_model.dart';
import '../../../models/device_model.dart';

abstract class IDeviceRepository {
  Future<DeviceDataModel> getAllDeviceList({map}) {
    throw UnimplementedError();
  }

  Future<AddDeviceModel> getDeviceDetails({map}) {
    throw UnimplementedError();
  }

  Future<AddDeviceModel> addNewDevices({map}) {
    throw UnimplementedError();
  }

  Future<AddDeviceModel> updateDevices({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteDevice({map}) {
    throw UnimplementedError();
  }
}
