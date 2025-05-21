
import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/maintenance_detail_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../../admin_modules/create_group/controller/create_group_controller.dart';
import '../../../admin_modules/create_group/views/state_view.dart';
import '../../controller/maintenance_controller.dart';

class ChangeMaintenanceStateView extends GetView<MaintenanceController> {
  MaintenanceDetailModel? maintenanceDetailModel;
  ChangeMaintenanceStateView({this.maintenanceDetailModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.changeStates,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectStateText,
            SizedBox(
              height: 10.h,
            ),
            selectState,
            SizedBox(
              height: 15.h,
            ),
            Obx(() => controller.selectState.value == AppStrings.completed ||
                    controller.selectState.value == AppStrings.cancelled
                ? conclusionTextField
                : SizedBox()),
            SizedBox(
              height: 100.h,
            ),
            saveButton
          ],
        ),
      ),
    );
  }

  Widget get selectStateText => TractorText(
        text: AppStrings.selectState,
        fontSize: 14.sp,
        color: AppColors.lightGray,
        fontWeight: FontWeight.w500,
      );

  Widget get selectState => Obx(() => CommonTractorTileView(
      title: controller.selectState.value,
      onTab: () async {
        if (!Get.isRegistered<CreateGroupController>()) {
          Get.put(CreateGroupController());
        }
        StateModel? stateModel = await Get.to(StateViewScreen(
          isUpdatedList: true,
          stateList: controller.stateList?.value,
        ));
        if (stateModel != null) {
          controller.selectState.value = stateModel.title ?? "";
          controller.selectState.refresh();
        }
      }));

  Widget get conclusionTextField => SizedBox(
        height: Get.height * 0.13,
        child: TextField(
          maxLines: 100,
          controller: controller.conclusionController,
          cursorColor: AppColors.primary,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 18.sp,
              color: AppColors.primary,
              height: 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
            floatingLabelAlignment: FloatingLabelAlignment.center,
            hintText: AppStrings.enterYourConclusion,
            filled: true,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.lightGray.withOpacity(0.5),
              height: 0.0,
              fontFamily:
                  GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                      .fontFamily,
            ),
            fillColor: AppColors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lightGray.withOpacity(0.2),
              ),
            ),
            focusColor: AppColors.lightGray.withOpacity(0.2),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      );

  Widget get saveButton => TractorButton(
    text: AppStrings.save,
    onTap: () {
      int id=getMaintenanceId(controller.selectState.value);

      if(id==APIEndpoint.statesCancelled||id==APIEndpoint.statesCompleted){
        controller.hitApiToChangeState(id:maintenanceDetailModel?.id,stateId: id);

      }else{
        controller.hitApiToChangeMaintenanceState(id:maintenanceDetailModel?.id,stateId: id);
      }

    },
  );
}
