import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/admin_booking_model.dart';

class AdminBookingTileView extends StatelessWidget {
  BookingModel? tractorModel;
  bool? isSelected;
  Function? onAccepted, onRejected;

  AdminBookingTileView(
      {this.tractorModel,
      this.isSelected,
      this.onAccepted,
      this.onRejected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: isSelected == null
                  ? AppColors.lightGray.withOpacity(0.3)
                  : isSelected == true
                      ? AppColors.authGradientTop
                      : AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showTitleAndValue(
              title: '${AppStrings.farmer} :- ',
              value:  tractorModel?.createdBy?.name?? tractorModel?.createdBy?.email??""),
          showTitleAndValue(
              title: '${AppStrings.tractor} :- ',
              value:"${ tractorModel?.tractor?.idNo?.toString() }-${tractorModel?.tractor?.model?.toString()}"),
          showTitleAndValue(
              title: '${AppStrings.device} :- ',
              value: tractorModel?.device?.deviceName?.toString() ?? ""),
          showTitleAndValue(
              title: '${AppStrings.date} :- ',
              value: tractorModel?.date?.toString()),
          showTitleAndValue(
              title: '${AppStrings.state} :- ',
              value: getBookingStateTitle(tractorModel?.stateId)),
          tractorModel?.stateId?.toString() == AppStrings.activeId?.toString()
              ? SizedBox(
                  height: 15.h,
                )
              : SizedBox(),
          tractorModel?.stateId?.toString() == AppStrings.activeId?.toString()
              ? acceptRejectButton
              : SizedBox()
        ],
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value ?? "",
      firstTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
      lastTextStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[800],
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
    );
  }

  Widget get acceptRejectButton => Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onAccepted != null) {
                onAccepted!();
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: Center(
                child: Text(
                  "Accept",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(7.r)),
            ),
          )),
          SizedBox(
            width: 50.w,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onRejected != null) {
                onRejected!();
              }
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(7.r)),
            ),
          )),
        ],
      );
}
