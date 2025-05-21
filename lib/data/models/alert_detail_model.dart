import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/admin_booking_model.dart';

class AlertDetailModel {
  var id;
  var userId;
  var alarmType;
  var alarmTime;
  var imei;
  var alarmName;
  var deviceName;
  var latitude;
  var longitude;
  var createdAt;
  var updatedAt;
  CreatedByModel? createdBy;
  DevicesModel? deviceDetail;

  AlertDetailModel(
      {this.id,
        this.userId,
        this.alarmType,
        this.alarmTime,
        this.imei,
        this.alarmName,
        this.deviceName,
        this.latitude,
        this.longitude,
        this.createdBy,
        this.createdAt,
        this.deviceDetail,
        this.updatedAt});

  AlertDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    alarmType = json['alarm_type'];
    alarmTime = json['alarm_time'];
    imei = json['imei'];
    alarmName = json['alarm_name'];
    deviceName = json['device_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
    deviceDetail = json['device_detail'] != null
        ? new DevicesModel.fromJson(json['device_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['alarm_type'] = this.alarmType;
    data['alarm_time'] = this.alarmTime;
    data['imei'] = this.imei;
    data['alarm_name'] = this.alarmName;
    data['device_name'] = this.deviceName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    if (this.deviceDetail != null) {
      data['device_detail'] = this.deviceDetail!.toJson();
    }
    return data;
  }
}