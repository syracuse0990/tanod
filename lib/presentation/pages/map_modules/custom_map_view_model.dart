import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanod_tractor/data/models/api_date_model.dart';

class CustomApiModel{
  LatLng? langLng;
  ApiDataModel ? apiDataModel;

  CustomApiModel({this.apiDataModel,this.langLng});
}