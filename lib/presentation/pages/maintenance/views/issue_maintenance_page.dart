import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/pages/maintenance/views/widgets/maintenace_form_widget.dart';

import '../../../../data/models/maintenance_detail_model.dart';
import '../controller/maintenance_controller.dart';

class IssueMaintenancePage extends GetView<MaintenanceController> {
  MaintenanceDetailModel? maintenanceDetailModel;
  int? index;

  IssueMaintenancePage({this.maintenanceDetailModel, this.index, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (maintenanceDetailModel != null) {
        controller.updatedMaintenanceModel.value = maintenanceDetailModel;
        controller.selectedIndex.value = index ?? 0;
        controller.selectedIndex.refresh();
        controller.updatedMaintenanceModel.refresh();
        controller.showDetailsOnFields();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: AppStrings.issueMaintenance,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Obx(() => MaintenanceFormWidget(
              maintenanceDetailModel: controller.updatedMaintenanceModel.value,
              index:index,
            )));
  }
}
