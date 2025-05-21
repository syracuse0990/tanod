import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/geofence_detail_model.dart';
import '../../../models/geofence_model.dart';

abstract class IGeoFenceRepository {
  Future<GeoFenceModel> getAllGeofenceList({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteGeoFence({map}) {
    throw UnimplementedError();
  }

  Future<GeoFenceDetailModel> viewGeoFenceDetails({map}) {
    throw UnimplementedError();
  }

  Future<GeoFenceDetailModel> createNewGeoFence({map}) {
    throw UnimplementedError();
  }



  Future<GeoFenceDetailModel> updateGeoFence({map}) {
    throw UnimplementedError();
  }


  Future<GeoFenceDetailModel> getFenceByDeviceImei({map}) {
    throw UnimplementedError();
  }


}
