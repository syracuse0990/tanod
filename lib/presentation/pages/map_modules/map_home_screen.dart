import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanod_tractor/presentation/pages/map_modules/tractor_playback_new_view.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../../data/models/admin_booking_model.dart';
import '../../../data/models/api_date_model.dart';
import '../../../data/models/home_device_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';
import 'current_localtion.dart';
import 'map_bottom_sheet_dialog.dart';
import 'map_details_screen.dart';
import 'map_methods.dart';

class MapHomeScreen extends StatefulWidget {
  const MapHomeScreen({super.key});

  @override
  State createState() => MapHomeScreenState();
}

class MapHomeScreenState extends State<MapHomeScreen> {
  final Completer completerController = Completer();

  CameraPosition? kGooglePlex;
  List<LatLng> _polylineCoordinates = [LatLng(30.7046, 76.7179)];
  CameraPosition? cameraMovePosition;
  List<BookingModel>? bookingList = <BookingModel>[].obs;
  IMapRepository? iMapRepository;
  GoogleMapController? googleMapController;
  bool? isShowBottomSheet = false;
  final PolylineId _polylineId = PolylineId("polyline");

  List<ApiDataModel>? apiDataList = [];
  String? imeiList = "";

  //for the first time it will be normal
  bool checkMapType = false;
  List<ApiDataModel>? deviceTractList = [];
  HomeDeviceDataModel? bottomSheetModel;

  RxList<Marker> markers = <Marker>[].obs;
  double? latitude, longitude;
  int? currentIndex = 0;
  List<LatLng> mlist = [
    LatLng(30.7046, 76.7179),
    LatLng(30.7333, 76.7794),
  ];

  //new code for home screen
  List<HomeDeviceDataModel>? dataList = [];

  @override
  void initState() {
    print("Onint called");
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      checkMapTypeNormalOrOther();
      iMapRepository = Get.put(RemoteIMapProvider());
      hitApiToGetAcceptedBookings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              mapType: checkMapType == true ? MapType.terrain : MapType.normal,
              markers: Set<Marker>.from(markers),
              onCameraMoveStarted: () {},
              onCameraMove: (CameraPosition cameraPosition) {
                if (bookingList != null && bookingList?.length != 0) {
                  if (timer?.isActive == null || timer?.isActive == false) {
                    timer = Timer.periodic(Duration(seconds: 10), (innerTimer) {
                      hitApiToGetDeviceTrackList(imei: imeiList);

                      if (mounted) setState(() {});
                    });
                  }
                }
              },
              initialCameraPosition:
                  kGooglePlex ?? CameraPosition(target: LatLng(0.0, 0.0)),
              onMapCreated: (GoogleMapController controller) {
                completerController.complete(controller);
              },
              polylines: {
                Polyline(
                  polylineId: _polylineId,
                  color: Colors.red,
                  width: 5,
                  points: _polylineCoordinates,
                ),
              }),
          MapMethods().mapIconsWidget(onCurrentLocationTab: () {
            //  hitApiToGetDeviceTrackList();
            getTractorCurrentLocation();
          }, onMapTypeChangeTab: () {
            changeMapType();
          }, onRefreshTab: () {
            hitApiToGetAcceptedBookings();
          },onPlayBackTab: (){
            Get.to(TractorPlaybackNewView());
          }),
          isShowBottomSheet == true
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: MapBottomSheetView(
                      bookingModel: bottomSheetModel,
                      onTab: () {
                        isShowBottomSheet = false;
                        setState(() {});
                      }),
                )
              : SizedBox()
        ],
      ),
    );
  }

