import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tanod_tractor/data/repositories/map_provider/impl/remote_map_provider.dart';

import '../../../../../app/util/dialog_helper.dart';
import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/device_geofence_model.dart';
import '../../../../../data/models/geofence_model.dart';
import '../../../../../data/repositories/geofence_provider/impl/remote_geofence_provider.dart';
import '../../../../../data/repositories/geofence_provider/interface/geofence_repository.dart';
import '../../../../../data/repositories/map_provider/interface/imap_repository.dart';
import '../../../map_modules/map_methods.dart';

class AdminGeoFenceController extends GetxController with BaseController {

  var googleMapController=Rxn<GoogleMapController>();
  RxString selectDevice = "Select Device".obs;
 // Completer completerController = Completer();
  RxList<Marker> markers = <Marker>[].obs;
  RxList<Circle> circles = <Circle>[].obs;
  IGeoFenceRepository? iGeoFenceRepository;
  IDeviceRepository? iDeviceRepository;
  RxInt geoFencePage = 1.obs;
  ScrollController geoFenceController = ScrollController();
  GeoFenceDataModel? geoFenceDataModel;
  RxList<DeviceGeoFenceModel>? geoFenceList = <DeviceGeoFenceModel>[].obs;
  var kGooglePlex = Rxn<CameraPosition>();
  ScrollController deviceController = ScrollController();
  IMapRepository? iMapRepository;
  RxBool isUpdating = false.obs;
  RxBool isFromHome = false.obs;
   var deviceImei = "".obs;
   var currentCameraPosition=Rxn<CameraPosition>();

  var geofenceDetailModel = Rxn<DeviceGeoFenceModel>();

  var geofenceNameController = TextEditingController();
  var latitudeController = TextEditingController().obs;
  var longitudeController = TextEditingController().obs;
  var radiusController = TextEditingController().obs;
  var zoomLevelController = TextEditingController();
  var dateController = TextEditingController();

