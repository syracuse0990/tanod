import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/device_geofence_model.dart';
import '../controller/geofence_controller.dart';
import 'add_new_geofence_view.dart';

class AdminGeoFenceDetailView extends GetView<AdminGeoFenceController> {
  DeviceGeoFenceModel? deviceGeoFenceModel;
  var geoFenceId;

  AdminGeoFenceDetailView(
      {this.geoFenceId, this.deviceGeoFenceModel, super.key}) {
    Future.delayed(Duration(milliseconds: 500), () {
      if (geoFenceId != null) {
        controller.hitApiToGetGeoFenceDetailsByDeviceImei(imei: geoFenceId);
        return;
      }

      controller.hitApiToGetGeoFenceDetails(
          geoFenceId: geoFenceId, deviceGeoFenceModel: deviceGeoFenceModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.details,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Column(
        children: [
          headerViewWidget(title: AppStrings.geofenceDetails),
          _detailWidget,
          changeStateWidget()
        ],
      ),
    );
  }

  Widget get _detailWidget => Obx(() => Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
            border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
        child: Column(
          children: [
            rowTitleWidget(
                title: AppStrings.imei ?? "",
                value: controller.geofenceDetailModel.value?.imei?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.fenceName ?? "",
                value: controller.geofenceDetailModel.value?.fenceName
                        ?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.geoFenceId ?? "",
                value: controller.geofenceDetailModel.value?.geoFenceId
                        ?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.latitude ?? "",
                value: controller.geofenceDetailModel.value?.latitude
                        ?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.longitude ?? "",
                value: controller.geofenceDetailModel.value?.longitude
                        ?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.radius ?? "",
                value:
                    controller.geofenceDetailModel.value?.radius?.toString() ??
                        ""),
            rowTitleWidget(
                title: AppStrings.zoomLevel ?? "",
                value: controller.geofenceDetailModel.value?.zoomLevel
                        ?.toString() ??
                    ""),
            rowTitleWidget(
                title: AppStrings.date ?? "",
                value: controller.geofenceDetailModel.value?.date?.toString() ??
                    ""),
            rowTitleWidget(title: AppStrings.state ?? "", value: "Active"),
            rowTitleWidget(title: AppStrings.createdBy ?? "", value: "Admin"),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ));

  headerViewWidget({title}) {
    return Container(
      margin: EdgeInsets.only(left: 15.h, right: 15.h, top: 20.h),
      padding: EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
          color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  changeStateWidget({title}) {
    return GestureDetector(
      onTap: () async {
        await controller.hitApiToGetGeoFenceDetailsByDeviceImei(
            imei: controller.geofenceDetailModel.value?.imei);
        Get.to(() => AddNewGeoFenceView(
              isFromHome: true,
              deviceImei: controller.geofenceDetailModel.value?.imei,
            ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.r),
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            color: AppColors.primary),
        child: Center(
          child: TractorText(
            text: AppStrings.viewMap,
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
