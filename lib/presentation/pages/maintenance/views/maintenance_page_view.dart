import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/maintenance/views/widgets/maintenance_search_header_view.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../controller/maintenance_controller.dart';
import 'widgets/fliter_maintenance_view.dart';
import 'widgets/maintenance_tile_widget.dart';

class MaintenancePageView extends GetView<MaintenanceController> {
  const MaintenancePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(

        leading:Row(
          children: [
            GestureDetector(
              onTap:   () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_sharp,
                size: 25.r,
                color: AppColors.white,
              ),
            ),
            SizedBox(width:8.w,),
            SizedBox(
              width: Get.width * 0.63,
              child: const MaintenanceSearchView(),
            ),

          ],
        ),
        actions: [
          SizedBox(width:10.w,),
          Bounce(
            duration: const Duration(milliseconds: 180),
            onPressed: () {
              Get.to(FilterMaintenanceView());
            },
            child: CircleAvatar(
                radius: 15.r,
                backgroundColor: AppColors.white,
                child: SvgPicture.asset(
                  AppSvgAssets.adjust,
                  height: 15.h,
                )),
          ),
          AddSpace.horizontal(20.h),
          Bounce(
            duration: const Duration(milliseconds: 180),
            onPressed: () {
              controller.updatedMaintenanceModel.value = null;
              controller.clearAllFields();
              controller?.tractorList?.forEach((element) {
                element?.isSelected=false;
              });
              Get.toNamed(RoutePage.issueMaintenance);
            },
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => controller.maintenanceList?.value.length != 0
          ? ListView.builder(
              controller: controller.scrollController,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: controller.maintenanceList?.value.length ?? 0,
              itemBuilder: (context, index) {
                return MaintenanceTileWidget(
                  maintenanceDetailModel: controller.maintenanceList![index],
                  index: index,
                );
              })
          : noDataFoundWidget()),
    );
  }
}
