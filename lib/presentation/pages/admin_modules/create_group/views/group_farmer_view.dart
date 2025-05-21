import '../../../../../app/util/export_file.dart';
import '../../../list/widgets/common_tile_view.dart';
import '../controller/create_group_controller.dart';

class AdminFarmerView extends GetView<CreateGroupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
           firstLabel: AppStrings.farmerList,
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
                    child: controller.farmerList?.length != 0?ListView.builder(
                        shrinkWrap: true,
                        controller: controller.farmerController,
                        itemCount: controller.farmerList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (controller.farmerList?[index].isSelected ==
                                  true) {
                                controller.farmerList?[index].isSelected =
                                    false;
                              } else {
                                controller.farmerList?[index].isSelected = true;
                              }
                              controller.farmerList?.refresh();
                            },
                            child: CommonTileView(
                              isSelected:
                                  controller.farmerList?[index].isSelected ??
                                      false,
                              title: controller.farmerList?[index].name ??
                                  controller.farmerList?[index].email,
                            ),
                          );
                        }):noDataFoundWidget(),
                  )
                ),
            saveButton
          ],
        ));
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
