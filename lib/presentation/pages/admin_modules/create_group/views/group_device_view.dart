import '../../../../../../../app/util/export_file.dart';
import '../../../list/widgets/device_tile_view.dart';
import '../controller/create_group_controller.dart';

class AdminDeviceView extends GetView<CreateGroupController> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
          Obx(() =>
               Expanded(
              child: controller.deviceDataList?.length != 0?ListView.builder(
                  controller: controller.deviceController,
                  itemCount: controller.deviceDataList?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        if(controller.deviceDataList![index].isSelected==true){
                          controller.deviceDataList![index].isSelected=false;
                        }else{
                          controller.deviceDataList![index].isSelected=true;
                        }
                        controller.deviceDataList?.refresh();

                      },
                      child: DeviceTileView(
                        isSelected:controller.deviceDataList![index].isSelected ,
                        isAdmin: true,
                        devicesModel: controller.deviceDataList![index],
                      ),
                    );
                  }): noDataFoundWidget())
              ),

          saveButton

        ],
      ),
    );
  }

  Widget get saveButton => Padding(
    padding: EdgeInsets.all(20.r),
    child: TractorButton(
      
      text: AppStrings.save,
      onTap: () {
      Get.back(result: "data");
      },
    ),
  );
}
