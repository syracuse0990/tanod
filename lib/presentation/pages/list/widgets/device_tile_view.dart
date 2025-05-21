import '../../../../app/util/export_file.dart';
import '../../full_details/device_full_detail.dart';

class DeviceTileView extends StatelessWidget {
  DevicesModel? devicesModel;
  bool? isSelected;
  bool? isAdmin;
  bool? hideActionButton = false;
  Function? onViewTab, onDeleteTab;
  EdgeInsets? margin;
  double? borderRadius;
  Function? onSelected;

  DeviceTileView(
      {this.onSelected,
      this.isAdmin = false,
      this.margin,
      this.borderRadius,
      this.hideActionButton = false,
      this.devicesModel,
      this.onDeleteTab,
      this.onViewTab,
      this.isSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          border: Border.all(
              color: isSelected == null
                  ? AppColors.lightGray.withOpacity(0.3)
                  : isSelected == true
                      ? AppColors.authGradientTop
                      : AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTitleAndValue(
                    title: 'IMEI Number :- ',
                    value: devicesModel?.imeiNo?.toString() ?? ""),
                showTitleAndValue(
                    title: 'SIM Number :- ',
                    value: devicesModel?.sim?.toString() ?? ""),
                showTitleAndValue(
                    title: 'Device Model :- ',
                    value: devicesModel?.deviceModal?.toString() ?? ""),
                showTitleAndValue(
                    title: 'Device Name :- ',
                    value: devicesModel?.deviceName?.toString() ?? ""),
                showTitleAndValue(
                    title: 'Subscription Expiration :- ',
                    value:
                        devicesModel?.subscriptionExpiration?.toString() ?? ""),
                showTitleAndValue(
                    title: 'State :- ',
                    value: devicesModel?.stateId?.toString() == "1"
                        ? AppStrings.active
                        : devicesModel?.stateId?.toString() == "0"
                            ? AppStrings.inactive
                            : AppStrings.delete,
                    color: devicesModel?.stateId?.toString() == "1"
                        ? Colors.grey[800]
                        : devicesModel?.stateId?.toString() == "0"
                            ? Colors.black
                            : Colors.red),
              ],
            ),
          ),
          isAdmin == true
              ? showDetailMenuOnly()
              :             box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole

              ? showPopUpMenuButton()
                  : SizedBox(),
          devicesModel?.isLongPressed == true
              ? GestureDetector(
                  onTap: () {
                    if (onSelected != null) {
                      onSelected!();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColors.primary),
                    child: devicesModel?.isSelected == true
                        ? Icon(
                            Icons.done,
                            size: 15,
                            color: Colors.white,
                          )
                        : SizedBox(
                            height: 15,
                            width: 15,
                          ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  showTitleAndValue({title, value, color}) {
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
          color: color ?? Colors.grey[800],
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
    );
  }

  showPopUpMenuButton() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            Get.to(DeviceFullDetails(
              devicesModel: devicesModel,
            ));
          },
          value: 0,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.viewDetails),
        ),
        if(box.read(roleType) == APIEndpoint.aminRole)
        PopupMenuItem(
          onTap: () {
            if (onViewTab != null) {
              onViewTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.update),
        ),
        if(box.read(roleType) == APIEndpoint.aminRole)
        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteTxt),
        )
      ],
    );
  }

  showDetailMenuOnly() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            Get.to(DeviceFullDetails(
              devicesModel: devicesModel,
            ));
          },
          value: 0,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.viewDetails),
        ),
      ],
    );
  }
}
