class ApiDataModel {
 var imei;
 var deviceName;
 var icon;
 var status;
 var posType;
 var lat;
 var lng;
 var hbTime;
 var accStatus;
 var gpsSignal;
  var powerValue;
 var batteryPowerVal;
 var speed;
 var gpsNum;
 var gpsTime;
 var gpsSpeed;
 var direction;
 var activationFlag;
 var expireFlag;
 var electQuantity;
  var locDesc;
 var distance;
  var temperature;
  var trackerOil;
 var currentMileage;

  ApiDataModel(
      {this.imei,
        this.deviceName,
        this.icon,
        this.status,
        this.posType,
        this.lat,
        this.lng,
        this.hbTime,
        this.gpsSpeed,
        this.accStatus,
        this.gpsSignal,
        this.powerValue,
        this.batteryPowerVal,
        this.speed,
        this.gpsNum,
        this.gpsTime,
        this.direction,
        this.activationFlag,
        this.expireFlag,
        this.electQuantity,
        this.locDesc,
        this.distance,
        this.temperature,
        this.trackerOil,
        this.currentMileage});

  ApiDataModel .fromJson(Map<String, dynamic> json) {
    imei = json['imei'];
    deviceName = json['deviceName'];
    icon = json['icon'];
    status = json['status'];
    posType = json['posType'];
    lat = json['lat'];
    lng = json['lng'];
    hbTime = json['hbTime'];
    accStatus = json['accStatus'];
    gpsSignal = json['gpsSignal'];
    powerValue = json['powerValue'];
    batteryPowerVal = json['batteryPowerVal'];
    speed = json['speed'];
    gpsNum = json['gpsNum'];
    gpsTime = json['gpsTime'];
    gpsSpeed = json['gpsSpeed'];
    direction = json['direction'];
    activationFlag = json['activationFlag'];
    expireFlag = json['expireFlag'];
    electQuantity = json['electQuantity'];
    locDesc = json['locDesc'];
    distance = json['distance'];
    temperature = json['temperature'];
    trackerOil = json['trackerOil'];
    currentMileage = json['currentMileage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imei'] = this.imei;
    data['deviceName'] = this.deviceName;
    data['icon'] = this.icon;
    data['status'] = this.status;
    data['posType'] = this.posType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['hbTime'] = this.hbTime;
    data['accStatus'] = this.accStatus;
    data['gpsSignal'] = this.gpsSignal;
    data['powerValue'] = this.powerValue;
    data['batteryPowerVal'] = this.batteryPowerVal;
    data['speed'] = this.speed;
    data['gpsNum'] = this.gpsNum;
    data['gpsTime'] = this.gpsTime;
    data['gpsSpeed'] = this.gpsSpeed;
    data['direction'] = this.direction;
    data['activationFlag'] = this.activationFlag;
    data['expireFlag'] = this.expireFlag;
    data['electQuantity'] = this.electQuantity;
    data['locDesc'] = this.locDesc;
    data['distance'] = this.distance;
    data['temperature'] = this.temperature;
    data['trackerOil'] = this.trackerOil;
    data['currentMileage'] = this.currentMileage;
    return data;
  }
}