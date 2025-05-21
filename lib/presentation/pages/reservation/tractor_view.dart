import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/tractor_tile_view.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/util.dart';
import '../../../data/models/tractor_group_model.dart';
import '../../components/tractor_appbar.dart';
import 'controller/reservation_controller.dart';

class TractorView extends GetView<ReservationController> {
  bool? isFromMaintenance=false;
  TractorView({this.isFromMaintenance=false,super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.tractorList?.clear();
      controller.tractorPage.value=1;
      controller.fromMaintenance.value=isFromMaintenance??false;
      controller.update();
      Future.delayed(Duration(seconds: 2));
      controller.hitApiToGetTractorList();
      controller.addPaginationOnTractorList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<TractorModel>? list = controller.tractorList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.tractorModel.value = list?.first;
            controller.tractorModel.refresh();
          }
          Get.back(result: controller.tractorModel.value);
        },
        firstLabel: 'Tractor List',
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
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Obx(() => controller.tractorList?.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      controller: controller.tractorController,
                      itemCount: controller.tractorList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            for (int i = 0;
                                i < controller.tractorList!.length;
                                i++) {
                              if (i == index) {
                                controller.tractorList![i].isSelected = true;
                              } else {
                                controller.tractorList![i].isSelected = false;
                              }
                            }
                            controller.tractorList?.refresh();
                            controller.tractorModel.value = controller.tractorList![index];
                            controller.tractorModel.refresh();
                            Get.back(result: controller.tractorModel.value);
                          },
                          child: TractorTileView(
                            isFromMaintenance: controller.fromMaintenance.value,
                            isSelected: controller.tractorList![index].isSelected,
                            tractorModel: controller.tractorList?[index],
                          ),
                        );
                      })
                  : noDataFoundWidget()))
        ],
      ),
    );
  }
}
