import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../../data/models/api_date_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';
import 'map_methods.dart';

class CustomPolyMapView extends StatefulWidget {
  var deviceId;

  CustomPolyMapView({this.deviceId, super.key});

  @override
  State<CustomPolyMapView> createState() => _PolyMapViewState();
}

class _PolyMapViewState extends State<CustomPolyMapView> {
  CameraPosition? kGooglePlex;
  IMapRepository? iMapRepository;
  RxList<Marker> markers = <Marker>[].obs;

  List<ApiDataModel>? deviceTractList = [];

  bool isLoading = true;
  List<LatLng> _polylineCoordinates = [LatLng(30.7046, 76.7179)];
  final PolylineId _polylineId = PolylineId("polyline");

  GoogleMapController? googleMapController;

  final Completer completerController = Completer();

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iMapRepository = Get.put(RemoteIMapProvider());
      hitApiToGetDeviceTrackList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {

      },

      ),
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.tractDetails,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            markers: Set<Marker>.from(markers),
            polylines: {
              Polyline(
                polylineId: _polylineId,
                color: Colors.red,
                width: 5,
                points: _polylineCoordinates,
              ),
            },
            mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {
              completerController.complete(controller);
            },
            initialCameraPosition:kGooglePlex ?? CameraPosition(target: LatLng(0.0, 0.0)),
          ),
          deviceTractList?.length == 0
              ? Container(
                  width: double.infinity,
                  height: 50.h,
                  padding: EdgeInsets.all(10.r),
                  color: AppColors.primary.withOpacity(0.8),
                  child: Center(
                    child: Text(
                      isLoading == true
                          ? AppStrings.loading
                          : AppStrings.noTrackData,
                      style: TextStyle(
                          color: AppColors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Future hitApiToGetDeviceTrackList() async {
    deviceTractList?.clear();
    DialogHelper.showLoading();
    await iMapRepository
        ?.getDeviceTrackingData(map: {"id": widget.deviceId}).then((value) {
      DialogHelper.hideLoading();
      if (value != null && value.data != null) {
        deviceTractList?.addAll(value.data?.result ?? []);
        showTractorOnMap(deviceTractList);
      }
      setState(() {
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  showTractorOnMap(List<ApiDataModel>? bookings) async {
    markers.clear();
    _polylineCoordinates.clear();
    googleMapController = await completerController.future;

    if (bookings != null && bookings.isNotEmpty == true) {
      //here we animate first marker
      Uint8List? unitList =
          await MapMethods().getBytesFromAsset(accStatus: "1");
      bookings.forEach((element) {
        _polylineCoordinates.add(
          LatLng(double.parse(element.lat?.toString() ?? "0.0"),
              double.parse(element.lng?.toString() ?? "0.0")),
        );
      });

      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 15.0,
        target: LatLng(double.parse(bookings.last.lat?.toString() ?? "0.0"),
            double.parse(bookings.last.lng?.toString() ?? "0.0")),
      )));
    }

    setState(() {});
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
