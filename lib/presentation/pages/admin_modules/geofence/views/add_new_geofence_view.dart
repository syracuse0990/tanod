import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/device_geofence_model.dart';
import '../controller/geofence_controller.dart';
import 'geo_fence_form_view.dart';

class AddNewGeoFenceView extends GetView<AdminGeoFenceController> {
  bool? isUpdated = false;
  DeviceGeoFenceModel? deviceGeoFenceModel;
  int? index;
  var deviceImei;

  bool isFromHome = false;

  AddNewGeoFenceView(
      {this.deviceGeoFenceModel,
      this.index,
      this.deviceImei,
      this.isUpdated = false,
      this.isFromHome = false,
      super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.isUpdating.value = isUpdated ?? false;
      controller.isFromHome.value = isFromHome ?? false;
      controller.deviceImei.value = deviceImei ?? '';
      controller.deviceImei.refresh();
      controller.isUpdating.refresh();

      if (isUpdated == true) {
        controller.hitApiToGetGeoFenceDetails(
            geoFenceId: null,
            deviceGeoFenceModel: deviceGeoFenceModel,
            isUpdated: isUpdated);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: TractorBackArrowBar(
            firstLabel: controller.isFromHome.isTrue
                ? AppStrings.geoFence
                : controller.isUpdating.isTrue
                    ? AppStrings.updateGeoFence
                    : AppStrings.createGeoFence,
            firstTextStyle: TextStyle(
              fontFamily:
                  GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                      .fontFamily,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          body: Stack(
            children: [
              Obx(() => GoogleMap(
                initialCameraPosition: controller.kGooglePlex.value ??
                    CameraPosition(target: LatLng(0.0, 0.0)),
                onTap: (LatLng? latLng) {
                  if (controller.isFromHome.isTrue) {
                    return;
                  }
                  if (latLng != null) {
                    controller.latitudeController.value.text =
                        latLng.latitude?.toString() ?? "";
                    controller.longitudeController.value.text =
                        latLng.longitude?.toString() ?? "";
                    controller.markers.add(Marker(
                        markerId: MarkerId("id"), position: latLng!));
                    Get.forceAppUpdate();
                    controller.makeCameraZoom();
                  }
                },
                onCameraMove: (CameraPosition? cameraPosition) {
                  controller.currentCameraPosition.value = cameraPosition;
                  controller.currentCameraPosition.refresh();
                },
                mapType: MapType.normal,
                markers: Set<Marker>.from(controller.markers),
                circles: Set<Circle>.from(controller.circles),
                onMapCreated: (GoogleMapController mapController) {
                  controller.googleMapController.value = mapController;
                  controller.googleMapController.refresh();
                  Get.forceAppUpdate();
                },
              )),
              controller.isFromHome.isTrue
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: GeoFenceFormView(
                        index: index,
                        deviceGeoFenceModel: deviceGeoFenceModel,
                      )),
            ],
          ),
        ));
  }
}
