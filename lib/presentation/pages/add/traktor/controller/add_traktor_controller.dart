import 'package:tanod_tractor/app/util/export_file.dart';

class AddTraktorController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final driverId = TextEditingController();
  final deviceId = TextEditingController();
  final groupId = TextEditingController();
  final imei = TextEditingController();
  final noPlate = TextEditingController();
  final idNo = TextEditingController();
  final engineNo = TextEditingController();
  final fuelConsumption = TextEditingController();
  final brand = TextEditingController();
  final model = TextEditingController();
  final manufactureDate = TextEditingController();
  final installationTime = TextEditingController();
  final installationAddress = TextEditingController();
  final maxSpeed = TextEditingController();
  final maintenanceKilometer = TextEditingController();
  final firstMaintenanceHr = TextEditingController();
  final runningKm = TextEditingController();
  final totalDistance = TextEditingController();
  final chasisNo = TextEditingController();
  final insuranceEffectDate = TextEditingController();
  final insuranceExpireDate = TextEditingController();
  final firstAlert = TextEditingController();
  final lastAlertHours = TextEditingController();
  final drDate = TextEditingController();
  final actualDeliveryDate = TextEditingController();
  final drNo = TextEditingController();
  final frontLoaderSn = TextEditingController();
  final rotaryTillerSn = TextEditingController();
  final rotatingDiscPlowSn = TextEditingController();
  final stateId = TextEditingController();
  final typeId = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    driverId.dispose();
    deviceId.dispose();
    groupId.dispose();
    imei.dispose();
    noPlate.dispose();
    idNo.dispose();
    engineNo.dispose();
    fuelConsumption.dispose();
    brand.dispose();
    model.dispose();
    manufactureDate.dispose();
    installationTime.dispose();
    installationAddress.dispose();
    maxSpeed.dispose();
    maintenanceKilometer.dispose();
    firstMaintenanceHr.dispose();
    runningKm.dispose();
    totalDistance.dispose();
    chasisNo.dispose();
    insuranceEffectDate.dispose();
    insuranceExpireDate.dispose();
    firstAlert.dispose();
    lastAlertHours.dispose();
    drDate.dispose();
    actualDeliveryDate.dispose();
    drNo.dispose();
    frontLoaderSn.dispose();
    rotaryTillerSn.dispose();
    rotatingDiscPlowSn.dispose();
    stateId.dispose();
    typeId.dispose();
    super.onClose();
  }

  addTractor() async {
    GetConnect connect = GetConnect();
    var body = {
      "driver_id": driverId.text,
      "device_id": deviceId.text,
      "group_id": groupId.text,
      "imei": imei.text,
      "no_plate": noPlate.text,
      "id_no": idNo.text,
      "engine_no": engineNo.text,
      "fuel_consumption": fuelConsumption.text,
      "brand": brand.text,
      "model": model.text,
      "manufacture_date": manufactureDate.text,
      "installation_time": installationTime.text,
      "installation_address": installationAddress.text,
      "max_speed": maxSpeed.text,
      "maintenance_kilometer": maintenanceKilometer.text,
      "first_maintenance_hr": firstMaintenanceHr.text,
      "running_km": runningKm.text,
      "total_distance": totalDistance.text,
      "chasis_no": chasisNo.text,
      "insurance_effect_date": insuranceEffectDate.text,
      "insurance_expire_date": insuranceExpireDate.text,
      "first_alert": firstAlert.text,
      "last_alert_hours": lastAlertHours.text,
      "dr_date": drDate.text,
      "actual_delivery_date": actualDeliveryDate.text,
      "dr_no": drNo.text,
      "front_loader_sn": frontLoaderSn.text,
      "rotary_tiller_sn": rotaryTillerSn.text,
      "rotating_disc_plow_sn": rotatingDiscPlowSn.text,
      "state_id": stateId.text,
      "type_id": typeId.text
    };

    // submit
  }
}
