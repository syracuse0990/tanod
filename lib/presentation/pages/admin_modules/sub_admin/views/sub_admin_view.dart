import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/sub_admin/views/sub_admin_tile_view.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/repositories/user_management_provider/impl/remote_user_management_provider.dart';
import 'add_sub_admin.dart';

class SubAdminView extends GetView<SubAdminController> {


  Map<String,dynamic> ? arguments;
  SubAdminView({this.arguments,super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if(arguments!=null&&arguments?.isNotEmpty==true){
        controller.groupSelectedIndex?.value=arguments!["group_index"];
        controller.groupId?.value=arguments!["group_id"];
        controller.groupSelectedIndex?.refresh();
        controller.groupId?.refresh();
      }

      controller.iSubAdminRepository = Get.put(RemoteISubAdminProvider());
      controller.iUserManagementRepository =
          Get.put(RemoteIUserManagementProvider());

      controller.userList?.clear();
      controller.genderListInit();
      controller.hitApiToGetUserList();
      controller.addPaginationOnFarmerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: AppColors.white),
          backgroundColor: AppColors.primary,
          onPressed: () {
            if (!Get.isRegistered<SubAdminController>()) {
              Get.lazyPut(() => SubAdminController());
            }
            Get.to(AddNewSubAdminView());
          },
        ),
        appBar: TractorBackArrowBar(
          firstLabel: AppStrings.subAdmin,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts
                .plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Column(
          children: [
            Obx(() =>
                Expanded(
                  child: controller.userList?.length != 0
                      ? ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.userList?.value.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SubAdminTileView(
                          onTab: (){
                            if(controller.groupSelectedIndex?.value!=null){

                              controller.hitApiToAssignGroup(
                                  index: index,
                                  subAdminId: controller.userList![index].id,
                                  isAssigned: APIEndpoint.assignToSubAdmin,
                                  id: controller.groupId?.value);

                            }
                          },
                          index: index,
                          userDataModel: controller.userList![index],
                        );
                      })
                      : noDataFoundWidget(),
                ))
          ],
        ));
  }
}
