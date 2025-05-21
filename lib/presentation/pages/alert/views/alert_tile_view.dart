import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../data/models/alert_detail_model.dart';
import 'alter_other_details.dart';





class AlertTileWidget extends StatelessWidget {
  AlertDetailModel? alertDetailModel;
   AlertTileWidget( {
    super.key,
     this.alertDetailModel
  });
   
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(18.r),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 42.r,
                  backgroundColor: AppColors.red,
                  child: SvgPicture.asset(
                    AppSvgAssets.alerts,
                    height: 40.r,
                    colorFilter: ColorFilter.mode(
                        AppColors.white, BlendMode.srcATop),
                  ),
                ),
                AddSpace.horizontal(10.w),
                Expanded(
                  child: TractorText(
                    text: alertDetailModel?.alarmName??"",
                    fontSize: 16.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 20.w),
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      color:
                      AppColors.lightGray.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: AppColors.lightGray
                              .withOpacity(0.3))),
                  child: TractorText(
                    text:DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.parse( alertDetailModel?.alarmTime??"")),
                    fontSize: 12.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 1.h,
            height: 2.h,
          ),
          Container(
            padding: EdgeInsets.all(22.r),
            child: Column(
              children: [
                Row(
                
                  children: [
                    Expanded(
                      child: TractorText(
                        text: alertDetailModel?.deviceName??"",
                        fontSize: 12.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width:10.w,),
                    
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 5.h, horizontal: 12.w),
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color:  AppColors.lightGray.withOpacity(0.1),
                      ),
                      child: TractorText(
                        text: alertDetailModel?.imei?.toString()??"",
                        fontSize: 14.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),




        ],
      ),
    );
  }
}

