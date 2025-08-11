import 'dart:convert';

DeviceResponse deviceResponseFromJson(String str) =>
    DeviceResponse.fromJson(json.decode(str));

String deviceResponseToJson(DeviceResponse data) =>
    json.encode(data.toJson());

class DeviceResponse {
  final int statusCode;
  final String status;
  final String message;
  final DeviceData data;

  DeviceResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeviceResponse.fromJson(Map<String, dynamic> json) => DeviceResponse(
        statusCode: json["statusCode"] ?? 0,
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        data: DeviceData.fromJson(json["data"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DeviceData {
  final List<Device> devices;

  DeviceData({required this.devices});

  factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
        devices: (json["devices"] as List<dynamic>? ?? [])
            .map((x) => Device.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "devices": devices.map((x) => x.toJson()).toList(),
      };
}

class Device {
  final int id;
  final String imeiNo;
  final String? deviceModal;
  final String deviceName;
  final String salesTime;
  final String? subscriptionExpiration;
  final String? expirationDate;
  final String? mcType;
  final String mcTypeUseScope;
  final String sim;
  final String simIccid;
  final String simRegistrationCode;
  final String mobileDataLoad;
  final String activationTime;
  final int isCheck;
  final String? remark;
  final int stateId;
  final int typeId;
  final String createdAt;
  final String updatedAt;
  final int createdBy;

  Device({
    required this.id,
    required this.imeiNo,
    this.deviceModal,
    required this.deviceName,
    required this.salesTime,
    this.subscriptionExpiration,
    this.expirationDate,
    this.mcType,
    required this.mcTypeUseScope,
    required this.sim,
    required this.simIccid,
    required this.simRegistrationCode,
    required this.mobileDataLoad,
    required this.activationTime,
    required this.isCheck,
    this.remark,
    required this.stateId,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] ?? 0,
        imeiNo: json["imei_no"] ?? "",
        deviceModal: json["device_modal"],
        deviceName: json["device_name"] ?? "",
        salesTime: json["sales_time"] ?? "",
        subscriptionExpiration: json["subscription_expiration"],
        expirationDate: json["expiration_date"],
        mcType: json["mc_type"],
        mcTypeUseScope: json["mc_type_use_scope"] ?? "",
        sim: json["sim"] ?? "",
        simIccid: json["sim_iccid"] ?? "",
        simRegistrationCode: json["sim_registration_code"] ?? "",
        mobileDataLoad: json["mobile_data_load"] ?? "",
        activationTime: json["activation_time"] ?? "",
        isCheck: json["is_check"] ?? 0,
        remark: json["remark"],
        stateId: json["state_id"] ?? 0,
        typeId: json["type_id"] ?? 0,
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        createdBy: json["created_by"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imei_no": imeiNo,
        "device_modal": deviceModal,
        "device_name": deviceName,
        "sales_time": salesTime,
        "subscription_expiration": subscriptionExpiration,
        "expiration_date": expirationDate,
        "mc_type": mcType,
        "mc_type_use_scope": mcTypeUseScope,
        "sim": sim,
        "sim_iccid": simIccid,
        "sim_registration_code": simRegistrationCode,
        "mobile_data_load": mobileDataLoad,
        "activation_time": activationTime,
        "is_check": isCheck,
        "remark": remark,
        "state_id": stateId,
        "type_id": typeId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
      };
}
