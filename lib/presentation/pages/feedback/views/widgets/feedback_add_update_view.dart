import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/feedback/controllers/feedback_controller.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import '../../../common_modules/devices/views/mutiple_image_view.dart';

class AddUpdateFeedbackView extends GetWidget<FeedbackController> {
  bool? isUpdating;
  int? selectedIndex;
  FeedbackDetailModel? feedbackDetailModel;

  AddUpdateFeedbackView(
      {this.isUpdating = false,this.selectedIndex, this.feedbackDetailModel, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (isUpdating != null) {
        if(isUpdating==false){
          controller.hitApiToGetUserDetails();
          return;
        }
        controller.isUpdating.value = isUpdating!;
        if(selectedIndex!=null){
          controller.selectedIndex.value = selectedIndex!;
        }

        controller.updatingId.value = feedbackDetailModel?.id?.toString()??"";
        controller.update();
        controller.showDataOnFields(feedbackDetailModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: controller.isUpdating.isTrue
              ? AppStrings.updateFeedback
              : AppStrings.addFeedback,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TractorText(text: 'Name'),
              TractorTextfeild(
                controller: controller.nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                hint: 'Your Name',
              ),
              AddSpace.vertical(30.h),
              const TractorText(text: 'Email'),
              TractorTextfeild(
                controller: controller.emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                hint: 'Your Email',
              ),
              AddSpace.vertical(30.h),
              const TractorText(text: 'Issue Type'),
              Obx(
                () => TractorTextfeild(
                  isSufix: true,
                  suffixWidget: GestureDetector(
                    onTap: () async {
                      var result = await Get.toNamed(
                          RoutePage.adminAddIssueTitle,
                          arguments: {
                            "from_user": true,
                            "id": controller.selectedIssueId.value
                          });

                      if (result != null) {
                        controller.selectedIssueId.value =
                            result.id!.toString();
                        controller.issueTypeController.value.text =
                            result?.title ?? "";
                        controller.update();
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primary,
                      size: 20.r,
                    ),
                  ),
                  suficIconHeight: 1.h,
                  readOnly: true,
                  controller: controller.issueTypeController.value,
                  hint: 'Select Issue Type',
                ),
              ),
              AddSpace.vertical(30.h),
              const TractorText(text: 'Description'),
              AddSpace.vertical(20.h),
              SizedBox(
                height: Get.height * 0.13,
                child: TextField(
                  maxLines: 100,
                  controller: controller.descriptionController,
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
                    hintText: 'Please Describe issue',
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.lightGray.withOpacity(0.5),
                      height: 0.0,
                      fontFamily: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500)
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
              ),
              AddSpace.vertical(20.h),
              Obx(
                    () => MultipleImageView(
                    imageList: controller.imageList.value,
                    onPlusTab: () {
                      if (controller.imageList.value.length < 5) {
                        controller.showImageDialog();
                      } else {
                        showToast(message: AppStrings.imageUploadLimit);
                      }
                    },
                    onCancelTab: (index) {
                      controller.imageList.removeAt(index);
                      controller.imageList.refresh();
                    }),
              ),
              Spacer(),
              TractorButton(
                text: controller.isUpdating.isTrue
                    ? AppStrings.update
                    : AppStrings.save,
                onTap: () {
                  if (controller.isUpdating.isTrue) {
                    controller.hitApiToUpdateFeedback(id: controller.updatingId.value,index: controller.selectedIndex.value );
                  } else {
                    controller.hitApiToCreateFeedback();
                  }
                },
              ),
              AddSpace.vertical(20.h),
            ],
          ),
        )));
  }
}
