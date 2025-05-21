import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/util.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';

import '../../../data/providers/network/api_endpoint.dart';
import '../../../data/providers/network/local_keys.dart';
import '../../../main.dart';
import '../../router/route_page_strings.dart';
import 'controller/list_controller.dart';

class TractorGroupsPage extends GetView<ListController> {
  const TractorGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.groupList?.length != 0
          ? ListView.builder(
              controller: controller.scrollController,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: controller.groupList?.length ?? 0,
              itemBuilder: (c, index) {
                return GestureDetector(
                  onTap: () {
                    if (box.read(roleType) != APIEndpoint.aminRole) {
                      Get.toNamed(RoutePage.groupPageDetail, arguments: index);
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                    padding: EdgeInsets.all(22.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: AppColors.lightGray.withOpacity(0.3))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TractorText(
                            text: '${controller.groupList?[index]?.name ?? ""}',
                            fontSize: 16.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole

                            ? controller.showPopUpMenuButton(onDeleteTab: () {

                                controller.hitApiToDeleteGroup(
                                    controller.groupList?[index].id, index);
                              }, onDetailTab: () {
                              print("check all index values ${index}");
                              controller.selectedGroupIndex.value=index;
                              controller.selectedGroupIndex.refresh();
                                Get.toNamed(RoutePage.groupPageDetail,
                                    arguments: index);
                              },onEditTab: (){
                              controller.selectedGroupIndex.value=index;
                              controller.selectedGroupIndex.refresh();
                              Get.toNamed(RoutePage.createNewGroup,arguments:controller.groupList?[index] );


                        })
                            : Icon(
                                Icons.arrow_forward_ios,
                                size: 17.r,
                                color: AppColors.black,
                              )
                      ],
                    ),
                  ),
                );
              })
          : noDataFoundWidget()),
    );
  }
}
