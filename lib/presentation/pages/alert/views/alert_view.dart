import '../../../../app/util/export_file.dart';
import '../controllers/alter_controller.dart';
import 'alert_tile_view.dart';

class AlertView extends GetView<AlertController> {
  Map<String, dynamic>? arguments;

  AlertView({this.arguments, super.key}) {
    if (arguments != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        leading: SizedBox(),
        firstLabel: 'Alerts',
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
          Obx(() => applyFilterWidget,),
          Obx(() => Expanded(
              child: controller.alertList?.length != 0
                  ? ListView.builder(
                      controller: controller.alertController,
                      shrinkWrap: true,
                      itemCount: controller.alertList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AlertTileWidget(
                          alertDetailModel: controller.alertList![index],
                        );
                      })
                  : noDataFoundWidget()))
        ],
      ),
    );
  }

  Widget get applyFilterWidget => Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 35.h,
          margin: EdgeInsets.all(15.r),
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 0.7.r)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: controller.alertFilterList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Row(
                    children: [
                      TractorText(
                        text: value ?? "",
                        fontSize: 16.sp,
                        color: AppColors.lightblack,

                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? title) {
                controller.selectedAlterValue.value=title??"";
                controller.selectedAlterValue.refresh();
                controller.currentPage.value=1;
                controller.currentPage.refresh();
                controller.alertList?.clear();
                if( controller.selectedAlterValue.value==AppStrings.all){
                  controller.hitApiToGetAlertList(alarmType: "");
                }else{
                  controller.hitApiToGetAlertList(alarmType: getAlertBasedId(controller.selectedAlterValue.value));
                }


              },
              value: controller.selectedAlterValue.value,
            ),
          ),
        ),
      );
}
