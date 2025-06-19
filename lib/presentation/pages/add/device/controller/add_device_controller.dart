import 'package:tanod_tractor/app/util/export_file.dart';

class AddDeviceController extends GetxController {
  final imei = TextEditingController();
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
    imei.dispose();
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

  addDevice() async {
    GetConnect connect = GetConnect();
    var body = {
      "imei": imei.text,
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
