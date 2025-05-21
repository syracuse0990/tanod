import 'package:tanod_tractor/presentation/pages/admin_modules/user_management/controller/user_management_controller.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/user_model.dart';
import 'update_user_management_view.dart';
import 'user_detail_page.dart';

class UserManagementTileView extends GetView<UserManagementController> {
  UserDataModel? userDataModel;
  int? index;

  UserManagementTileView({this.index,this.userDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Row(
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
                    value: userDataModel?.gender ==
                        APIEndpoint.male ? AppStrings.male : userDataModel?.gender == APIEndpoint.female
                        ? AppStrings.female:AppStrings.notDefined),
                showTitleAndValue(
                    title: '${AppStrings.state} :- ',
                    value: getAllStateTitles(userDataModel?.stateId)),
              ],
            ),
          ),
          controller.showPopUpMenuButton(
            onEditTab: (){
              Get.to(UpdateUserManagement(userDataModel:userDataModel,index: index,));
            },
            onDetailTab: (){
              Get.to(UserDetailPageView(userId: userDataModel?.id,));
            },
            onDeleteTab: (){
              controller.hitApiToDeleteUser(id:userDataModel?.id,index: index );
            }
          )
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
}
