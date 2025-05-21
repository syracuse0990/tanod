import 'package:tanod_tractor/presentation/pages/list/widgets/tractor_tile_view.dart';

import '../../../../../app/util/export_file.dart';
import '../../controller/maintenance_controller.dart';

class AdminSelectTractorView extends GetView<MaintenanceController> {
  AdminSelectTractorView({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<TractorModel>? list = controller.tractorList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.tractorModel.value = list?.first;
            controller.tractorModel.refresh();
          }
          Get.back(result: controller.tractorModel.value);
        },
        firstLabel: 'Tractor List',
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
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Obx(() => controller.tractorList?.length != 0
                  ? ListView.builder(
                      controller: controller.tractorController,
                      itemCount: controller.tractorList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            for (int i = 0;
                                i < controller.tractorList!.length;
                                i++) {
                              if (i == index) {
                                controller.tractorList![i].isSelected = true;
                              } else {
                                controller.tractorList![i].isSelected = false;
                              }
                            }
                            controller.tractorList?.refresh();
                            controller.tractorModel.value =
                                controller.tractorList![index];
                            controller.tractorModel.refresh();
                            Get.back(result: controller.tractorModel.value);
                          },
                          child: TractorTileView(
                            isFromMaintenance: true,
                            isSelected: controller.tractorList![index].isSelected,
                            tractorModel: controller.tractorList?[index],
                          ),
                        );
                      })
                  : noDataFoundWidget()))
        ],
      ),
    );
  }
}
