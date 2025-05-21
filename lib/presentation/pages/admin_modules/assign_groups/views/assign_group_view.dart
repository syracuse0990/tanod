import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import 'assign_group_tile_view.dart';

class AssignGroupsView extends GetView<AssignGroupsController> {

  Map<String,dynamic>? arguments;

  AssignGroupsView({this.arguments, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        Duration(microseconds: 500),
        () {
          if(arguments?.isNotEmpty==true){
            controller.subAdminUserId?.value=arguments!['sub_admin_user_id'];
            controller.groupIndex.value=arguments!['group_index']??0;
            controller.subAdminUserId?.refresh();
            controller.groupIndex.refresh();
          }
          controller.iSubAdminRepository = Get.put(RemoteISubAdminProvider());
          controller.groupList?.clear();
          controller.hitApiToGetAssignGroupList(subAdminId: controller.subAdminUserId?.value);
          controller.addPaginationOnTractorList();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: AppStrings.assignGroups,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Column(
          children: [
            Obx(() => Expanded(
                  child: controller.groupList?.length != 0
                      ? ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.groupList?.value.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AssignGroupTileView(
                              onTab: () {
                                controller.hitApiToAssignGroup(
                                  index: index,
                                    subAdminId: controller.subAdminUserId?.value,
                                    isAssigned:
                                        controller.groupList![index].assign ==
                                                true
                                            ? APIEndpoint.unAssignToSubAdmin
                                            : APIEndpoint.assignToSubAdmin,
                                    id: controller.groupList![index].id);
                              },
                              index: index,
                              groupsModel: controller.groupList?.value[index],
                            );
                          })
                      : noDataFoundWidget(),
                ))
          ],
        ));
  }
}
