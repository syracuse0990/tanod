import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/static_page_data_model.dart';
import '../controller/static_page_controller.dart';
import 'admin_static_page_title_view.dart';

class AdminStaticDetailView extends GetView<StaticPageController> {
  StaticPageDataModel? staticPageDataModel;

  AdminStaticDetailView({super.key, this.staticPageDataModel}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (staticPageDataModel != null) {
        controller.hitApiToGetDetails(pageType: staticPageDataModel?.pageType);
      }
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
            Obx(
              () => AdminPageStaticTileView(
                showMenuBar: false,
                showDescription: true,
                staticPageDataModel: controller.detailDataModel.value,
              ),
            )
          ],
        ),
      ),
    );
  }
}
