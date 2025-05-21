import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/tractor_tile_view.dart';

import '../../../../../app/util/export_file.dart';
import '../../controller/maintenance_controller.dart';

class AdminIssueTractorView extends GetView<MaintenanceController> {
  AdminIssueTractorView({super.key}) {
    //here we get list of maintenance tractor list
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.hitApiToGetMaintenanceTractorList();

      controller.addPaginationOnIssueMaintenanceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<TractorModel>? list = controller.tractorIssueList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.tractorIssueModel.value = list?.first;
            controller.tractorIssueModel.refresh();
          }
          Get.back(result: controller.tractorIssueModel.value);
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
              child: Obx(() => controller.tractorIssueList?.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: controller.tractorIssueController,
                      itemCount: controller.tractorIssueList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            for (int i = 0;
                                i < controller.tractorIssueList!.length;
                                i++) {
                              if (i == index) {
                                controller.tractorIssueList![i].isSelected =
                                    true;
                              } else {
                                controller.tractorIssueList![i].isSelected =
                                    false;
                              }
                            }
                            controller.tractorIssueList?.refresh();
                            controller.tractorIssueModel.value =
                                controller.tractorIssueList![index];
                            controller.tractorIssueModel.refresh();
                            Get.back(
                                result: controller.tractorIssueModel.value);
                          },
                          child: TractorTileView(
                            isFromMaintenance: true,
                            isSelected:
                                controller.tractorIssueList![index].isSelected,
                            tractorModel: controller.tractorIssueList?[index],
                          ),
                        );
                      })
                  : noDataFoundWidget()))
        ],
      ),
    );
  }
}
