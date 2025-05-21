import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/admin_feedback/controllers/admin_feedback_controller.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import 'admin_conclusion.dart';

class AdminFeedbackDetailView extends GetView<AdminFeedbackController> {
  FeedbackDetailModel? model;


  AdminFeedbackDetailView({this.model, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(microseconds: 100),() =>  controller.hitApiToGetFeedbackDetails(id: model?.id),);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.details,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts
              .plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Obx(() =>
            Column(
              children: [
                conclusionWidget,
                controller.detailFeedbackModel.value != null &&
                    controller.detailFeedbackModel.value ?.images != null &&
                    controller.detailFeedbackModel.value ?.images?.length != 0
                    ? _allImageWidget
                    : loadingContainer,
                 SizedBox(height: 10.h,),
                 detailsCardWidget

              //,pendingStateWidget

              ],
            )),
      ),
    );
  }
  Widget get _allImageWidget => CarouselSlider(
      items: [
        for (int i = 0; i < controller.detailFeedbackModel.value !.images!.length; i++)
          Container(
            width: Get.width,
            margin: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.primary,width: 0.3.h)
            ),
            child: Image.network(
              '${APIEndpoint.imageUrl}${controller.detailFeedbackModel.value !.images![i].path}',
              height: Get.height * 0.3,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppPngAssets.noImageFound,
                  height: Get.height * 0.3,
                  fit: BoxFit.contain,
                );
              },
            ),
          )
      ],
      options: CarouselOptions(
        height: Get.height * 0.3,
        aspectRatio: 16 / 12,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (index, reason) {},
        scrollDirection: Axis.horizontal,
      ));

  Widget get loadingContainer=> Container(
    width: Get.width,
    height: Get.height * 0.3,
    margin: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primary,width: 0.3.h)
    ),
    child: noDataFoundWidget(msg: AppStrings.noImages),


  );

  Widget get detailsCardWidget =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitleAndValue(
                title: '${AppStrings.name} :- ',
                value: controller.detailFeedbackModel.value?.name ?? ""),
            showTitleAndValue(
                title: '${AppStrings.email} :- ',
                value: controller.detailFeedbackModel.value?.email ?? ""),
            showTitleAndValue(
                title: '${AppStrings.createdBy} :- ',
                value: controller.detailFeedbackModel.value?.createdBy?.name ??
                    controller.detailFeedbackModel.value?.createdBy?.email ??
                    ""),
            showTitleAndValue(
                title: '${AppStrings.state} :- ',
                value:    getIssueTypeTitle(controller.detailFeedbackModel.value?.stateId)),

            showTitleAndValue(
                title: '${AppStrings.issuesType} :- ',
                value: controller.detailFeedbackModel.value?.issueType?.title??""),
            showTitleAndValue(
                title: '${AppStrings.description} :- ',
                value: controller.detailFeedbackModel.value?.description ?? ""),
            controller.detailFeedbackModel.value?.conclusion != null
                ? showTitleAndValue(
                title: '${AppStrings.conclusion} :- ',
                value: controller.detailFeedbackModel.value?.conclusion ?? "")
                : SizedBox() ,

            controller.detailFeedbackModel.value?.techDetails != null
                ? showTitleAndValue(
                title: '${AppStrings.technicalDetails} :- ',
                value: controller.detailFeedbackModel.value?.techDetails ?? "")
                : SizedBox()
          ],
        ),
      );

  Widget get conclusionWidget =>
      Align(
        alignment: Alignment.topRight,
        child: TractorButton(
          fontSize: 12.sp,
          height: 35,
          width: Get.width * 0.4,
          text: controller.detailFeedbackModel.value?.conclusion != null
              ? AppStrings.updateConclusion
              : AppStrings.addConclusion,
          onTap: () {
            Get.to(AdminConclusionView(
              feedbackDetailModel: controller.detailFeedbackModel.value
                  ?.conclusion
                  ?.toString()
                  .isEmpty == true ? null : controller.detailFeedbackModel
                  .value,));
          },
        ),
      );

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value ?? "",
      firstTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontFamily:
          GoogleFonts
              .poppins(fontWeight: FontWeight.w600)
              .fontFamily),
      lastTextStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[800],
          fontFamily:
          GoogleFonts
              .poppins(fontWeight: FontWeight.w600)
              .fontFamily),
    );
  }


  Widget get pendingStateWidget {
    return Row(
      children: [
        buttonWidget(stateId: controller.detailFeedbackModel.value?.pendingStates?.first),
        buttonWidget(stateId: controller.detailFeedbackModel.value?.pendingStates![1])
      ],
    );
  }


  /*  pending_states: [3, 2]*/
/*  static int stateAccepted = 3;
  static int stateCompleted = 2;*/
  buttonWidget({stateId}) {
    print("check condition ${APIEndpoint.stateCompleted}");
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
           color: stateId==APIEndpoint.stateCompleted?AppColors.primary:stateId==2?Colors.red:Colors.lightBlue,
        borderRadius: BorderRadius.circular(10.r)
      ),
/*      child: Text("${stateId==APIEndpoint.stateCompleted?AppStrings.completed:stateId==2?AppStrings.closed:}"),*/

    );
  }


}
