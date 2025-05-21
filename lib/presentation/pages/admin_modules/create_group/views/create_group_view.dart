import 'package:tanod_tractor/data/models/state_model.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/create_group/views/state_view.dart';

import '../../../../../app/util/export_file.dart';
import '../controller/create_group_controller.dart';
import 'group_device_view.dart';
import 'group_farmer_view.dart';
import 'group_tratcors_view.dart';

class CreateGroupView extends GetView<CreateGroupController> {

  GroupsModel? groupsModel;
  CreateGroupView({this.groupsModel,super.key}) {
    if(groupsModel!=null){
      controller.groupDetailModel.value=groupsModel;
      controller.groupDetailModel.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: controller.groupDetailModel.value==null? AppStrings.createGroup:AppStrings.updateGroup,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TractorText(text: AppStrings.groupName, fontSize: 16.sp),
            nameTextField,
            AddSpace.vertical(20.h),
            TractorText(
              text: AppStrings.selectFramer,
              fontSize: 16.sp,
            ),
            AddSpace.vertical(10.h),
            Obx(
                  () => CommonTractorTileView(
                  title: controller.selectFarmers.value,
                  onTab: () async {
                    if (!Get.isRegistered<ReservationController>()) {
                      Get.put(ReservationController());
                    }
                    var data = await Get.to(AdminFarmerView());
                    if (data != null) {
                      controller.selectFarmers.value = controller.farmerList
                          ?.where((element) => element?.isSelected == true)
                          .toList()
                          ?.map((element) => element?.email)
                          .toList()
                          ?.join(",") ??
                          "";

                      controller.update();
                    }
                  }),
            ),
            AddSpace.vertical(20.h),
            TractorText(
              text: AppStrings.selectGroupTractors,
              fontSize: 16.sp,
            ),
            AddSpace.vertical(10.h),
            Obx(
                  () => CommonTractorTileView(
                  title: controller.selectTractor.value,
                  onTab: () async {
                    var data = await Get.to(AdminTractorView());
                    print("check all ${data}");
                    if (data != null) {
                      controller.selectTractor.value = controller.tractorList
                          ?.where((element) => element?.isSelected == true)
                          .toList()
                          ?.map((element) => element?.noPlate)
                          .toList()
                          ?.join(",") ??
                          "";

                      controller.update();
                    }
                  }),
            ),
            AddSpace.vertical(20.h),
            TractorText(
              text: AppStrings.selectGroupDevices,
              fontSize: 16.sp,
            ),
            AddSpace.vertical(10.h),
            Obx(
                  () => CommonTractorTileView(
                  title: controller.selectDevices.value,
                  onTab: () async {
                    var data = await Get.to(AdminDeviceView());
                    if (data != null) {
                      controller.selectDevices.value = controller.deviceDataList
                          ?.where((element) => element?.isSelected == true)
                          .toList()
                          ?.map((element) => element?.deviceName)
                          .toList()
                          ?.join(",") ??
                          "";

                      controller.update();
                    }
                  }),
            ),
            AddSpace.vertical(20.h),
            TractorText(
              text: AppStrings.selectState,
              fontSize: 16.sp,
            ),
            AddSpace.vertical(10.h),
            Obx(
                  () => CommonTractorTileView(
                  title: controller.selectState.value,
                  onTab: () async {
                    StateModel? stateModel = await Get.to(StateViewScreen());
                    if (stateModel != null) {
                      controller.selectState.value = stateModel.title ?? "";
                      controller.selectState.refresh();
                    }
                  }),
            ),
            AddSpace.vertical(50.h),
            saveButton
          ],
        ),
      ),
    ));
  }

  Widget get nameTextField => TractorTextfeild(
        textInputAction: TextInputAction.next,
        controller: controller.nameController,
        keyboardType: TextInputType.name,
        hint: AppStrings.groupName,
      );

  Widget get saveButton =>Obx(() =>  TractorButton(
    text:  controller.groupDetailModel.value==null? AppStrings.create:AppStrings.update,
    onTap: () {
      if(controller.groupDetailModel.value==null){
        controller.hitApiToCreateSlotList();
      }else{
        controller.hitApiToUpdateSlotList();
      }

    },
  ));
}
