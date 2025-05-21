import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/user_model.dart';
import 'add_sub_admin.dart';

class SubAdminTileView extends GetView<SubAdminController> {
  UserDataModel? userDataModel;
  int? index;
  Function? onTab;

  SubAdminTileView({this.index, this.userDataModel, this.onTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTitleAndValue(
                        title: '${AppStrings.name} :- ',
                        value: userDataModel?.name ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.email} :- ',
                        value: userDataModel?.email ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.phone} :- ',
                        value: userDataModel?.phone?.toString() ?? ""),
                    showTitleAndValue(
                        title: '${AppStrings.role} :- ',
                        value: userDataModel?.roleId == APIEndpoint.userRole
                            ? AppStrings.farmer
                            : AppStrings.admin),
                    showTitleAndValue(
                        title: '${AppStrings.gender} :- ',
                        value: userDataModel?.gender == APIEndpoint.male
                            ? AppStrings.male
                            : userDataModel?.gender == APIEndpoint.female
                                ? AppStrings.female
                                : AppStrings.notDefined),
                    showTitleAndValue(
                        title: '${AppStrings.state} :- ',
                        value: getAllStateTitles(userDataModel?.stateId)),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              controller.showPopUpMenuButton(onEditTab: () {
                Get.to(AddNewSubAdminView(
                  userDataModel: userDataModel,
                  index: index,
                ));
              }, onDetailTab: () {
                Get.to(SubAdminDetailPageView(
                  userId: userDataModel?.id,
                  groupSelectedIndex: controller.groupSelectedIndex?.value,
                ));
              }, onDeleteTab: () {
                controller.hitApiToDeleteUser(
                    id: userDataModel?.id, index: index);
              })
            ],
          ),
          controller.groupSelectedIndex != -1
              ? Align(
                  alignment: Alignment.topRight,
                  child: _assignedView,
                )
              : SizedBox()
        ],
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value ?? "",
      firstTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.black,
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
      lastTextStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[800],
          fontFamily:
              GoogleFonts.poppins(fontWeight: FontWeight.w600).fontFamily),
    );
  }

  Widget get _assignedView => GestureDetector(
        onTap: () {
          if (onTab != null) {
            onTab!();
          }
        },
        child: Container(
          margin: EdgeInsets.only(right: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.h),
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(3.r)),
          child: Text(
            AppStrings.assignText,
            style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                    .fontFamily),
          ),
        ),
      );
}
