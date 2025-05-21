import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/data/models/state_model.dart';

import '../../../../../app/util/export_file.dart';
import '../../../list/widgets/common_tile_view.dart';
import '../controller/create_group_controller.dart';

class StateViewScreen extends GetView<CreateGroupController> {
  bool? isUpdatedList = false;
  List<StateModel>? stateList;

  StateViewScreen({this.isUpdatedList = false, this.stateList}) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (isUpdatedList == true) {
        controller.stateList?.clear();
        controller.stateList?.addAll(stateList ?? []);
        controller.stateList?.refresh();
        Get.forceAppUpdate();
      } else {
        controller.stateListInit();
      }
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<StateModel>? list = controller.stateList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.stateModel.value = list?.first;
            controller.stateModel.refresh();
          }
          Get.back(result: controller.stateModel.value);
        },
        firstLabel: AppStrings.stateList,
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
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.stateList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        for (int i = 0; i < controller.stateList!.length; i++) {
                          if (i == index) {
                            controller.stateList![i].isSelected = true;
                          } else {
                            controller.stateList![i].isSelected = false;
                          }
                        }
                        controller.stateList?.refresh();
                        controller.stateModel.value =
                            controller.stateList![index];
                        Get.back(result: controller.stateModel.value);
                      },
                      child: CommonTileView(
                        isSelected:
                            controller.stateList?[index].isSelected ?? false,
                        title: controller.stateList?[index].title,
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
