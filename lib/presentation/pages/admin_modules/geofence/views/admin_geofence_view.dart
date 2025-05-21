import '../../../../../app/util/export_file.dart';
import '../controller/geofence_controller.dart';
import 'add_new_geofence_view.dart';
import 'geofence_tile_view.dart';

class AdminGeoFenceView extends GetView<AdminGeoFenceController> {
  const AdminGeoFenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: AppColors.white),
          backgroundColor: AppColors.primary,
          onPressed: () {
            controller.clearAllFields();
            Get.to(AddNewGeoFenceView());
          },
        ),
        appBar: TractorBackArrowBar(
          firstLabel: AppStrings.geoFence,
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
            Obx(() => Expanded(
                child: controller.geoFenceList?.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        controller: controller.geoFenceController,
                        itemCount: controller.geoFenceList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GeoFenceTileView(
                            index: index,
                            deviceGeoFenceModel:
                                controller.geoFenceList![index],
                          );
                        })
                    : noDataFoundWidget()))
          ],
        ));
  }
}
