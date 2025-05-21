import '../../../../../../../app/util/export_file.dart';
import '../../../list/widgets/tractor_tile_view.dart';
import '../controller/create_group_controller.dart';

class AdminTractorView extends GetView<CreateGroupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.tractorList,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500).fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Column(
        children: [
          Obx(() =>
               Expanded(
                  child: controller.tractorList?.length != 0?ListView.builder(
                      controller: controller.tractorController,
                      itemCount: controller.tractorList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.tractorList![index].isSelected ==
                                true) {
                              controller.tractorList![index].isSelected = false;
                            } else {
                              controller.tractorList![index].isSelected = true;
                            }
                            controller.tractorList?.refresh();
                          },
                          child: TractorTileView(
                            isSelected: controller.tractorList![index].isSelected,
                            isAdmin: true,
                            tractorModel: controller.tractorList![index],
                          ),
                        );
                      }):noDataFoundWidget())
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
