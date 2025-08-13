import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../list/widgets/device_tile_view.dart';
import '../controller/common_device_controller.dart';
import 'add_new_device.dart';

class CommonDeviceView extends GetView<CommonDeviceController> {
  CommonDeviceView() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.hitApiToGetDeviceList();
      controller.addPaginationForDeviceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton:box.read(roleType) == APIEndpoint.aminRole || box.read(roleType) == APIEndpoint.technicianRole? FloatingActionButton(
        child: Icon(Icons.add, color: AppColors.white),
        backgroundColor: AppColors.primary,
        onPressed: () {
          controller.isUpdating.value = false;
          controller.update();
          Get.to(AddNewDeviceView());
        },
      ):SizedBox(),
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.deviceList,
        actions: [
          exportWidget((){
            controller.hitApiToExportDeviceReports();
          }),

        ],
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
          Obx(() => controller.deviceList?.length != 0
              ? Expanded(
                  child: ListView.builder(
                      controller: controller.deviceController,
                      itemCount: controller.deviceList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            controller.deviceList?.forEach((element) {
                              element?.isLongPressed = true;
                            });
                            controller.deviceList?.refresh();
                           },
                          child: DeviceTileView(
                            onSelected: () {
                              if (controller.deviceList![index].isSelected ==
                                  true) {
                                controller.deviceList![index].isSelected =
                                false;
                              } else {
                                controller.deviceList![index].isSelected =
                                true;
                              }
                              controller.deviceList?.refresh();
                            },
                            onDeleteTab: () {
                              controller.hitApiToDeleteDevice(
                                  controller.deviceList![index].id, index);
                            },
                            onViewTab: () {
                              Get.to(AddNewDeviceView(
                                isUpdating: true,
                                currentIndex: index,
                                id: controller.deviceList![index].id,
                              ));
                            },
                            devicesModel: controller.deviceList![index],
                          ),
                        );
                      }))
              : noDataFoundWidget())
        ],
      ),
    );
  }
}
