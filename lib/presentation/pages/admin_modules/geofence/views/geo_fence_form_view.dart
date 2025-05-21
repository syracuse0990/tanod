import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/device_geofence_model.dart';
import '../../calender_view/controller/calender_view_controller.dart';
import '../controller/geofence_controller.dart';
import 'device_imei_view.dart';

class GeoFenceFormView extends GetView<AdminGeoFenceController> {
  DeviceGeoFenceModel? deviceGeoFenceModel;
   int? index;
   GeoFenceFormView({this.index,this.deviceGeoFenceModel,super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      maxExtent: double.infinity,
       expandedWidget: Container(
        width: double.infinity,

        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(title: AppStrings.geoFenceName),
              _geoFenceTextFieldWidget,
              SizedBox(
                height: 15.h,
              ),
              const TractorText(text: 'Select Device'),
              AddSpace.vertical(20.h),
              Obx(
                () => CommonTractorTileView(
                    title: controller.selectDevice.value,
                    onTab: () async {
                      if (!Get.isRegistered<TractorCalenderController>()) {
                        Get.lazyPut(() => TractorCalenderController());
                      }
                      DevicesModel? deviceModel =await Get.to(() => DeviceImeiView());
                      if (deviceModel != null) {
                        controller.selectDevice.value = deviceModel.imeiNo ?? "";
                        controller.update();
                        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

                         controller.hitApiToGetAllLatLng(imei:  controller.selectDevice.value);
                        });
                      }
                    }),
              ),
              SizedBox(
                height: 15.h,
              ),
              titleWidget(title: AppStrings.latitude),
              Obx(
                () => _latitudeTextFieldWidget,
              ),
              SizedBox(
                height: 15.h,
              ),
              titleWidget(title: AppStrings.longitude),
              Obx(
                () => _longitudeTextFieldWidget,
              ),
              SizedBox(
                height: 15.h,
              ),
              titleWidget(title: AppStrings.radius),
              Obx(
                () => _radiusTextFieldWidget,
              ),
              SizedBox(
                height: 15.h,
              ),
              titleWidget(title: AppStrings.zoomLevel),
              _zoomLevelTextFieldWidget,
              SizedBox(
                height: 15.h,
              ),
              titleWidget(title: AppStrings.date),
              _geoFenceDateTextField,
              SizedBox(
                height: 50.h,
              ),
             Obx(() =>  saveButton)
            ],
          ),
        ),
      ),
      previewWidget: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r))),
          child: Center(
              child: TractorText(
            text: AppStrings.addOtherDetails,
            color: AppColors.white,
            fontSize: 16.sp,
          ))),
      backgroundWidget: SizedBox(),
      onDragging: (double) {},
    );
  }

  titleWidget({title}) {
    return TractorText(text: title ?? "");
  }

  Widget get _geoFenceTextFieldWidget => TractorTextfeild(
        controller: controller.geofenceNameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.geoFenceName,
      );

  Widget get _latitudeTextFieldWidget => TractorTextfeild(
        controller: controller.latitudeController.value,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        isEnabned: false,
        hint: AppStrings.selectLatitude,
      );

  Widget get _longitudeTextFieldWidget => TractorTextfeild(
        controller: controller.longitudeController.value,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        isEnabned: false,
        hint: AppStrings.selectLatitude,
      );

  Widget get _radiusTextFieldWidget => TractorTextfeild(
        controller: controller.radiusController.value,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        onChanged: (data) {
          print("check all data ${controller.radiusController.value.text}");
          if (controller.latitudeController.value.text.isNotEmpty &&
              controller.longitudeController.value.text.isNotEmpty&& controller.radiusController.value.text.isNotEmpty) {
            controller.circles.clear();
            controller.circles.add(Circle(
                circleId: CircleId("1"),
                radius: double.parse(
                    controller.radiusController.value.text.toString()),
                strokeColor: AppColors.primary,
                strokeWidth: 1,
                center: LatLng(
                    double.parse(
                        controller.latitudeController.value.text.toString()),
                    double.parse(controller.longitudeController.value.text
                        .toString()))));

            controller.circles.refresh();
            Get.forceAppUpdate();
          }
        },
        hint: AppStrings.radiusHint,
      );

  Widget get _zoomLevelTextFieldWidget => TractorTextfeild(
        controller: controller.zoomLevelController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        hint: AppStrings.zoomHint,
        onChanged: (data) {
          controller.makeCameraZoom();
        },
      );

  Widget get _geoFenceDateTextField => GestureDetector(
        onTap: () {
          showDateTimePicker(
              context: Get.context!,
              isEnabled: false,
              onChanged: (dateTime) {
                if (dateTime == null) {
                  return;
                }
                controller.dateController.text =
                    DateFormat("yyyy-MM-dd").format(dateTime);
                controller.update();
              });
        },
        child: TractorTextfeild(
          controller: controller.dateController,
          textInputAction: TextInputAction.next,
          isEnabned: false,
          isSufix: true,
          suffixWidget: Icon(
            Icons.calendar_month,
            color: AppColors.primary,
          ),
          keyboardType: TextInputType.number,
          hint: AppStrings.date,
        ),
      );

  Widget get saveButton => TractorButton(
        text:controller.isUpdating.isTrue? AppStrings.update: AppStrings.save,
        onTap: () {
          if(controller.isUpdating.isTrue){
           controller.hitApiToUpdateGeoFence(id: deviceGeoFenceModel?.id,index: index);
          }else{
            controller.hitApiToCreateNewGeoFence();
          }

        },
      );
}
