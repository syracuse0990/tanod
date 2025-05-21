import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/data/models/filter_model.dart';
import '../../../../../app/util/export_file.dart';
import '../list/widgets/common_tile_view.dart';




class FilterTypeScreen extends StatelessWidget {
  bool? isUpdatedList = false;
  List<FilterModel>? filterList;

  FilterTypeScreen({this.isUpdatedList = false, this.filterList}) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        onBackPressed: () {
          List<FilterModel>? list = filterList
              ?.where((element) => element.isSelected == true)
              .toList();

          Get.back(result: list?.first);
        },
        firstLabel: AppStrings.stateList,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        for (int i = 0; i < filterList!.length; i++) {
                          if (i == index) {
                            filterList![i].isSelected = true;
                          } else {
                            filterList![i].isSelected = false;
                          }
                        }
                        Get.back(result: filterList![index]);
                      },
                      child: CommonTileView(
                        isSelected: filterList?[index].isSelected ?? false,
                        title: filterList?[index].title,
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
