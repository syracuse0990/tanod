import '../../../../../app/util/export_file.dart';
import '../controller/static_page_controller.dart';
import 'admin_static_page_title_view.dart';

class AdminStaticPageView extends GetView<StaticPageController> {
  AdminStaticPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.staticPages,
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
          children: [
            Obx(() => Expanded(
                child: controller.pagesList?.value.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.pagesList?.value.length ?? 0,
                        itemBuilder: (context, index) {
                          return AdminPageStaticTileView(
                            index: index,
                            showDescription: false,
                            staticPageDataModel: controller.pagesList?[index!],
                          );
                        })
                    : noDataFoundWidget()))
          ],
        ),
      ),
    );
  }
}
