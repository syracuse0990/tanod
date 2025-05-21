import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../create_group/controller/create_group_controller.dart';
import '../../create_group/views/state_view.dart';
import '../controller/issue_type_controller.dart';

class AddUpdateIssueView extends GetView<IssueTypeController> {
  IssueType? issueTypeModel;
  int? index;

  AddUpdateIssueView({this.issueTypeModel,this.index, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (issueTypeModel != null) {
        controller.isUpdating.value = true;

        controller.updatedIssueModel.value = issueTypeModel;
        controller.currentIndex.value = index!;
        controller.updatedIssueModel.refresh();
        controller.isUpdating.refresh();
        controller.titleController.text = issueTypeModel?.title ?? "";
        controller.selectState.value = getStateTitle(issueTypeModel?.stateId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: TractorBackArrowBar(
            firstLabel: controller.isUpdating.isTrue
                ? AppStrings.updateIssueTitle
                : AppStrings.addIssueTitle,
            firstTextStyle: TextStyle(
              fontFamily:
                  GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                      .fontFamily,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTextField,
                SizedBox(
                  height: 20.h,
                ),
                selectStateText,
                SizedBox(
                  height: 10.h,
                ),
                selectState,
                SizedBox(
                  height: 50.h,
                ),
                saveButton
              ],
            ),
          ),
        ));
  }

  Widget get titleTextField => TractorTextfeild(
        controller: controller.titleController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.issueTitle,
      );

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
        StateModel? stateModel = await Get.to(StateViewScreen());
        if (stateModel != null) {
          controller.selectState.value = stateModel.title ?? "";
          controller.selectState.refresh();
        }
      }));

  Widget get saveButton => TractorButton(
        text:
            controller.isUpdating.isTrue ? AppStrings.update : AppStrings.save,
        onTap: () {
          if (controller.isUpdating.isTrue) {
            controller.hitApiToUpdateTitle(
                id: controller.updatedIssueModel.value?.id,index: controller.currentIndex.value);
          } else {
            controller.hitApiToAddNewTitle();
          }
        },
      );
}
