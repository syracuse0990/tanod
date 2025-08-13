import 'package:tanod_tractor/presentation/pages/full_details/common_controller.dart';

import '../../../../app/util/export_file.dart';
import '../../full_details/tractor_full_details.dart';

class TractorTileView extends StatelessWidget {
  TractorModel? tractorModel;
  bool? isSelected;
  Function? onViewTab, onDeleteTab;
  bool? isAdmin;
  bool? isFromMaintenance = false;
  EdgeInsets? margin;
  double? borderRadius;
  Function? onSelected;

  TractorTileView(
      {this.tractorModel,
      this.isSelected,
      this.isAdmin,
      this.margin,
      this.isFromMaintenance = false,
      this.onViewTab,
      this.onSelected,
      this.borderRadius,
      this.onDeleteTab,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
            child: Row(
              children: [
                tractorModel?.images != null &&
                        tractorModel?.images?.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: cacheNetworkImage(
                            url:
                                '${APIEndpoint.imageUrl}${tractorModel?.images?.first.path}',
                            height: 115.h,
                            width: 110.w),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          AppPngAssets.noImageFound,
                          height: 115.h,
                          width: 110.w,
                          fit: BoxFit.fill,
                        )),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTitleAndValue(
                        title: '${AppStrings.numberPlate} :- ',
                        value: tractorModel?.noPlate?.toString() ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.idNumber} :- ',
                        value: tractorModel?.idNo?.toString() ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.fuelPerKm} :- ',
                        value: tractorModel?.fuelConsumption?.toString() ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.tractorBrand} :- ',
                        value: tractorModel?.brand?.toString() ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.tractorModel} :- ',
                        value: tractorModel?.model?.toString() ?? ""),
                  ],
                ))
              ],
            ),
          ),
          isFromMaintenance == true
              ? SizedBox()
              : isAdmin == true 
                  ? showDetailMenuOnly()
                  :             box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole || box.read(roleType) == APIEndpoint.technicianRole

              ? showPopUpMenuButton()
                      : SizedBox(),
          tractorModel?.isLongPressed == true
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
                    child: tractorModel?.isSelected == true
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

  showPopUpMenuButton() {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (!Get.isRegistered<CommonController>()) {
              Get.lazyPut(() => CommonController());
            }
            Get.to(TractorFullDetails(
              tractorModel: tractorModel,
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
            if (!Get.isRegistered<CommonController>()) {
              Get.lazyPut(() => CommonController());
            }
            Get.to(TractorFullDetails(
              tractorModel: tractorModel,
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
