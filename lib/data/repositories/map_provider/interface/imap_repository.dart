


import '../../../models/admin_booking_model.dart';
import '../../../models/device_track_model.dart';
import '../../../models/device_tracking_model.dart';
import '../../../models/home_device_model.dart';
import '../../../models/map_api_data.dart';

abstract class IMapRepository {


  //existing api for home screen
  Future<AdminBookingModel> getAllAcceptedBookings() {
    throw UnimplementedError();
  }

  //new api for home screen
 Future<HomeDeviceModel> getAllHomeDevices() {
    throw UnimplementedError();
  }


  Future<MapModel> getTractorLatLng({map}) {
    throw UnimplementedError();
  }

  Future<AdminBookingModel> getAllDeviceBasedList({map}) {
    throw UnimplementedError();
  }


  Future<DeviceTrackingModel> getDeviceTrackingData({map}) {
    throw UnimplementedError();
  }


  Future<DeviceTrackingModel> updateLatLng({map}) {
    throw UnimplementedError();
  }

 Future<DeviceTrackModel> saveDeviceTrack({map}) {
    throw UnimplementedError();
  }




}

