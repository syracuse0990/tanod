import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';

class FeedbackTileView extends StatelessWidget {
  FeedbackDetailModel? feedbackDetailModel;
  bool isAdmin = false;

  FeedbackTileView({this.feedbackDetailModel, this.isAdmin = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Row(
        children: [
         ClipRRect(
           borderRadius: BorderRadius.circular(5.r),
           child:  feedbackDetailModel?.images==null&&feedbackDetailModel?.images?.length==0?Image.asset(
             AppPngAssets.noImageFound,
             width: 130.w,
             height: 150.h,
             fit: BoxFit.cover,
           ):cacheNetworkImage( width: 130.w,
               height: 150.h,
               fit: BoxFit.cover,url: '${APIEndpoint.imageUrl}${feedbackDetailModel?.images?.first.path}'),
         ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showTitleAndValue(
                    title: '${AppStrings.name} :- ',
                    value: feedbackDetailModel?.name ?? ""),

                showTitleAndValue(
                    title: '${AppStrings.createdBy} :- ',
                    value: feedbackDetailModel?.createdBy?.name ??
                        feedbackDetailModel?.createdBy?.email ??
                        ""),
                showTitleAndValue(
                    title: '${AppStrings.state} :- ',
                    value: getIssueTypeTitle(feedbackDetailModel?.stateId)),
                showTitleAndValue(
                    title: '${AppStrings.issuesType} :- ',
                    value: feedbackDetailModel?.issueType?.title ?? ""),
                showTitleAndValue(
                    title: '${AppStrings.description} :- ',
                    value: feedbackDetailModel?.description ?? ""),

                feedbackDetailModel?.techDetails!=null?showTitleAndValue(
                    title: '${AppStrings.technicalDetails} :- ',
                    value: feedbackDetailModel?.techDetails ?? ""):SizedBox(),
                feedbackDetailModel?.stateId == APIEndpoint.stateCompleted ||
                        isAdmin == true
                    ? feedbackDetailModel?.conclusion != null
                        ? showTitleAndValue(
                            title: '${AppStrings.conclusion} :- ',
                            value: feedbackDetailModel?.conclusion ?? "")
                        : SizedBox()
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }

  showTitleAndValue({title, value}) {
    return TractorSpanText(
      firstLabel: title ?? "",
      secondLabel: value ?? "",
      firstTextStyle: TextStyle(
          fontSize: 13.sp,
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
