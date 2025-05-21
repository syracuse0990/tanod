import '../../../../../app/util/export_file.dart';
import '../../../list/widgets/device_tile_view.dart';
import '../controller/geofence_controller.dart';

class DeviceImeiView extends GetView<AdminGeoFenceController> {
  const DeviceImeiView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.deviceList,
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
          Obx(() => controller.deviceList?.length != 0
              ? Expanded(
              child: ListView.builder(
                  controller: controller.deviceController,
                  itemCount: controller.deviceList?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        for(int i=0;i<controller.deviceList!.length;i++){
                          if(i==index){
                            controller.deviceList![i].isSelected=true;
                          }else{
                            controller.deviceList![i].isSelected=false;
                          }
                        }
                        controller.deviceList?.refresh();
                        controller.deviceModel.value =
                        controller.deviceList![index];
                        Get.back(result: controller.deviceModel.value);


                      },
                      child: DeviceTileView(
                        isAdmin: true,
                        isSelected: controller.deviceList![index].isSelected,
                        devicesModel: controller.deviceList![index],
                      ),
                    );
                  }))
              : noDataFoundWidget())
        ],
      ),
    );
  }
}
