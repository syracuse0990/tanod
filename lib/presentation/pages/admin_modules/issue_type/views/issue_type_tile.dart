import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import '../controller/issue_type_controller.dart';
import 'add_update_issue_view.dart';

class IssueTypeTileView extends GetView<IssueTypeController> {
  IssueType? issueTypeModel;
  int? index;
  bool? fromUser;

  IssueTypeTileView(
      {this.fromUser, this.issueTypeModel, this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: issueTypeModel?.isSelected == true&&fromUser==true
                  ? AppColors.authGradientTop
                  : AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showTitleAndValue(
                  title: '${AppStrings.issueTitle} :- ',
                  value: issueTypeModel?.title),
              showTitleAndValue(
                  title: '${AppStrings.state} :- ',
                  value: getIssueTypeTitle(issueTypeModel?.stateId)),
            ],
          )),
          fromUser==true?SizedBox(): controller.showPopUpMenuButton(
            onDeleteTab: () {
              controller.hitApiToDeleteIssueTitle(issueTypeModel?.id, index);
            },
            onEditTab: () {
              Get.to(() => AddUpdateIssueView(
                    issueTypeModel: issueTypeModel,
                    index: index,
                  ));
            },
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
