import '../../../../../app/util/export_file.dart';
import '../../../list/widgets/tractor_tile_view.dart';
import '../controller/calender_view_controller.dart';

class AdminTractorView extends GetView<TractorCalenderController> {
  AdminTractorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: 'Select Tractor',
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
              child: controller.tractorList?.length != 0
                  ? ListView.builder(
                      controller: controller.tractorController,
                      itemCount: controller.tractorList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            for(int i=0;i< controller.tractorList!.length;i++){
                              if(i==index){
                                controller.tractorList![i].isSelected=true;
                              }else{
                                controller.tractorList![i].isSelected=false;
                              }
                            }
                            controller.tractorList?.refresh();
                            Get.back(result: "data");
                          },
                          child: TractorTileView(
                            isSelected: controller.tractorList![index].isSelected ,
                            tractorModel: controller.tractorList?[index],
                            isAdmin: true,
                          ),
                        );
                      })
                  : noDataFoundWidget()))
        ],
      ),
      // body: Obx(() => TractorsListScreen(tractorList: controller.tractorList?.value,isAdmin: true)),
    );
  }
}
