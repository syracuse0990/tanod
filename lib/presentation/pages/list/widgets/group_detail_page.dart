import 'package:flutter/scheduler.dart';


import '../../../../app/util/export_file.dart';
import 'booking_list_screen.dart';
import 'device_list_screen.dart';
import 'farmer_list_screen.dart';

class GroupDetailPage extends GetView<ListController> {
  int? index;

  GroupDetailPage({index}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (index != null) {
        controller.selectedGroupIndex.value = index;
        controller.selectedGroupIndex.refresh();
        print("check list length  ${index}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: 'Details',
        actions: [

          box.read(roleType) == APIEndpoint.aminRole
              ?
         Obx(() =>  _assignedView,):SizedBox()
        ],
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: DefaultTabController(
        length: controller.detailTabList.length,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: TabBar(
                overlayColor: MaterialStatePropertyAll(AppColors.white),
                indicatorColor: AppColors.primary,
                unselectedLabelColor: AppColors.lightGray,
                labelColor: AppColors.primary,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                labelStyle: TextStyle(
                  fontFamily:
                      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                          .fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily:
                      GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                          .fontFamily,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightGray,
                ),
                isScrollable: false,
                tabs: controller.detailTabList.map((title) {
                  return Tab(
                    text: title,
                  );
                }).toList(),
                onTap: controller.selectedDetailIndex,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () => FarmerListScreen(
                        farmerList: controller
                            .groupList?[controller.selectedGroupIndex.value]
                            .farmers),
                  ),
                  Obx(
                    () => TractorsListScreen(
                        tractorList: controller
                            .groupList?[controller.selectedGroupIndex.value]
                            .tractors,
                        isAdmin: true),
                  ),
                  Obx(
                    () => DeviceListScreen(
                        devicesList: controller
                            .groupList?[controller.selectedGroupIndex.value]
                            .devices,
                        isAdmin: true),
                  ),
                  Obx(() => BookingListScreen(
                        bookingList: controller
                            .groupList?[controller.selectedGroupIndex.value]
                            .bookings,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _assignedView => GestureDetector(
        onTap: () {
          if(  controller.groupList?[controller.selectedGroupIndex.value]
              .subAdmin !=
              null){
            controller.hitApiToAssignGroup(
              isAssigned:APIEndpoint.unAssignToSubAdmin,
              subAdminId: controller.groupList?[controller.selectedGroupIndex.value]
                  .subAdmin?.user?.id,
              groupIndex: controller.selectedGroupIndex.value,
              id: controller.groupList?[controller.selectedGroupIndex.value].id
            );
          }else{
            Get.toNamed(RoutePage.subAdmin,arguments:{
              "group_index":controller.selectedGroupIndex.value,
              "group_id":controller.groupList?[controller.selectedGroupIndex.value].id
            });
          }


        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.h),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(3.r)),
          child: Text(
            controller.groupList?[controller.selectedGroupIndex.value]
                        .subAdmin !=
                    null
                ? AppStrings.unAssignText
                : AppStrings.assignText,
            style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                    .fontFamily),
          ),
        ),
      );
}
