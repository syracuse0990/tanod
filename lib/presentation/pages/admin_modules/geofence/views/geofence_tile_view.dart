import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/device_geofence_model.dart';
import '../controller/geofence_controller.dart';
import 'add_new_geofence_view.dart';
import 'admin_geofence_detail_view.dart';

class GeoFenceTileView extends GetView<AdminGeoFenceController> {
  DeviceGeoFenceModel? deviceGeoFenceModel;
  int? index;

  GeoFenceTileView({this.deviceGeoFenceModel, this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                rowTitleWidget(
                    title: AppStrings.imei ?? "",
                    value: deviceGeoFenceModel?.imei?.toString() ?? ""),
                rowTitleWidget(
                    title: AppStrings.fenceName ?? "",
                    value: deviceGeoFenceModel?.fenceName?.toString() ?? ""),
                rowTitleWidget(
                    title: AppStrings.geoFenceId ?? "",
                    value: deviceGeoFenceModel?.geoFenceId?.toString() ?? ""),
                rowTitleWidget(
                    title: AppStrings.date ?? "",
                    value: deviceGeoFenceModel?.date?.toString() ?? ""),
                rowTitleWidget(title: AppStrings.state ?? "", value: "Active"),
                rowTitleWidget(
                    title: AppStrings.createdBy ?? "", value: deviceGeoFenceModel?.createdBy?.name??""),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
          controller.showPopUpMenuButton(
              onDeleteTab: () {
                controller.hitApiToDeleteFence(
                    index: index, deviceGeoFenceModel: deviceGeoFenceModel);
              },
              onEditTab: () {
                Get.to(AddNewGeoFenceView(index: index,isUpdated: true,deviceGeoFenceModel: deviceGeoFenceModel,));
              },
              onDetailTab: () {
                Get.to(AdminGeoFenceDetailView(geoFenceId: null,
                    deviceGeoFenceModel: deviceGeoFenceModel));
              })
        ],
      ),
    );
  }
}
