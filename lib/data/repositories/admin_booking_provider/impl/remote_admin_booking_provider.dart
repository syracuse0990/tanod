import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../models/admin_booking_model.dart';
import '../../../models/admin_booking_operation_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/iadmin_booking_repository.dart';

class RemoteIAdminBookingProvider extends DioBaseProvider
    implements IAdminBookingRepository {
  @override
  Future<AdminBookingModel> getAllAdminBookings({map}) async {
    // TODO: implement logoutApi
    try {
      var response =
          await dio.get(APIEndpoint.adminAllBookingUrl, queryParameters: map);

      jsonEncode(response?.data);
      return AdminBookingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminBookingOperationModel> changeBookingStatus({map}) async {
    // TODO: implement changeBookingStatus
    try {
      var response =
          await dio.post(APIEndpoint.changeBookingStatusUrl, data: jsonEncode(map) );

      return AdminBookingOperationModel.fromJson(response.data);

    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  //tractorBookingsUrl
  @override
  Future<AdminBookingModel> getAllTractorBookings({map}) async {
    // TODO: implement getAllTractorBookings
    try {
      var response =
          await dio.get(APIEndpoint.tractorBookingsUrl, queryParameters: map);

      jsonEncode(response?.data);
      return AdminBookingModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
}
