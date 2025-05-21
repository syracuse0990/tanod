import 'package:flutter_svg/svg.dart';

import '../../../../../app/util/export_file.dart';
import '../../controller/maintenance_controller.dart';

class MaintenanceSearchView extends GetWidget<MaintenanceController> {
  const MaintenanceSearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.searchController,
      cursorColor: AppColors.white,
      style: GoogleFonts.plusJakartaSans(
        textStyle: TextStyle(
          fontSize: 18.sp,
          color: AppColors.white,
          height: 1.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      onChanged: (text) {
        controller.maintenanceList?.clear();
        controller.hitApiToGetAllMaintenanceList();
      },
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
          floatingLabelAlignment: FloatingLabelAlignment.center,
          hintText: AppStrings.searchByTractorName,
          filled: true,
          hintStyle: TextStyle(
            fontSize: 15.sp,
            color: AppColors.white.withOpacity(0.5),
            height: 0.0,
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
          ),
          fillColor: AppColors.white.withOpacity(0.1),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          prefixIcon: Container(
            padding: EdgeInsets.all(8.r),
            margin: EdgeInsets.only(right: 8.w),
            child: SvgPicture.asset(
              AppSvgAssets.search,
              height: 23.r,
              colorFilter: ColorFilter.mode(
                  AppColors.lightGray.withOpacity(0.1), BlendMode.srcATop),
            ),
          ),
          border: InputBorder.none),
    );
  }
}
