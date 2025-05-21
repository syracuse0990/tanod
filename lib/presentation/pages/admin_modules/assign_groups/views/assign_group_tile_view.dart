import '../../../../../app/util/export_file.dart';

class AssignGroupTileView extends GetView<AssignGroupsController> {
  GroupsModel? groupsModel;
  int? index;
  Function? onTab;

  AssignGroupTileView({this.index, this.groupsModel,this.onTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.lightGray.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                groupsModel?.name ?? "",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                        .fontFamily),
              )),

              _assignedView
            ],
          )
        ],
      ),
    );
  }

  Widget get _assignedView=>GestureDetector(
    onTap: (){
      if(onTab!=null){
        onTab!();
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r,vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
          borderRadius: BorderRadius.circular(3.r)
      ),
      child: Text(
        groupsModel?.assign==true?AppStrings.unAssignText:AppStrings.assignText,
        style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w600)
                .fontFamily),
      ),
    ),
  );
}






