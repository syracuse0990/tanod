import 'package:intl/intl.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/maintenance_detail_model.dart';
import '../../controller/maintenance_controller.dart';
import 'admin_select_tractor_view.dart';

class MaintenanceFormWidget extends GetWidget<MaintenanceController> {
  MaintenanceDetailModel? maintenanceDetailModel;
  int? index;

  MaintenanceFormWidget({
    this.maintenanceDetailModel,
    this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TractorText(text: AppStrings.tractor),
            SizedBox(
              height: 10.h,
            ),
            _selectTractors,
            AddSpace.vertical(20.h),
            const TractorText(text: AppStrings.maintenanceDates),
            GestureDetector(
              onTap: () async {
                await showDateTimePicker(
                    context: Get.context!,
                    isEnabled: false,
                    onChanged: (dateTime) async {
                      if (dateTime == null) {
                        return;
                      }

                      await showCustomTimePicker(Get.context!).then((value) {
                        if (value != null) {
                          String formattedTime = DateFormat('HH:mm').format(
                              DateTime(2022, 1, 1, value.hour, value.minute));
                          controller.maintenanceDateController.text =
                              '${DateFormat("yyyy-MM-dd").format(dateTime)} $formattedTime';
                          controller.update();
                        }
                      });
                    });
              },
              child: TractorTextfeild(
                controller: controller.maintenanceDateController,
                isEnabned: false,
                isSufix: true,
                suffixWidget: Icon(
                  Icons.calendar_month,
                  color: AppColors.primary,
                ),
                hint: AppStrings.maintenanceDates,
              ),
            ),
            AddSpace.vertical(30.h),
            TractorText(
              text: AppStrings.leadsTechnician,
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            AddSpace.vertical(30.h),
            const TractorText(text: AppStrings.technicianName),
            TractorTextfeild(
              controller: controller.nameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              hint: AppStrings.technicianName,
            ),
            AddSpace.vertical(30.h),
            const TractorText(text: AppStrings.technicianEmail),
            TractorTextfeild(
              controller: controller.emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              hint: AppStrings.technicianEmail,
            ),
            AddSpace.vertical(30.h),
            const TractorText(text: AppStrings.technicianPhoneNumber),
            TractorTextfeild(
              controller: controller.phnNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              hint: AppStrings.technicianPhoneNumber,
            ),
            AddSpace.vertical(100.h),

            // const Spacer(),
            Obx(() => TractorButton(
                  text: controller.updatedMaintenanceModel.value == null
                      ? AppStrings.submit
                      : AppStrings.update,
                  onTap: () {
                    if (controller.updatedMaintenanceModel.value != null) {
                      controller.hitApiToUpdateNewMaintenance(
                          id: controller.updatedMaintenanceModel.value?.id,
                          tractorId: controller
                              .updatedMaintenanceModel.value?.tractor?.id,
                          index: index);
                    } else {
                      controller.hitApiToCreateNewMaintenance(index);
                    }
                  },
                )),
            AddSpace.vertical(40.h),
          ],
        ),
      ),
    );
  }

  Widget get _selectTractors => Obx(() => CommonTractorTileView(
        title: controller.selectTractor.value,
        onTab: () async {

          TractorModel? data = await Get.to(AdminSelectTractorView());

          if (data != null) {
            controller.selectTractor.value = data?.idNo?.toString() ?? "";
            if(controller.updatedMaintenanceModel.value!=null){
             }
            controller.update();
          }
        },
      ));
}
