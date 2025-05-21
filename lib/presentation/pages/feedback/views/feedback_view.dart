import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/pages/feedback/controllers/feedback_controller.dart';
import 'package:tanod_tractor/presentation/pages/feedback/views/widgets/feedback_add_update_view.dart';

import '../../../../app/util/util.dart';
import '../../../../data/providers/network/api_endpoint.dart';
import 'widgets/feedback_tile_view.dart';

class FeedbackPage extends GetView<FeedbackController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: AppColors.white,),
          backgroundColor: AppColors.primary,
          onPressed: () {
            controller.clearAllFields();
            controller.isUpdating.value=false;
            Get.to(AddUpdateFeedbackView(
              isUpdating: false,
            ));
          },
        ),
        appBar: TractorBackArrowBar(
          firstLabel: 'Feedback',
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
            Expanded(
                child: Obx(() => controller.feedbackList?.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                    controller: controller.scrollController,
                        itemCount: controller.feedbackList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (controller.feedbackList![index].stateId ==
                                    APIEndpoint.stateActive) {
                                  Get.to(AddUpdateFeedbackView(
                                    isUpdating: true,
                                    selectedIndex: index,
                                    feedbackDetailModel: controller.feedbackList![index],
                                  ));
                                }
                              },
                              child: FeedbackTileView(
                                feedbackDetailModel:
                                    controller.feedbackList![index],
                              ));
                        })
                    : noDataFoundWidget()))
          ],
        ));
  }
}