//here we check the map type either normal or other type
  checkMapTypeNormalOrOther() {
    if (box.read(mapTypeKeys) == null) {
      box.write(mapTypeKeys, APIEndpoint.normalMapType);
      checkMapType = false;
    } else if (box.read(mapTypeKeys) != null &&
        box.read(mapTypeKeys) == APIEndpoint.normalMapType) {
      checkMapType = false;
    } else if (box.read(mapTypeKeys) != null &&
        box.read(mapTypeKeys) == APIEndpoint.otherMapType) {
      checkMapType = true;
    } else {
      checkMapType = false;
    }

    setState(() {});
  }

  changeMapType() {
    if (box.read(mapTypeKeys) == APIEndpoint.normalMapType) {
      checkMapType = true;
      box.write(mapTypeKeys, APIEndpoint.otherMapType);
    } else {
      checkMapType = false;
      box.write(mapTypeKeys, APIEndpoint.normalMapType);
    }
    setState(() {});
  }

  Future hitApiToGetAcceptedBookings() async {
    try {
      showLoading();
      await iMapRepository?.getAllHomeDevices().then((value) {
        if (value.data != null) {
          dataList?.clear();
          dataList?.addAll(value.data ?? []);
          setState(() {
            imeiList = dataList
                ?.map((e) => e.apiData?.imei.toString())
                .toList()
                .join(",");

            showTractorOnMapNew(dataList);
          });
        }
      });
    } catch (e) {
      hideLoading();
      print("check all exceptions ${e}");
    }

    return;
    bookingList?.clear();
    // DialogHelper.showLoading();
    await iMapRepository?.getAllAcceptedBookings().then((value) {
      DialogHelper.hideLoading();
      if (value != null && value.data != null && value.data != {}) {
        bookingList?.addAll(value.data?.bookings ?? []);
        imeiList = bookingList
            ?.map((e) => e.apiData?.first.imei.toString())
            .toList()
            .join(",");
        setState(() {});
      } else {
        getTractorCurrentLocation();
      }
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
    });
  }

  showTractorOnMapNew(List<HomeDeviceDataModel>? bookings) async {
    try {
      markers.clear();
      _polylineCoordinates.clear();
      googleMapController = await completerController.future;

      if (bookings != null && bookings.isNotEmpty == true) {
        //here we animate first marker

        setState(() {});
        googleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 6.0,
          target: LatLng(
              double.parse(bookings.last.apiData?.lat?.toString() ?? "0.0"),
              double.parse(bookings.last.apiData?.lng?.toString() ?? "0.0")),
        )));

        bookings.forEach((element) async {
          Uint8List? unitList = await MapMethods().getBytesFromAsset(
              speed: element.apiData?.speed,
              mintues: element.minutes,
              status: element.apiData?.status,
              accStatus: element.apiData?.accStatus);

          if (mounted) setState(() {});

          //if(element?.createdBy!=null){
          markers.add(Marker(
            infoWindow: InfoWindow(
                title: element.apiData?.imei,
                onTap: () {
                  setState(() {
                    timer?.cancel();

                    getLocationFromLatLong(
                            latitude: element?.apiData?.lat ?? 0.0,
                            longitude: element?.apiData?.lng ?? 0.0)
                        .then((value) {
                      timer?.cancel();
                      Get.to(MapDetailsScreen(
                        bookingModel: element,
                        address: value,
                        fromMap: true,
                      ));
                    });
                  });
                }),
            icon: BitmapDescriptor.fromBytes(unitList!),
            markerId: MarkerId(element.apiData?.imei?.toString() ?? ""),
            position: LatLng(
                double.parse(element.apiData?.lat?.toString() ?? "0.0"),
                double.parse(element.apiData?.lng?.toString() ?? "0.0")),
          ));
          //  }
        });
        hideLoading();
      }
      print("check total length of markers ${markers?.length}");
    } catch (e) {
      hideLoading();
      print("check any exceptions ${e}");
    }
  }

  //this is old method for handling data

  Future hitApiToGetDeviceTrackList({imei}) async {
    googleMapController = await completerController.future;

    deviceTractList?.clear();
    //  DialogHelper.showLoading();
    await iMapRepository
        ?.updateLatLng(map: {"imeis": imei}).then((value) async {
      // DialogHelper.hideLoading();
      if (value != null &&
          value.data != null &&
          value.data?.result != null &&
          value.data?.result != []) {
        deviceTractList?.addAll(value?.data?.result ?? []);

        if (deviceTractList != null && deviceTractList?.isNotEmpty == true) {
          for (int i = 0; i < deviceTractList!.length; i++) {
            var index = markers.indexWhere((element) =>
                element.markerId ==
                MarkerId(deviceTractList![i].imei?.toString() ?? ""));
            if (index != -1) {
              int? bookingIndex = bookingList?.indexWhere((element) =>
                  element?.device != null &&
                  element.device?.imeiNo?.toString() ==
                      deviceTractList![index].imei.toString());
              if (bookingIndex != -1) {
                Uint8List? unitList = await MapMethods().getBytesFromAsset(
                    speed: bookingList![bookingIndex!].apiData?.first.speed,
                    status: bookingList![bookingIndex!].apiData?.first.status,
                    accStatus:
                        bookingList![bookingIndex!].apiData?.first.accStatus);
                googleMapController?.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                  zoom: 11,
                  target: LatLng(
                      double.parse(
                          deviceTractList![index].lat?.toString() ?? "0.0"),
                      double.parse(
                          deviceTractList![index].lng?.toString() ?? "0.0")),
                )));

                markers[index] = Marker(
                  infoWindow: InfoWindow(
                      title: bookingList![bookingIndex!].createdBy != null
                          ? bookingList![bookingIndex!].createdBy?.email ?? ""
                          : deviceTractList![i].imei.toString(),
                      onTap: () {
                        setState(() {
                          timer?.cancel();
                          if (bookingList![bookingIndex!].createdBy != null) {
                            isShowBottomSheet = true;
                            bottomSheetModel = HomeDeviceDataModel(
                              apiData:
                                  bookingList![bookingIndex!].apiData?.first,
                              tractor: bookingList![bookingIndex!].tractor,
                              // createdBy: bookingList![bookingIndex!].createdBy,
                              //device: bookingList![bookingIndex!].device,
                            );
                            // bottomSheetModel = bookingList![bookingIndex!];
                          } else {
                            timer?.cancel();
                            HomeDeviceDataModel bookingModel =
                                HomeDeviceDataModel(
                                    deviceModal: '---',
                                    imeiNo: deviceTractList![i].imei,
                                    sim: '---',
                                    deviceName: deviceTractList![i].deviceName,
                                    apiData: deviceTractList![i]);
                            getLocationFromLatLong(
                                    latitude: deviceTractList![i].lat ?? 0.0,
                                    longitude: deviceTractList![i].lng ?? 0.0)
                                .then((value) {
                              Get.to(MapDetailsScreen(
                                bookingModel: bookingModel,
                                address: value,
                                fromMap: true,
                              ));
                            });
                          }
                        });
                      }),
                  icon: BitmapDescriptor.fromBytes(unitList!),
                  markerId: MarkerId(deviceTractList![i].imei.toString() ?? ""),
                  position: LatLng(
                      double.parse(
                          deviceTractList![i].lat?.toString() ?? "0.0"),
                      double.parse(
                          deviceTractList![i].lng?.toString() ?? "0.0")),
                );
              }
            }
          }
        }
      }
      setState(() {});
    }).onError((error, stackTrace) {
      ///  DialogHelper.hideLoading();
      showToast(message: error?.toString());
    });
  }

  //here we show the moving tractor on map
  Future hitApiToGetAllLatLng({imei}) async {
    apiDataList?.clear();
    bookingList?.clear();
    DialogHelper.showLoading();
    await iMapRepository?.getTractorLatLng().then((value) {
      DialogHelper.hideLoading();
      if (value != null && value.data != null) {
        apiDataList?.addAll(value?.data?.result ?? []);
        setState(() {});
      }
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
    });
  }

  getTractorCurrentLocation() async {
    markers.clear();
    googleMapController = await completerController.future;
    DialogHelper.showLoading("");
    Position? position = await UserCurrentLocation.getCurrentLocation();
    DialogHelper.hideLoading();
    if (position != null) {
      kGooglePlex = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 11.4746);
      await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 11.4746)));

      markers.add(Marker(
          infoWindow: InfoWindow(
            title: "Your Current Location",
          ),
          markerId: MarkerId("1" ?? ""),
          position: LatLng(position.latitude, position.longitude)));

      setState(() {});
    }
  }

  @override
  void deactivate() {
    print("check the phase of deactivate ");
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    timer?.cancel();
    print("check timer ${timer?.isActive}");
    googleMapController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
