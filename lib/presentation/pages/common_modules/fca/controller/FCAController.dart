

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/devices_list_model.dart';
import 'package:tanod_tractor/data/providers/network/dio_base_provider.dart';
import 'package:tanod_tractor/data/providers/network/dio_exceptions.dart';
import 'package:tanod_tractor/data/models/farmers_model.dart';
import 'package:tanod_tractor/presentation/pages/common_modules/fca/models/fca_listing_model.dart';
import 'package:tanod_tractor/presentation/pages/common_modules/fca/models/tractor_listing_model.dart';



String formatDate(String dateString) {
  try {
    DateTime parsedDate = DateTime.parse(dateString).toLocal(); 
    return DateFormat("MM-dd-yyyy hh:mm a").format(parsedDate);
  } catch (e) {
    return "";
  }
}
class FCAController extends DioBaseProvider {
    var recipients = <FCAData>[].obs;

    final RxList<Device> deviceList = <Device>[].obs;
    final RxList<Tractor> tractorList = <Tractor>[].obs;
    final RxList<Farmer> farmerList = <Farmer>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("FCAController init");
    loadRecipientsFromApi();
    getDeviceLists();
    tractorListing();
    getFarmers();
  }

   Future<void> loadRecipientsFromApi() async {
     try {
      var jsonResponse = await dio.get(APIEndpoint.fcaLists);
      var response = FCAResponse.fromJson(jsonResponse.data);
      recipients.assignAll(response.data); 

    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }
  Future<void> tractorListing() async {
     try {
      var jsonResponse = await dio.get(APIEndpoint.tractorListing);
      var response = TractorListResponse.fromJson(jsonResponse.data);
      tractorList.assignAll(response.data); 

    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


  Future<void> getDeviceLists({Map<String, dynamic>? map}) async {
    try {
      var response = await dio.post(APIEndpoint.deviceLists, data: map != null ? jsonEncode(map) : null);
      var deviceResponse = DeviceResponse.fromJson(response.data);
      deviceList.assignAll(deviceResponse.data.devices); 
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

   Future<void> getFarmers({Map<String, dynamic>? map}) async {
    try {
      var response = await dio.get(APIEndpoint.farmerLists, data: map != null ? jsonEncode(map) : null);
      var farmerResponse = FarmersResponse.fromJson(response.data);
      farmerList.assignAll(farmerResponse.data); 
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  

}
