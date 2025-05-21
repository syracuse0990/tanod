import 'package:flutter/cupertino.dart';
import 'package:flutter_seekbar/seekbar/seekbar.dart';

import '../../../app/util/export_file.dart';
import '../../../data/models/api_date_model.dart';

class PolyMapCardView extends StatelessWidget {
  ApiDataModel? apiDataModel;

  bool? isPlay = false;
  Function? onSelected;
  Function? onReplaySelected;

  int? currentIndexs = 1, totalSteps = 1;

  var currentIndex;
  int? width = 1;
  int? finalWidth;

  PolyMapCardView(
      {this.currentIndex,
      this.totalSteps = 1,
      this.finalWidth,
      this.apiDataModel,
      this.onSelected,
      this.onReplaySelected,
      this.isPlay,
      super.key});

  @override
  Widget build(BuildContext context) {
    print(
        "check current index value ${currentIndex} and total steps ${totalSteps}");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.only(
        top: 20.w,

      ),
      child: Card(
        child: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              speedView,
              SizedBox(
                height: 5.h,
              ),
              seekBarWidget,
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                  onTap: () {
                    if (onReplaySelected != null) {
                      onReplaySelected!();
                    }
                  },
                  child: replayWidget)
            ],
          ),
        ),
      ),
    );
  }

  Widget get speedView => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: TractorText(
              text: '${AppStrings.speed}:',
              fontSize: 16.sp,
              textAlign: TextAlign.end,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: TractorText(
              text: "${apiDataModel?.gpsSpeed ?? "0"} km/h",
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );

  Widget get seekBarWidget => Column(
        children: [
          SizedBox(
            height: 10.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SeekBar(
              progressColor: AppColors.primary,
              value: currentIndex,
              //value: currentIndex!.toDouble(),
              semanticsValue: "sdjgf",
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
              onTap: () {
                if (onSelected != null) {
                  onSelected!();
                }
              },
              child: playPauseWidget),
          SizedBox(
            width: 15.w,
          ),
        ],
      );

  Widget get playPauseWidget => Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: AppColors.primary),
        child: Icon(
          isPlay == false ? Icons.play_arrow_rounded : Icons.pause,
          color: Colors.white,
          size: 30.r,
        ),
      );

  Widget get replayWidget => Row(
        children: [
          Icon(
            Icons.refresh,
            color: AppColors.primary,
          ),
          TractorText(
            text: '${AppStrings.replay}',
            fontSize: 14.sp,
            textAlign: TextAlign.end,
            color: AppColors.lightGray,
            fontWeight: FontWeight.w600,
          ),
          Spacer(),
          TractorText(
            text: gmtToLocal(apiDataModel?.gpsTime ?? ""),
            fontSize: 14.sp,
            textAlign: TextAlign.end,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      );
}
