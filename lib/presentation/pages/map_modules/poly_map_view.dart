import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_seekbar/seekbar/seekbar.dart';
import 'package:google_map_marker_animation/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../../data/models/api_date_model.dart';
import '../../../data/models/device_track_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';
import 'custom_map_view_model.dart';
import 'track_card_view.dart';

class LocationMovingMarkerScreen extends StatefulWidget {
  var deviceId;
  List<DeviceTrackDataModel>? list;

  LocationMovingMarkerScreen({this.deviceId,this.list, super.key});

  @override
  SimpleMarkerAnimationExampleState createState() =>
      SimpleMarkerAnimationExampleState();
}

class SimpleMarkerAnimationExampleState
    extends State<LocationMovingMarkerScreen> {
  final markers = <MarkerId, Marker>{};
  GoogleMapController? googleMapController;
  var initialPosition;
  final controller = Completer<GoogleMapController>();
  Stream<LatLng>? stream;
  var currentIndex=0.0,totalSteps=1;
  double ? finalWidth;
  ApiDataModel? apiDataModel;

  StreamSubscription<CustomApiModel>? streamSubscription;
  bool isLoading = true;
  bool isPlaying = false;
  bool isFirsTime = true;

  List<ApiDataModel>? deviceTractList = [];
  IMapRepository? iMapRepository;
  List<LatLng> _polylineCoordinates = [LatLng(30.7046, 76.7179)];
  final PolylineId _polylineId = PolylineId("polyline");
  //List<LatLng> finalList = [];
  List<CustomApiModel> finalList = [];
  CameraPosition? currentCameraPosition;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
       showPolyLinesOnMap();
     });
    super.initState();
  }


  showPolyLinesOnMap(){
     try{
       if(widget.list==null){
         return;
       }
       if (widget.list != null && widget.list?.isNotEmpty==true) {

         //deviceTractList?.addAll(widget.deviceTrackDataModel?.latlng.data?.result ?? []);
         // print("check all data ${deviceTractList?.length} and ${}")
         finalList.clear();
         _polylineCoordinates.clear();
         widget.list?.forEach((element) {
           finalList.add(CustomApiModel(langLng: LatLng(element.latLng?.lat??0.0, element.latLng?.lng??0.0),apiDataModel: ApiDataModel(
             gpsSpeed: element?.gpsSpeed,gpsTime: element?.gpsTime
           )),);
           _polylineCoordinates?.add(LatLng(element.latLng?.lat??0.0, element.latLng?.lng??0.0));
         });


         initialPosition = CameraPosition(target: finalList.first.langLng??LatLng(0.0, 0.0), zoom: 18.0);

         // _polylineCoordinates?.addAll(finalList.);
         markers[MarkerId('MarkerId1')] = Marker(
           markerId: MarkerId('MarkerId1'),
           position: finalList.first.langLng??LatLng(0.0, 0.0),
         );
       }
       setState(() {
         isLoading = false;
       });
     }catch(e){
       print("check all exceptions ${e}");
       setState(() => isLoading = false);
     }

  }




  showDifferentRestaurants() async {
    if (finalList != null && finalList?.isNotEmpty == true) {
      streamSubscription =
          Stream.periodic(Duration(seconds: 2), (count) => finalList[count]!)
              .take(finalList.length)
              .listen((data) {
             var step= 100/finalList.length;

            currentIndex=currentIndex!+step;

             apiDataModel=data?.apiDataModel;
            if(mounted)setState(() {
            });


          newLocationUpdate(data?.langLng??LatLng(0.0, 0.0));
      });

      streamSubscription?.onDone(() {

        setState(() {
          isPlaying = false;
          currentIndex=0.0;
          apiDataModel=null;
        });
        print("check its done");
      });
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      floatingActionButton:  PolyMapCardView(
          isPlay: isPlaying,
          finalWidth: finalList?.length??0,
          totalSteps: totalSteps,
          currentIndex: currentIndex,
          apiDataModel: apiDataModel,
          onSelected: () {
            if (isPlaying == false) {
              isPlaying = true;
              if (isFirsTime) {
                isFirsTime = false;
                currentIndex=1;
                totalSteps=1;
                showDifferentRestaurants();
              }
              streamSubscription?.resume();
            } else {
              isPlaying = false;
              streamSubscription?.pause();
            }
            setState(() {});
          },
          onReplaySelected: () {
            streamSubscription?.cancel();
            isPlaying = true;
            currentIndex=1;
            totalSteps=1;
            showDifferentRestaurants();
            setState(() {});
          }),
      body: isLoading
          ? Container(
              height: 50.h,
              width: double.infinity,
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
              ))
          : Stack(
              children: [
                Animarker(
                  shouldAnimateCamera: false,
                  zoom: 18.0,
                  curve: Curves.linear,
                  mapId: controller.future.then<int>((value) => value.mapId),
                  //Grab Google Map Id
                  markers: markers.values.toSet(),
                  child: GoogleMap(
                    polylines: {
                      Polyline(
                        polylineId: _polylineId,
                        color: Colors.red,
                        width: 2,
                        points: _polylineCoordinates,
                      ),
                    },
                    mapType: MapType.normal,

                    onCameraMove: (CameraPosition? cameraPosition) {
                      currentCameraPosition = cameraPosition;
                      if (mounted) setState(() {});
                    },
                    initialCameraPosition: initialPosition ??
                        CameraPosition(target: LatLng(0.0, 0.0), zoom: 18.0),
                    onMapCreated: (gController) {
                      googleMapController = gController;
                      controller.complete(gController);
                    }, //Complete the future GoogleMapController
                  ),
                ),

              ],
            ),
    );
  }

  Future<void> newLocationUpdate(LatLng latLng) async {
    var marker = Marker(
      markerId: MarkerId('MarkerId1'),
      position: latLng,
    );
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: currentCameraPosition == null
          ? 18.0
          : currentCameraPosition?.zoom ?? 18.0,
      target: latLng,
    )));
    if (mounted)
      setState(() {
        markers[MarkerId('MarkerId1')] = marker;
      });

    if(streamSubscription?.isPaused==true){
      print("check is pasues");
      isPlaying = false;
      setState(() {

      });
    }

  }

  disposeMap() async {
    if (streamSubscription != null) {
      streamSubscription?.cancel(); // Ensure safe cancellation
    }
    print("check the method ${streamSubscription?.isPaused}");
    googleMapController?.dispose();
  }

  @override
  void dispose() {
    disposeMap();
    // TODO: implement dispose
    super.dispose();
  }
}


