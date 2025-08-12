import 'dart:convert';

import 'package:dio/src/dio.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/devices_list_model.dart';
import 'package:tanod_tractor/data/providers/network/dio_base_provider.dart';
import 'package:tanod_tractor/data/providers/network/dio_exceptions.dart';

class AddDeviceController extends DioBaseProvider   {
  // final imei = TextEditingController();
  final RxList<Device> deviceList = <Device>[].obs;
  String? imei; 
  final deviceModal = TextEditingController();
  final deviceName = TextEditingController();
  final salesTime = TextEditingController();
  final subscriptionExpiration = TextEditingController();
  final expirationDate = TextEditingController();
  final mcType = TextEditingController();
  final mcTypeScope = TextEditingController();
  final sim = TextEditingController();
  final simIccid = TextEditingController();
  final simRegistration = TextEditingController();
  final mobileDataLoad = TextEditingController();
  final activationTime = TextEditingController();
  final isCheckin = 0.obs;
  final remark = TextEditingController();
  final stateId = 0.obs;
  final typeId = 0.obs;
  final createdBy = 0.obs;

  @override
  void onClose() {
    // imei.dispose();
    deviceModal.dispose();
    deviceName.dispose();
    salesTime.dispose();
    subscriptionExpiration.dispose();
    expirationDate.dispose();
    mcType.dispose();
    mcTypeScope.dispose();
    sim.dispose();
    simIccid.dispose();
    simRegistration.dispose();
    mobileDataLoad.dispose();
    activationTime.dispose();
    remark.dispose();
  }


  @override
  void onInit() {
    super.onInit();
    getDeviceLists(); // Load devices when controller is initialized
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

  addDevice() async {
    GetConnect connect = GetConnect();
    var body = {
      "imei": imei,
      "device_modal": deviceModal.text,
      "device_name": deviceName.text,
      "sales_time": salesTime.text,
      "subscription_expiration": subscriptionExpiration.text,
      "expiration_date": expirationDate.text,
      "mc_type": mcType.text,
      "mc_type_scope": mcTypeScope.text,
      "sim": sim.text,
      "sim_iccid": simIccid.text,
      "sim_registration": simRegistration.text,
      "mobile_data_load": mobileDataLoad.text,
      "activation_time": activationTime.text,
      "is_checkin": isCheckin.value,
      "remark": remark.text,
      "state_id": stateId.value,
      "type_id": typeId.value,
      "created_by": createdBy.value
    };
    // submit
  }

}
