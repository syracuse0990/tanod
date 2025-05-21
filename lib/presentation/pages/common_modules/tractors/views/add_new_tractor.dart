import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/state_model.dart';
import '../../../admin_modules/create_group/controller/create_group_controller.dart';
import '../../../admin_modules/create_group/views/state_view.dart';
import '../../devices/views/mutiple_image_view.dart';
import '../controller/common_tractors_controller.dart';

class AddNewTractorView extends GetView<CommonTractorController> {
  bool? isUpdating = false;
  int? id,currentIndex;

  Map<String,dynamic>? arguments;

  AddNewTractorView({this.arguments,this.isUpdating, this.id,this.currentIndex, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (isUpdating == true) {
        controller.isUpdating.value = true;
        controller.tractorId.value = id ?? 0;
        controller.tractorId.refresh();

        controller.currentIndex.value =currentIndex ?? 0;
        controller.currentIndex.refresh();

        controller.isUpdating.refresh();
        controller.hitApiToGetDeviceDetails(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: (){
          controller. resetAllController();
          Get.back();
        },
        firstLabel: controller.isUpdating.isTrue ? AppStrings.updateDevice : AppStrings.addNewTractor,
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
            numberPlateTextField,
            SizedBox(
              height: 20.h,
            ),
            idPlateTextField,
            SizedBox(
              height: 20.h,
            ),
            engineTextField,
            SizedBox(
              height: 20.h,
            ),
            fuelTextField,
            SizedBox(
              height: 20.h,
            ),
            maintenanceTextField,
            SizedBox(
              height: 20.h,
            ),
            tractorBrandTextField,
            SizedBox(
              height: 20.h,
            ),
            tractorModelTextField,
            SizedBox(
              height: 20.h,
            ),
            manufactureDateTextField,
            SizedBox(
              height: 20.h,
            ),
            installationTimeTextField,
            SizedBox(
              height: 20.h,
            ),
            installationAddressTextField,
            SizedBox(
              height: 20.h,
            ),

            TractorText(
              text: AppStrings.selectState,
              fontSize: 16.sp,
            ),
            SizedBox(
              height: 20.h,
            ),
            selectState,
            SizedBox(
              height: 20.h,
            ),
            Obx(
                  () => MultipleImageView(
                  imageList: controller.imageList.value,
                  onPlusTab: () {
                    if (controller.imageList.value.length < 5) {
                      controller.showImageDialog();
                    } else {
                      showToast(message: AppStrings.imageUploadLimit);
                    }
                  },
                  onCancelTab: (index) {
                    controller.imageList.removeAt(index);
                    controller.imageList.refresh();
                  }),
            ),
            SizedBox(
              height: 100.h,
            ),
            Obx(() => saveButton)
          ],
        ),
      ),
    ));
  }

  Widget get numberPlateTextField => TractorTextfeild(
        controller: controller.numberPlateTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.numberPlate,
      );

  Widget get idPlateTextField => TractorTextfeild(
        controller: controller.idNumberTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.idNumber,
      );

  Widget get engineTextField => TractorTextfeild(
        controller: controller.engineNumberTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.engineNumber,
      );

  Widget get fuelTextField => TractorTextfeild(
        controller: controller.fuelTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.fuelPerKm,
      );

  Widget get maintenanceTextField => TractorTextfeild(
        controller: controller.maintenanceTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [ FilteringTextInputFormatter.digitsOnly],
        hint: AppStrings.maintenanceKilometer,
      );

  Widget get tractorBrandTextField => TractorTextfeild(
        controller: controller.tractorBrandTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.tractorBrand,
      );

  Widget get tractorModelTextField => TractorTextfeild(
        controller: controller.tractorModelTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.tractorModel,
      );

  Widget get manufactureDateTextField => GestureDetector(
        onTap: () {
          showDateTimePicker(
              context: Get.context!,
              isEnabled: false,
              onChanged: (dateTime) {
                if (dateTime == null) {
                  return;
                }
                controller.manufactureDateTextFieldController.text =
                    DateFormat("yyyy-MM-dd").format(dateTime);
                controller.update();
              });
        },
        child: TractorTextfeild(
          controller: controller.manufactureDateTextFieldController,
          textInputAction: TextInputAction.next,
          isEnabned: false,
          isSufix: true,
          suffixWidget: Icon(
            Icons.calendar_month,
            color: AppColors.primary,
          ),
          keyboardType: TextInputType.number,
          hint: AppStrings.manuFactureDate,
        ),
      );

  Widget get installationTimeTextField => GestureDetector(
        onTap: () async {
          await showDateTimePicker(
              context: Get.context!,
              isEnabled: false,
              onChanged: (dateTime) async {
                if (dateTime == null) {
                  return;
                }

                await showCustomTimePicker(Get.context!).then((value) {
                  if (value != null) {
                    String formattedTime = DateFormat('HH:mm')
                        .format(DateTime(2022, 1, 1, value.hour, value.minute));
                    controller.installationTimeTextFieldController.text =
                        '${DateFormat("yyyy-MM-dd").format(dateTime)} $formattedTime';
                    controller.update();
                  }
                });
              });
        },
        child: TractorTextfeild(
          controller: controller.installationTimeTextFieldController,
          textInputAction: TextInputAction.next,
          isEnabned: false,
          isSufix: true,
          suffixWidget: Icon(
            Icons.calendar_month,
            color: AppColors.primary,
          ),
          keyboardType: TextInputType.number,
          hint: AppStrings.installationTime,
        ),
      );

  Widget get installationAddressTextField => TractorTextfeild(
        controller: controller.installationAddressTextFieldController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.installationAddress,
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
            controller.hitApiToUpdateTractors(controller.tractorId.value,controller.currentIndex.value);
          } else {
            controller.hitApiToAddNewTractors();
          }
        },
      );
}
