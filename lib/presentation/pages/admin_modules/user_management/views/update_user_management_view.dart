import 'package:tanod_tractor/presentation/pages/admin_modules/user_management/controller/user_management_controller.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/state_model.dart';
import '../../../../../data/models/user_model.dart';
import '../../create_group/controller/create_group_controller.dart';
import '../../create_group/views/state_view.dart';

class UpdateUserManagement extends GetView<UserManagementController> {
  UserDataModel? userDataModel;
  int? index;
    UpdateUserManagement({this.userDataModel,this.index,super.key}){
    controller.showDetailsOnFields(userDataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.updateDetails,
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
              titleWidget(title: AppStrings.name),
              _nameTextFieldWidget,
              SizedBox(
                height: 20.h,
              ),
              titleWidget(title: AppStrings.email),
              _emailTextFieldWidget,
              SizedBox(
                height: 20.h,
              ),
              titleWidget(title: AppStrings.phone),
              _phoneTextFieldWidget,
              SizedBox(
                height: 20.h,
              ),
              selectStateText(title: AppStrings.selectGender),
              SizedBox(
                height: 8.h,
              ),
              selectGenderState,
              SizedBox(
                height: 20.h,
              ),
              selectStateText(title: AppStrings.selectState),
              SizedBox(
                height: 8.h,
              ),
              selectState,
              SizedBox(
                height: 100.h,
              ),
              updateButton
            ],
          )),
    );
  }

  titleWidget({title}) {
    return TractorText(text: title ?? "");
  }

  Widget get _nameTextFieldWidget => TractorTextfeild(
        controller: controller.nameController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.name,
      );

  Widget get _emailTextFieldWidget => TractorTextfeild(
        controller: controller.emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        isEnabned: false,
        hint: AppStrings.email,
      );

  Widget get _phoneTextFieldWidget => TractorTextfeild(
        controller: controller.phoneController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.phone,
        hint: AppStrings.phone,
      );

  Widget selectStateText({title}) {
    return TractorText(
      text: title ?? "",
      fontSize: 14.sp,
      color: AppColors.lightGray,
      fontWeight: FontWeight.w500,
    );
  }

  Widget get selectGenderState => Obx(() => CommonTractorTileView(
      title: controller.selectGender.value,
      onTab: () async {
        if (!Get.isRegistered<CreateGroupController>()) {
          Get.put(CreateGroupController());
        }
        StateModel? stateModel = await Get.to(StateViewScreen(
          isUpdatedList: true,
          stateList: controller.genderList,
        ));
        if (stateModel != null) {
          controller.selectGender.value = stateModel.title ?? "";
          controller.selectGender.refresh();
        }
      }));

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

  Widget get updateButton => TractorButton(
        text: AppStrings.update,
        onTap: () {
          controller.hitApiToUpdateUserDetails(index: index,
          id: userDataModel?.id
          );
        },
      );
}
