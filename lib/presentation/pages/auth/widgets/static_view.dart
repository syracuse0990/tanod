import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tanod_tractor/presentation/pages/auth/controller/auth_controller.dart';

import '../../../../app/util/export_file.dart';

class StaticPages extends GetView<AuthController> {
  String ? title;
  int? type;
  StaticPages({this.title,this.type,super.key}){
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.hitApiToGetDetails(pageType: type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel:title??"",
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Obx(() => SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Text(
              controller.detailDataModel.value?.title??"",
              style: TextStyle(
                  fontSize: 26.sp,
                  color: AppColors.black,
                  fontFamily:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
            ),
        
            SizedBox(height: 20.h,),
            HtmlWidget(controller.detailDataModel.value?.description??"")
        
          ],
        ),
      )),
    );
  }
}
