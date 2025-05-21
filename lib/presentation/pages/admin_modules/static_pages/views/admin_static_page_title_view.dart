import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:readmore/readmore.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/static_page_data_model.dart';
import '../controller/static_page_controller.dart';
import 'admin_static_detail_view.dart';
import 'update_static_page_view.dart';

class AdminPageStaticTileView extends GetView<StaticPageController> {
  int? index;
  StaticPageDataModel? staticPageDataModel;
  bool showMenuBar=true;
  bool showDescription=false;


  AdminPageStaticTileView({this.index, this.staticPageDataModel,this.showDescription=false,this.showMenuBar=true, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTitleAndValue(
                    title: '${AppStrings.titleTxt} :- ',
                    value: staticPageDataModel?.title ?? ""),
                showTitleAndValue(
                    title: '${AppStrings.pageType} :- ',
                    value: getPagesTitle(
                        staticPageDataModel?.pageType)),

                showTitleAndValue(
                    title: '${AppStrings.createdBy} :- ',
                    value:   staticPageDataModel?.createdBy?.name??""),

                showDescription?Text(
                  '${AppStrings.description} :- ',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                      fontFamily:
                      GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
                ):SizedBox(),


                showDescription? HtmlWidget(staticPageDataModel?.description?.toString() ?? "",):SizedBox()
              ],
            ),
          ),
          showMenuBar==true?controller.showPopUpMenuButton(onDetailTab: () {
            Get.to(AdminStaticDetailView(
              staticPageDataModel: staticPageDataModel,
            ));
          }, onDeleteTab: () {
            controller.hitApiToDeletePage(
                index: index, id: staticPageDataModel?.id);
          },onEditTab: (){
            Get.to(() => CreateStaticPageView(staticPageDataModel:staticPageDataModel ,));
          }):SizedBox()
        ],
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
        ),
        Expanded(
            child: ReadMoreText(
          value ?? "",
          trimLines: 2,
          colorClickableText: Colors.red,
          trimMode: TrimMode.Line,
          trimCollapsedText: AppStrings.showMore,
          trimExpandedText: AppStrings.showLess,
          style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[800],
              fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
          moreStyle: TextStyle(
              fontSize: 12.r,
              fontWeight: FontWeight.w900,
              color: AppColors.primary),
        ))
      ],
    );

  }


 }
