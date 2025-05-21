


import '../../../models/admin_booking_model.dart';
import '../../../models/admin_booking_operation_model.dart';

abstract class IAdminBookingRepository {

  Future<AdminBookingModel> getAllAdminBookings({map}) {
    throw UnimplementedError();
  }

  Future<AdminBookingModel> getAllTractorBookings({map}) {
    throw UnimplementedError();
  }

  Future<AdminBookingOperationModel> changeBookingStatus({map}) {
    throw UnimplementedError();
  }





}