  DeviceDetailDataModel? deviceDetailDataModel;
  RxList<DevicesModel>? deviceList = <DevicesModel>[].obs;
  var deviceModel = Rxn<DevicesModel>();
  RxInt devicePage = 1.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iGeoFenceRepository = Get.put(RemoteIGeoFenceProvider());
      iMapRepository = Get.put(RemoteIMapProvider());
      iDeviceRepository = Get.put(RemoteIDeviceProvider());
      if (isFromHome.isFalse) {
        hitApiToGetGeoFenceList();
        addPaginationOnGeoFenceList();

        hitApiToGetDeviceList();
        addPaginationForDeviceList();
      } else {
        hitApiToGetGeoFenceDetailsByDeviceImei(imei: deviceImei);
      }
    });
    super.onInit();
  }

  Future hitApiToGetGeoFenceDetailsByDeviceImei({imei}) async {
    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['imei'] = imei;
    print("check all hit ${map}");
    await iGeoFenceRepository?.getFenceByDeviceImei(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        geofenceDetailModel.value = value.data;
        geofenceDetailModel.refresh();
        Get.forceAppUpdate();
        showDetailsOnFields();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  showPopUpMenuButton({onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.details),
        ),
        PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.update),
        ),
        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 3,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteTxt),
        )
      ],
    );
  }

  Future hitApiToGetGeoFenceList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['allData'] = 1;
    map['page_no'] = geoFencePage.value;

    await iGeoFenceRepository?.getAllGeofenceList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        geoFenceDataModel = value.data;
        if (geoFenceDataModel != null) {
          geoFenceList?.addAll(geoFenceDataModel?.deviceGeoFence ?? []);
        }
        geoFenceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnGeoFenceList() {
    geoFenceController.addListener(() {
      if (geoFenceController.position.pixels ==
          geoFenceController.position.maxScrollExtent) {
        if (geoFenceDataModel != null &&
            int.parse(geoFenceDataModel?.pageNo?.toString() ?? "1") <
                int.parse(geoFenceDataModel?.totalPages?.toString() ?? "1")) {
          geoFencePage.value = geoFencePage.value + 1;
          geoFencePage.refresh();
          hitApiToGetGeoFenceList();
        }
      }
    });
  }

  Future hitApiToDeleteFence(
      {index, DeviceGeoFenceModel? deviceGeoFenceModel}) async {
    showLoading("Loading");

    Map<String, dynamic> map = {};

    map['imei'] = deviceGeoFenceModel?.imei;
    map['instruct_no'] = deviceGeoFenceModel?.geoFenceId;

    await iGeoFenceRepository?.deleteGeoFence(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        geoFenceList?.removeAt(index!);
        geoFenceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetGeoFenceDetails({DeviceGeoFenceModel? deviceGeoFenceModel,
      bool? isUpdated = false,var geoFenceId}) async {
    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['id'] = geoFenceId??deviceGeoFenceModel?.id;
    await iGeoFenceRepository?.viewGeoFenceDetails(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        geofenceDetailModel.value = value.data;
        geofenceDetailModel.refresh();
        if (isUpdated == true) {
          showDetailsOnFields();
        }
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  //herr we show details on fields
  showDetailsOnFields() {
    if (geofenceDetailModel.value != null) {
      geofenceNameController.text = geofenceDetailModel.value?.fenceName ?? "";
      selectDevice.value = geofenceDetailModel.value?.imei?.toString() ?? "";
      if (deviceList != null) {
        int? index = deviceList?.indexWhere(
            (element) => element?.imeiNo == geofenceDetailModel.value?.imei);
        if (index != -1) {
          deviceList![index!].isSelected = true;
          deviceList?.refresh();
        }
      }

      latitudeController.value.text =
          geofenceDetailModel.value?.latitude?.toString() ?? "";
      longitudeController.value.text =
          geofenceDetailModel.value?.longitude?.toString() ?? "";
      radiusController.value.text =
          geofenceDetailModel.value?.radius?.toString() ?? "";
      zoomLevelController.text =
          geofenceDetailModel.value?.zoomLevel?.toString() ?? "";
      dateController.text = geofenceDetailModel.value?.date?.toString() ?? "";

      Future.delayed(
        Duration(seconds: 1),
        () {
          makeCameraZoom();
          hitApiToGetAllLatLng(imei: geofenceDetailModel.value?.imei);
        },
      );

      //here we draw on on cirlce
    }
  }

  makeCameraZoom() async {
    if (latitudeController.value.text.isNotEmpty &&
        zoomLevelController.value.text.isNotEmpty == true &&
        longitudeController.value.text.isNotEmpty &&
        radiusController.value.text.isNotEmpty == true) {

      circles.clear();

      markers.add(Marker(
          markerId: MarkerId("id"),
         draggable: true,
          position: LatLng(
              double.parse(latitudeController.value.text.toString()),
              double.parse(longitudeController.value.text.toString()))));
      circles.add(Circle(
          circleId: CircleId("1"),
          radius: double.parse(radiusController.value.text.toString()),
          strokeColor: AppColors.primary,
          strokeWidth: 1,

          center: LatLng(double.parse(latitudeController.value.text.toString()),
              double.parse(longitudeController.value.text.toString()))));

      markers.refresh();
      circles.refresh();


      googleMapController.value?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(
              double.parse(
                  latitudeController.value.text.toString() ?? "0.0"),
              double.parse(
                  longitudeController.value.text.toString() ?? "0.0")),
          zoom: int.parse(zoomLevelController.value.text)<10?double.parse("20.0"):double.parse(
              zoomLevelController.value.text?.toString() ?? "0.0"))));


      Get.forceAppUpdate();
    }
  }

  Future hitApiToCreateNewGeoFence() async {
    if (geofenceNameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterGeoFence);
      return;
    } else if (selectDevice.value == 'Select Device') {
      showToast(message: AppStrings.selectDevice);
      return;
    } else if (radiusController.value.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterRadius);
      return;
    } else if (zoomLevelController.value.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterZoomLevel);
      return;
    } else if (dateController.value.text.isEmpty) {
      showToast(message: AppStrings.dateIsEmpty);
      return;
    }

    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['imei'] = selectDevice.value;
    map['fence_name'] = geofenceNameController.text.trim();
    map['latitude'] = latitudeController.value.text;
    map['longitude'] = longitudeController.value.text;
    map['radius'] = radiusController.value.text;
    map['zoom_level'] = zoomLevelController.value.text;
    map['date'] = dateController.value.text;

    await iGeoFenceRepository?.createNewGeoFence(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value?.message ?? "");
        geoFenceList!.insert(0, value.data!);
        Get.back();
        clearAllFields();
        /* geofenceDetailModel.value = value.data;
        geofenceDetailModel.refresh();*/
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToUpdateGeoFence({index, id}) async {
    if (geofenceNameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterGeoFence);
      return;
    } else if (selectDevice.value == 'Select Device') {
      showToast(message: AppStrings.selectDevice);
      return;
    } else if (radiusController.value.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterRadius);
      return;
    } else if (zoomLevelController.value.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterZoomLevel);
      return;
    } else if (dateController.value.text.isEmpty) {
      showToast(message: AppStrings.dateIsEmpty);
      return;
    }

    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['imei'] = selectDevice.value;
    map['fence_name'] = geofenceNameController.text.trim();
    map['latitude'] = latitudeController.value.text;
    map['longitude'] = longitudeController.value.text;
    map['radius'] = radiusController.value.text;
    map['zoom_level'] = zoomLevelController.value.text;
    map['date'] = dateController.value.text;

    await iGeoFenceRepository?.updateGeoFence(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value?.message ?? "");
        geoFenceList![index] = value.data!;
        isUpdating.value = false;
        Get.back();
        clearAllFields();
        /* geofenceDetailModel.value = value.data;
        geofenceDetailModel.refresh();*/
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  clearAllFields() {
    geofenceNameController.clear();
    latitudeController.value.clear();
    longitudeController.value.clear();
    radiusController.value.clear();
    zoomLevelController.clear();
    dateController.clear();
    selectDevice.value = "Select Device";
    update();
  }

  Future hitApiToGetDeviceList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['allData'] = 1;
    map['page_no'] = devicePage.value;

    await iDeviceRepository?.getAllDeviceList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        deviceDetailDataModel = value.data;
        if (deviceDetailDataModel != null) {
          deviceList?.addAll(deviceDetailDataModel?.tractors ?? []);
        }

        print("check data ${deviceList?.length}");
        deviceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationForDeviceList() {
    deviceController.addListener(() {
      if (deviceController.position.pixels ==
          deviceController.position.maxScrollExtent) {
        if (deviceDetailDataModel != null &&
            int.parse(deviceDetailDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    deviceDetailDataModel?.totalPages?.toString() ?? "1")) {
          devicePage.value = devicePage.value + 1;
          devicePage.refresh();
          hitApiToGetDeviceList();
        }
      }
    });
  }

  //here we show the moving tractor on map
  Future hitApiToGetAllLatLng({imei}) async {
    DialogHelper.showLoading();
    await iMapRepository?.getTractorLatLng(map: {
      'imeis': [imei]
    }).then((value) {
      DialogHelper.hideLoading();
      if (value != null &&
          value.data != null &&
          value.data?.result != null &&
          value.data?.result!.length != 0) {
        deviceCurrentLocation(
            latitude: value.data?.result?.first.lat,
            longitude: value.data?.result?.first.lng);
      }
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
    });
  }

  deviceCurrentLocation({latitude, longitude}) async {

    markers.add(Marker(
        markerId: MarkerId("tractor_markers"),
        icon: BitmapDescriptor.fromBytes(
            await MapMethods().getBytesFromAsset(accStatus: "1")),
        position: LatLng(latitude, longitude)));



    googleMapController.value?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17.0)));


    Get.forceAppUpdate();
  }

  @override
  void onClose() {
    print("check dispose is called onClose ");
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    googleMapController.value?.dispose();
    print("check dispose is called ");
    // TODO: implement dispose
    super.dispose();
  }
}
