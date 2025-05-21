import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/state_model.dart';
import '../../../admin_modules/create_group/controller/create_group_controller.dart';
import '../../../admin_modules/create_group/views/state_view.dart';
import '../controller/common_device_controller.dart';

class AddNewDeviceView extends GetView<CommonDeviceController> {
  bool? isUpdating = false;
  int? id, currentIndex;

  AddNewDeviceView({this.isUpdating, this.id, this.currentIndex, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (isUpdating == true) {
        controller.isUpdating.value = true;
        controller.deviceId.value = id ?? 0;
        controller.deviceId.refresh();
        controller.currentIndex.value = currentIndex ?? 0;
        controller.currentIndex.refresh();

        controller.isUpdating.refresh();
        controller.hitApiToGetDeviceDetails(id);
      }
    });
  }

/*updateDevice*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: controller.isUpdating.isTrue
            ? AppStrings.updateDevice
            : AppStrings.addNewDevice,
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
            imeiTextField,
            SizedBox(
              height: 15.h,
            ),
            deviceSimTextField,
            SizedBox(
              height: 15.h,
            ),
            deviceTextField,
            SizedBox(
              height: 15.h,
            ),
            deviceNameTextField,
            SizedBox(
              height: 15.h,
            ),
            subscriptionExpirationTextField,
            SizedBox(
              height: 15.h,
            ),
            expirationDateTextField,
            SizedBox(
              height: 20.h,
            ),
            selectStateText,
            SizedBox(
              height: 10.h,
            ),
            selectState,
            SizedBox(
              height: 100.h,
            ),
            Obx(() => saveButton)
          ],
        ),
      ),
    );
  }

  Widget get imeiTextField => TractorTextfeild(
        controller: controller.imeiTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.imei,
      );

  Widget get deviceSimTextField => TractorTextfeild(
        controller: controller.deviceSimTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        hint: AppStrings.simCapital,
      );

  Widget get deviceTextField => TractorTextfeild(
        controller: controller.deviceModelTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.deviceModel,
      );

  Widget get deviceNameTextField => TractorTextfeild(
        controller: controller.deviceNameTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.deviceName,
      );

  Widget get subscriptionExpirationTextField => TractorTextfeild(
        controller: controller.subscriptionExpirationTextFieldController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4)
        ],
        hint: AppStrings.subscriptionExpiration,
      );

  Widget get expirationDateTextField => GestureDetector(
        onTap: () {
          showDateTimePicker(
              context: Get.context!,
              isEnabled: false,
              onChanged: (dateTime) {
                if (dateTime == null) {
                  return;
                }
                controller.expirationDateTextFieldController.text =
                    DateFormat("yyyy-MM-dd").format(dateTime);
                controller.update();
              });
        },
        child: TractorTextfeild(
          controller: controller.expirationDateTextFieldController,
          textInputAction: TextInputAction.next,
          isEnabned: false,
          isSufix: true,
          suffixWidget: Icon(
            Icons.calendar_month,
            color: AppColors.primary,
          ),
          keyboardType: TextInputType.number,
          hint: AppStrings.expirationDate,
        ),
      );

  Widget get selectStateText => TractorText(
        text: AppStrings.selectState,
        fontSize: 14.sp,
        color: AppColors.lightGray,
        fontWeight: FontWeight.w500,
      );

  Widget get selectState => Obx(() => CommonTractorTileView(
      title: controller.selectState.value,
      onTab: () async {
        if (!Get.isRegistered<CreateGroupController>()) {
          Get.put(CreateGroupController());
        }
        StateModel? stateModel = await Get.to(StateViewScreen());
        if (stateModel != null) {
          controller.selectState.value = stateModel.title ?? "";
          controller.selectState.refresh();
        }
      }));

  Widget get saveButton => TractorButton(
        text:
            controller.isUpdating.isTrue ? AppStrings.update : AppStrings.save,
        onTap: () {
          if (controller.isUpdating.isTrue) {
            controller.hitApiToUpdateDevice(
                controller.deviceId.value, controller.currentIndex.value);
          } else {
            controller.hitApiToAddNewDevice();
          }
        },
      );
}
