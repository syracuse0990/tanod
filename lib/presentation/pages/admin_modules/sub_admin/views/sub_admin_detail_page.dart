import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/sub_admin/views/sub_admin_user_profile.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/repositories/user_management_provider/impl/remote_user_management_provider.dart';

class SubAdminDetailPageView extends GetView<SubAdminController> {
  var userId;
  var groupSelectedIndex;

  SubAdminDetailPageView({this.userId, this.groupSelectedIndex, super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.iSubAdminRepository = Get.put(RemoteISubAdminProvider());
      controller.iUserManagementRepository =
          Get.put(RemoteIUserManagementProvider());
      controller.hitApiToGetDetails(userId: userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed(RoutePage.assignGroups,
                    arguments: {"sub_admin_user_id": userId.toString(),"group_index":groupSelectedIndex});
              },
              child: calenderView(
                text: AppStrings.assignGroupsTxt,
              ))
        ],
        firstLabel: AppStrings.details,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _profileImageWidget,
            SizedBox(
              height: 20.h,
            ),
            _personalInformationWidget
          ],
        ),
      ),
    );
  }

  Widget get _profileImageWidget => Column(
        children: [
          headerViewWidget(title: AppStrings.profileDetails),
          SubAdminUserProfileView(userId: userId),
        ],
      );

  Widget get _personalInformationWidget => Column(
        children: [
          headerViewWidget(title: AppStrings.personalDetails),
          detailWidget
        ],
      );

  Widget get detailWidget => Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r)),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3)),
        ),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTitleAndValue(
                    title: '${AppStrings.name} :- ',
                    value: controller.userDataModel.value?.name ?? ""),
                showTitleAndValue(
                    title: '${AppStrings.email} :- ',
                    value: controller.userDataModel.value?.email ?? ""),
                showTitleAndValue(
                    title: '${AppStrings.phone} :- ',
                    value: controller.userDataModel.value?.phone?.toString() ??
                        ""),
                showTitleAndValue(
                    title: '${AppStrings.role} :- ',
                    value: AppStrings.subAdminRole),
                showTitleAndValue(
                    title: '${AppStrings.gender} :- ',
                    value: controller.userDataModel.value?.gender ==
                            APIEndpoint.male
                        ? AppStrings.male
                        : controller.userDataModel.value?.gender ==
                                APIEndpoint.female
                            ? AppStrings.female
                            : AppStrings.notDefined),
                showTitleAndValue(
                    title: '${AppStrings.state} :- ',
                    value: getAllStateTitles(
                        controller.userDataModel.value?.stateId)),
                showTitleAndValue(
                    title: '${AppStrings.createdOn} :- ',
                    value: utcToLocal(
                        dateUtc: controller.userDataModel.value?.createdAt)),
              ],
            )),
      );

  headerViewWidget({title}) {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r), topLeft: Radius.circular(8.r)),
          color: AppColors.primary.withOpacity(0.8)),
      child: TractorText(
        text: '$title :-' ?? "",
        fontSize: 16.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value?.toString() ?? "",
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
