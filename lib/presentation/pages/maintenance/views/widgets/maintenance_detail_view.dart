import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/maintenance/views/widgets/tractor_detail_view.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/maintenance_detail_model.dart';
import '../../controller/maintenance_controller.dart';
import 'change_maintance_view.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  var id;
  MaintenanceDetailModel? maintenanceDetailModel;

  MaintenanceView({this.id, this.maintenanceDetailModel,super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.hitApiToViewMaintenanceDetails(id: id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.details,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            headerViewWidget(title: AppStrings.maintenanceDetails),
            maintenanceWidget,
            SizedBox(
              height: 20.h,
            ),
            headerViewWidget(title: AppStrings.tractDetails),
            tractorDetailsWidget,
            SizedBox(
              height: 20.h,
            ),
            changeStateWidget()
          ],
        ),
      ),
    );
  }

  Widget get maintenanceWidget => Obx(() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r)),
            border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
        child: Column(
          children: [
            rowTitleWidget(
              title: AppStrings.tractorName ?? "",
              value: controller.maintenanceModel.value?.tractor?.noPlate.toString()??"",
            ),
            SizedBox(
              height: 5.h,
            ),
            rowTitleWidget(title: AppStrings.maintenanceDate ?? "",  value: controller.maintenanceModel.value?.maintenanceDate??"",),
            SizedBox(
              height: 5.h,
            ),
            rowTitleWidget(title: AppStrings.name ?? "",  value: controller.maintenanceModel.value?.techName??""),
            SizedBox(
              height: 5.h,
            ),
            rowTitleWidget(title: AppStrings.email ?? "",  value: controller.maintenanceModel.value?.techNumber??""),
            SizedBox(
              height: 5.h,
            ),
            rowTitleWidget(title: AppStrings.number ?? "", value:  controller.maintenanceModel.value?.techEmail??""),
            SizedBox(
              height: 5.h,
            ),
            rowTitleWidget(title: AppStrings.state ?? "", value: getMaintenanceTitles(controller.maintenanceModel.value?.stateId)),

            Obx(() => controller.maintenanceModel.value?.stateId == APIEndpoint.statesCompleted ||
                controller.maintenanceModel.value?.stateId == APIEndpoint.statesCancelled
                ? rowTitleWidget(title: AppStrings.conclusion ?? "", value:controller.maintenanceModel.value?.conclusion)
                : SizedBox()),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ));

  headerViewWidget({title}) {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
          color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget get tractorDetailsWidget =>Obx(() =>  Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8.r),
            bottomLeft: Radius.circular(8.r)),
        border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
    child: Column(
      children: [TractorDetailView(tractorModel:controller.maintenanceModel.value?.tractor ,)],
    ),
  ));



  changeStateWidget({title}) {
    return GestureDetector(

     onTap: (){
       Get.to(ChangeMaintenanceStateView(maintenanceDetailModel: maintenanceDetailModel,));
     },
      child: Container(
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            color: AppColors.primary),
        child: Center(
          child: TractorText(
            text: AppStrings.changeStates,
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
