import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_state_handler/page_state_handler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../data/models/admin_booking_model.dart';
import '../../../../data/repositories/map_provider/interface/imap_repository.dart';

class HomeController extends GetxController with BaseController {
  PageStateController pageStateController = PageStateController();

  var mapType = Rxn<MapType>();
  Completer<GoogleMapController> completeController =
      Completer<GoogleMapController>();

  RxList<Marker> markers = <Marker>[].obs;
  GoogleMapController? googleMapController;

  RxBool isDialogCalapsed = false.obs;

  var kGooglePlex = Rxn<CameraPosition>();

   CameraPosition test = CameraPosition(
    target: LatLng(29.6857, 76.9905),
    zoom: 50.0,
  );

  IMapRepository? iMapRepository;
  List<BookingModel>? bookingList = <BookingModel>[].obs;

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getLocation();
    });
    super.onInit();
  }

  //here we set map type as user set the map
  setMapType() {
    if (box.read(mapTypeKeys) == null) {
      box.write(mapTypeKeys, MapType.normal);
      mapType.value = MapType.normal;
      mapType.refresh();
    } else if (box.read(mapTypeKeys) != null &&
        box.read(mapTypeKeys) == MapType.normal) {
      mapType.value = MapType.normal;
      mapType.refresh();
    } else if (box.read(mapTypeKeys) != null &&
        box.read(mapTypeKeys) == MapType.satellite) {
      mapType.value = MapType.satellite;
      mapType.refresh();
    } else {
      mapType.value = MapType.normal;
      mapType.refresh();
    }
  }

  changeMapType() {
    if (mapType.value == MapType.normal) {
      box.write(mapTypeKeys, MapType.satellite);
    } else {
      box.write(mapTypeKeys, MapType.normal);
    }

    mapType.value = box.read(mapTypeKeys);
    mapType.refresh();

    print("check the map type ${mapType.value}");
  }

  void getLocation() async {
  //  googleMapController = await completeController.future;
    final GoogleMapController controller = await completeController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414)));

    googleMapController;
    try {
      final status = await Geolocator.requestPermission();
      if (status == LocationPermission.denied ||
          status == LocationPermission.deniedForever) return;
      // showLoading("Loading");
      final position = await Geolocator.getCurrentPosition();
      if (position != null) {
        kGooglePlex.value = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 50.0,
        );
        await googleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 50.0,
          target: LatLng(double.parse(position.latitude?.toString() ?? "0.0"),
              double.parse(position.longitude?.toString() ?? "0.0")),
        )));
        kGooglePlex.refresh();
      }
   
    } catch (e) {
      hideLoading();
    } finally {
      hideLoading();
    }
  }





 }
