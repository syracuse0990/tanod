import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/tractor_tile_view.dart';

import '../../../../../app/util/export_file.dart';
import '../controller/common_tractors_controller.dart';
import 'add_new_tractor.dart';

class CommonTractorView extends GetView<CommonTractorController> {
  CommonTractorView() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.hitApiToGetTractorList();
      controller.addPaginationOnTractorList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: box.read(roleType) == APIEndpoint.aminRole?FloatingActionButton(
        child: Icon(Icons.add, color: AppColors.white),
        backgroundColor: AppColors.primary,
        onPressed: () {
          controller.isUpdating.value = false;
          controller.update();
          Get.to(AddNewTractorView());
        },
      ):SizedBox(),
      appBar: TractorBackArrowBar(
        actions: [



          exportWidget((){
            controller.hitApiToExportFeedbackReports();
          }),

        ],
        firstLabel: AppStrings.tractorList,
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
          Obx(() => controller.tractorList?.length != 0
              ? Expanded(
                  child: ListView.builder(
                      controller: controller.tractorController,
                      itemCount: controller.tractorList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            controller.tractorList?.forEach((element) {
                              element?.isLongPressed = true;
                            });
                            controller.tractorList?.refresh();
                            print("check long pressed");
                          },
                          child: TractorTileView(
                            onSelected: () {
                              if (controller.tractorList![index].isSelected ==
                                  true) {
                                controller.tractorList![index].isSelected =
                                    false;
                              } else {
                                controller.tractorList![index].isSelected =
                                    true;
                              }
                              controller.tractorList?.refresh();
                            },
                            onDeleteTab: () {
                              controller.hitApiToDeleteTractors(
                                  controller.tractorList![index].id, index);
                            },
                            onViewTab: () {
                              Future.delayed(
                                Duration(microseconds: 200),
                                () => Get.to(AddNewTractorView(
                                  currentIndex: index,
                                  isUpdating: true,
                                  id: controller.tractorList![index].id,
                                )),
                              );
                            },
                            tractorModel: controller.tractorList![index],
                          ),
                        );
                      }))
              : noDataFoundWidget())
        ],
      ),

    );
  }



}
