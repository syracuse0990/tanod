class DeviceTrackModel {
  bool? status;
  String? message;
  List<DeviceTrackDataModel>? data;

  DeviceTrackModel({this.status, this.message, this.data});

  DeviceTrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DeviceTrackDataModel>[];
      json['data'].forEach((v) {
        data!.add(new DeviceTrackDataModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceTrackDataModel {
  LatLngModel? latLng;
  String? gpsTime;
  int? gpsSpeed;
  int? direction;

  DeviceTrackDataModel({this.latLng, this.gpsTime, this.gpsSpeed, this.direction});

  DeviceTrackDataModel.fromJson(Map<String, dynamic> json) {
    latLng =
    json['lat_lng'] != null ? new LatLngModel.fromJson(json['lat_lng']) : null;
    gpsTime = json['gpsTime'];
    gpsSpeed = json['gpsSpeed'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latLng != null) {
      data['lat_lng'] = this.latLng!.toJson();
    }
    data['gpsTime'] = this.gpsTime;
    data['gpsSpeed'] = this.gpsSpeed;
    data['direction'] = this.direction;
    return data;
  }
}

class LatLngModel {
  double? lat;
  double? lng;

  LatLngModel({this.lat, this.lng});

  LatLngModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
