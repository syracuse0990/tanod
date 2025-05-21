import 'package:flutter/scheduler.dart';

import '../../../app/util/export_file.dart';
import '../list/widgets/farmer_list_screen.dart';

class FarmerView extends GetView<ReservationController> {
  FarmerView({super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.farmerList?.clear();
      controller.farmerPage.value = 1;
      controller.update();
      controller.hitApiToGetFarmerList();
      controller.addPaginationOnFarmerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: (){
          List<FarmerModel>? list = controller.farmerList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.farmerModel.value = list?.first;
            controller.farmerModel.refresh();
          }
          Get.back(result: controller.farmerModel.value);
        },
        firstLabel: AppStrings.farmerList,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Obx(() => FarmerListScreen(
        onTab: (index){
          for (int i = 0;
          i < controller.farmerList!.length;
          i++) {
            if (i == index) {
              controller.farmerList![i].isSelected = true;
            } else {
              controller.farmerList![i].isSelected = false;
            }
          }
          controller.farmerList?.refresh();
          controller.farmerModel.value =
          controller.farmerList![index];
          Get.back(result: controller.farmerModel.value);
        },

          farmerController: controller.farmerController,
          farmerList: controller.farmerList?.value)),
    );
  }
}
