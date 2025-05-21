import '../../../../../app/util/export_file.dart';
import '../../../feedback/views/widgets/feedback_tile_view.dart';
import '../controllers/admin_feedback_controller.dart';
import 'admin_feedback_detail_view.dart';

class AdminFeedbackPage extends GetView<AdminFeedbackController> {
  const AdminFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          actions: [
            exportWidget((){
              controller.hitApiToExportFeedbackReports();
            }),

          ],
          firstLabel: AppStrings.tractorReports,
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
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        itemCount: controller.feedbackList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(AdminFeedbackDetailView(
                                  model: controller.feedbackList![index],
                                ));
                              },
                              child: FeedbackTileView(
                                isAdmin: true,
                                feedbackDetailModel:
                                    controller.feedbackList![index],
                              ));
                        })
                    : noDataFoundWidget()))
          ],
        ));
  }
}
