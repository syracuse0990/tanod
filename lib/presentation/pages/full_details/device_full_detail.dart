import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../app/util/export_file.dart';

class DeviceFullDetails extends StatelessWidget {
  DevicesModel? devicesModel;

  DeviceFullDetails({this.devicesModel, super.key}){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.allDetails,
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
        child: detailWidget,
      ),
    );
  }


  Widget get detailWidget=>Container(
    padding: EdgeInsets.all(10.r),
    margin: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
        border:
        Border.all(color: Colors.grey.withOpacity(0.3), width: 0.9.w),
        borderRadius: BorderRadius.circular(10.r)),
    child: Column(
      children: [
        itemViewWidget(
            title: AppStrings.deviceName,
            value: devicesModel?.deviceName ?? ""),
        itemViewWidget(
            title: AppStrings.deviceModel,
            value: devicesModel?.deviceModal ?? ""),
        itemViewWidget(
            title: AppStrings.imei,
            value: devicesModel?.imeiNo?.toString() ?? ""),

        itemViewWidget(
            title: AppStrings.sim,
            value: devicesModel?.sim?.toString() ?? ""),
        itemViewWidget(
            title: AppStrings.expirationDate,
            value: devicesModel?.expirationDate),

        itemViewWidget(
            title: AppStrings.subscriptionExpiration,
            value:'${ devicesModel?.subscriptionExpiration??"0"} Years'),

        box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole
            ?itemViewWidget(
            title: AppStrings.createdBy,
            value: "Admin"):SizedBox(),

        box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole
            ? Padding(
          padding: EdgeInsets.only(top: 20.h),
          child:  underLineTextWidget(onTab: (){
            Get.toNamed(RoutePage.alertView,arguments: {"imei":devicesModel?.imeiNo});
          },txt: AppStrings.viewAlertDetails),
        ):SizedBox()

      ],
    ),
  );

  itemViewWidget({title, value}) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Text(
            title ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 13.sp),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }
}
