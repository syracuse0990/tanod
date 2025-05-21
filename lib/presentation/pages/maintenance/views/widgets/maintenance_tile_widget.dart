import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../../data/models/maintenance_detail_model.dart';
import '../../controller/maintenance_controller.dart';
import '../issue_maintenance_page.dart';
import 'maintenance_detail_view.dart';

class MaintenanceTileWidget extends GetWidget<MaintenanceController> {
  MaintenanceDetailModel? maintenanceDetailModel;
  int? index;

  MaintenanceTileWidget({
    super.key,
    this.maintenanceDetailModel,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r)),
                color: maintenanceDetailModel?.stateId ==
                        APIEndpoint.statesCancelled
                    ? Colors.red
                    : AppColors.primary.withOpacity(0.6)),
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                TractorText(
                  text: getMaintenanceTitles(maintenanceDetailModel?.stateId) ??
                      "",
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                controller.showPopUpMenuButton(onEditTab: () {
                  controller.selectedIndex.value=index!;
                  controller.selectedIndex.refresh();
                  Get.to(IssueMaintenancePage(
                    index: controller.selectedIndex.value ,
                      maintenanceDetailModel: maintenanceDetailModel));
                }, onDetailTab: () {
                  Get.to(() => MaintenanceView(
                        id: maintenanceDetailModel?.id,
                    maintenanceDetailModel:maintenanceDetailModel ,
                      ));
                }, onDeleteTab: () {
                  controller.hitApiToDeleteMaintenance(
                      id: maintenanceDetailModel?.id, index: index);
                })
              ],
            ),
          ),
          rowTitleWidget(
              title: AppStrings.tractorName ?? "",
              value: maintenanceDetailModel?.tractor?.noPlate),
          SizedBox(
            height: 10.h,
          ),
          rowTitleWidget(
              title: AppStrings.maintenanceDate ?? "",
              value: maintenanceDetailModel?.maintenanceDate ?? ""),
          SizedBox(
            height: 15.h,
          ),
          headerViewWidget(title: AppStrings.technicianDetails),
          rowTitleWidget(
              title: AppStrings.name ?? "",
              value: maintenanceDetailModel?.techName ?? ""),
          rowTitleWidget(
              title: AppStrings.email ?? "",
              value: maintenanceDetailModel?.techEmail ?? ""),
          rowTitleWidget(
              title: AppStrings.number ?? "",
              value: maintenanceDetailModel?.techNumber ?? ""),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }

  headerViewWidget({title}) {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