// Future hitApiToGetDeviceTrackList() async {
//   deviceTractList?.clear();
//   DialogHelper.showLoading();
//   await iMapRepository
//       ?.getDeviceTrackingData(map: {"id": widget.deviceId}).then((value) {
//     DialogHelper.hideLoading();
//     if (value != null && value.data != null&&value.data?.result?.isNotEmpty==true) {
//
//       deviceTractList?.addAll(value.data?.result ?? []);
//       // print("check all data ${deviceTractList?.length} and ${}")
//       finalList.clear();
//       _polylineCoordinates.clear();
//       deviceTractList?.forEach((element) {
//         finalList.add(CustomApiModel(langLng: LatLng(element.lat, element.lng),apiDataModel:element));
//         _polylineCoordinates?.add(LatLng(element.lat, element.lng));
//       });
//       initialPosition = CameraPosition(target: finalList.first.langLng??LatLng(0.0, 0.0), zoom: 18.0);
//
//       // _polylineCoordinates?.addAll(finalList.);
//       markers[MarkerId('MarkerId1')] = Marker(
//         markerId: MarkerId('MarkerId1'),
//         position: finalList.first.langLng??LatLng(0.0, 0.0),
//       );
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }).onError((error, stackTrace) {
//     DialogHelper.hideLoading();
//     showToast(message: error?.toString());
//     setState(() {
//       isLoading = false;
//     });
//   });
// }

