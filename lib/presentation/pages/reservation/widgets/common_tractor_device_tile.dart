import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/config/app_colors.dart';
import '../../../components/tractor_text.dart';

class CommonTractorTileView extends StatelessWidget {
  String? title;
  Function? onTab;
  bool? showArrow;

  CommonTractorTileView({this.title,this.showArrow=true, this.onTab, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onTab!=null){
          onTab!();
        }
      },
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
        child: Row(

          children: [
            Expanded(
              child: TractorText(
                text: title ?? "",
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            showArrow==true? Icon(
              Icons.arrow_forward_ios,
              size: 17.r,
              color: AppColors.black,
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
