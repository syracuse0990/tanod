import '../../../../app/util/export_file.dart';
import '../../../../data/models/alert_detail_model.dart';

class AlertOtherDetailsView extends StatelessWidget {
  AlertDetailModel? alertDetailModel;
  AlertOtherDetailsView({this.alertDetailModel,super.key});

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
            _personalInformationWidget,
            SizedBox(height: 20.h,),
            _deviceInformationWidget
          ],
        ),
      ),
    );
  }


  Widget get _deviceInformationWidget =>
      Column(
        children: [
          headerViewWidget(title: AppStrings.deviceDetails),
          deviceDetailWidget
        ],
      );


  Widget get _personalInformationWidget =>
      Column(
        children: [
          headerViewWidget(title: AppStrings.personalDetails),
          detailWidget
        ],
      );

  headerViewWidget({title}) {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
          color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }



  Widget get deviceDetailWidget =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r)),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitleAndValue(
                title: 'IMEI Number :- ',
                value: alertDetailModel?.deviceDetail?.imeiNo?.toString() ?? ""),
            showTitleAndValue(
                title: 'Device Model :- ',
                value: alertDetailModel?.deviceDetail?.deviceModal?.toString() ?? ""),
            showTitleAndValue(
                title: 'Device Name :- ',
                value: alertDetailModel?.deviceDetail?.deviceName?.toString() ?? ""),
            showTitleAndValue(
                title: 'Subscription Expiration :- ',
                value: alertDetailModel?.deviceDetail?.subscriptionExpiration?.toString() ?? ""),

            showTitleAndValue(
                title: 'State :- ',
                value: alertDetailModel?.deviceDetail?.stateId?.toString() == "1"
                    ? AppStrings.active
                    : alertDetailModel?.deviceDetail?.stateId?.toString() == "0"
                    ? AppStrings.inactive
                    : AppStrings.delete,
                color: alertDetailModel?.deviceDetail?.stateId?.toString() == "1"
                    ? Colors.grey[800]
                    : alertDetailModel?.deviceDetail?.stateId?.toString() == "0"
                    ? Colors.black
                    : Colors.red),

          ],
        ),
      );


  Widget get detailWidget =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r)),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showTitleAndValue(
                title: '${AppStrings.name} :- ',
                value: alertDetailModel?.createdBy?.name??""),
            showTitleAndValue(
                title: '${AppStrings.email} :- ',
                value: alertDetailModel?.createdBy?.email??""),
            showTitleAndValue(
                title: '${AppStrings.phone} :- ',
                value:alertDetailModel?.createdBy?.phone?.toString()??""),
            showTitleAndValue(
                title: '${AppStrings.gender} :- ',
                value: alertDetailModel?.createdBy?.gender ==
                    APIEndpoint.male ? AppStrings.male :alertDetailModel?.createdBy?.gender == APIEndpoint.female
                    ? AppStrings.female:AppStrings.notDefined),

          ],
        ),
      );



  showTitleAndValue({title, value,color}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value?.toString() ?? "",
      firstTextStyle: TextStyle(
          fontSize: 14.sp,
           color: color ?? AppColors.black,
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

}
