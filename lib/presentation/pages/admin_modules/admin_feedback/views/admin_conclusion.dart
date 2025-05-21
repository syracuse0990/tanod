import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../create_group/controller/create_group_controller.dart';
import '../../create_group/views/state_view.dart';
import '../controllers/admin_feedback_controller.dart';

class AdminConclusionView extends GetView<AdminFeedbackController> {
  FeedbackDetailModel? feedbackDetailModel;

  AdminConclusionView({this.feedbackDetailModel, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (feedbackDetailModel != null) {
        controller.conclusionController.text = feedbackDetailModel?.conclusion ?? "";
        controller.technicalController.text = feedbackDetailModel?.techDetails ?? "";
        controller.selectState.value =
            getAllStateTitles(feedbackDetailModel?.issueType?.stateId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: feedbackDetailModel?.conclusion == null
            ? AppStrings.addConclusion
            : AppStrings.updateConclusion,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const TractorText(text: AppStrings.technicalDetails),
            AddSpace.vertical(20.h),
            technicalDetailTextField,
            AddSpace.vertical(20.h),
            const TractorText(text: AppStrings.conclusion),
            AddSpace.vertical(20.h),
            conclusionTextField,
            AddSpace.vertical(20.h),
            selectStateText,
            AddSpace.vertical(20.h),
            selectState,
            AddSpace.vertical(100.h),
            saveButton
          ],
        ),
      ),
    );
  }


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


  Widget get technicalDetailTextField => SizedBox(
        height: Get.height * 0.13,
        child: TextField(
          maxLines: 100,
          controller: controller.technicalController,
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
            hintText: AppStrings.technicalDetails,
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

  Widget get saveButton => TractorButton(
        text: feedbackDetailModel?.conclusion == null
            ? AppStrings.save
            : AppStrings.update,
        onTap: () {
          controller.hitApiToAddConclusion(id: feedbackDetailModel?.id);
        },
      );
}
