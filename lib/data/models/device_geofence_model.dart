import 'package:tanod_tractor/data/models/admin_booking_model.dart';

class DeviceGeoFenceModel {
  var id;
  var imei;
  var geoFenceId;
  var latitude;
  var longitude;
  var radius;
  var fenceName;
  var zoomLevel;
  var date;
  var stateId;
  var typeId;
  var createdAt;
  var updatedAt;
  CreatedByModel? createdBy;

  DeviceGeoFenceModel(
      {this.id,
        this.imei,
        this.geoFenceId,
        this.latitude,
        this.longitude,
        this.radius,
        this.fenceName,
        this.zoomLevel,
        this.date,
        this.stateId,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.createdBy});

  DeviceGeoFenceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imei = json['imei'];
    geoFenceId = json['geo_fence_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
    fenceName = json['fence_name'];
    zoomLevel = json['zoom_level'];
    date = json['date'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'] != null
        ? new CreatedByModel.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imei'] = this.imei;
    data['geo_fence_id'] = this.geoFenceId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['radius'] = this.radius;
    data['fence_name'] = this.fenceName;
    data['zoom_level'] = this.zoomLevel;
    data['date'] = this.date;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.toJson();
    }
    return data;
  }
}
