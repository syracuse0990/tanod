import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/device_tile_view.dart';

import '../../../app/util/export_file.dart';

class DeviceView extends GetView<ReservationController> {


  bool? selectedMultiple = false;
  Map<String,dynamic>? maps={};
  List<DevicesModel>? deviceList;

  DeviceView({this.deviceList,this.maps,super.key}) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if(deviceList!=null){
        controller.updatedDeviceList?.clear();
        controller.updatedDeviceList?.addAll(deviceList??[]);
        controller.updatedDeviceList?.refresh();
      }
      controller.deviceList?.clear();
      controller.devicePage.value = 1;
      controller.update();
      controller.hitApiToGetDeviceList(maps: maps);
      controller.addPaginationForDeviceList(maps: maps);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<DevicesModel>? list = controller.deviceList
              ?.where((element) => element.isSelected == true)
              .toList();

          if (list != null && list.isNotEmpty) {
            controller.deviceModel.value = list?.first;
            controller.deviceModel.refresh();
          }
          Get.back(result: controller.deviceModel.value);
        },
        firstLabel: 'Device List',
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
              child: Obx(() => controller.deviceList?.length != 0
                  ? ListView.builder(
                  shrinkWrap: true,
                  controller:controller. deviceController,
                  itemCount: controller.deviceList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        //TODO for admin we can select multiple values

                        for (int i = 0;
                        i < controller.deviceList!.length;
                        i++) {
                          if (i == index) {
                            controller.deviceList![i].isSelected = true;
                          } else {
                            controller.deviceList![i].isSelected = false;
                          }
                        }
                        controller.deviceList?.refresh();
                        controller.deviceModel.value =
                        controller.deviceList![index];
                        Get.back(result: controller.deviceModel.value);

                      },
                      child: DeviceTileView(
                        isSelected:
                        controller.deviceList![index].isSelected,
                        devicesModel: controller.deviceList?[index],
                      ),
                    );
                  })
                  : noDataFoundWidget())),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
