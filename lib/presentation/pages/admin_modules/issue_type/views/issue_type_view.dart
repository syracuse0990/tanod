import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../controller/issue_type_controller.dart';
import 'add_update_issue_view.dart';
import 'issue_type_tile.dart';

// ignore: must_be_immutable
class IssueTypeView extends GetView<IssueTypeController> {
  Map<String, dynamic>? arguments;

  IssueTypeView({this.arguments, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (arguments != null && arguments?.isNotEmpty == true) {
        controller.fromUser.value = arguments!['from_user'];
        print("cechl jhdas aj${arguments!['id']}");
        controller.selectedIssueId.value = arguments!['id'].toString();
        controller.fromUser.refresh();
        controller.selectedIssueId.refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      floatingActionButton: controller.fromUser.isTrue
          ? null
          : FloatingActionButton(
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        onPressed: () {
          controller.isUpdating.value = false;
          controller.isUpdating.refresh();
          Get.to(() => AddUpdateIssueView());
        },
      ),
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.issueTitleList,
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
            child: controller.issueTypeList?.length != 0
                ? ListView.builder(
                shrinkWrap: true,
                controller: controller.issueController,
                itemCount: controller.issueTypeList?.length ?? 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.fromUser.isTrue) {
                        if (controller
                            .issueTypeList![index].isSelected ==
                            false) {
                          controller.issueTypeList![index].isSelected =
                          true;
                        } else {
                          controller.issueTypeList![index].isSelected =
                          true;
                        }
                        Get.back(
                            result: controller.issueTypeList![index]);
                      }
                    },
                    child: IssueTypeTileView(
                      index: index,
                      fromUser: controller.fromUser.isTrue,
                      issueTypeModel: controller.issueTypeList![index],
                    ),
                  );
                })
                : noDataFoundWidget(),
          )),
        ],
      ),
    ));
  }
}
