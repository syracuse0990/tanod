import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../app/util/export_file.dart';
import '../../controller/maintenance_controller.dart';
import 'admin_isssue_tractor_view.dart';

class FilterMaintenanceView extends GetView<MaintenanceController> {
  const FilterMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.filters,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TractorText(text: AppStrings.tractor),
            SizedBox(
              height: 10.h,
            ),
            _selectTractors,
            SizedBox(
              height: 20.h,
            ),
            const TractorText(text: AppStrings.selectDateInRange),
            SizedBox(
              height: 10.h,
            ),
            _calenderView,
            SizedBox(
              height: 100.h,
            ),
            saveButton
          ],
        ),
      ),
    );
  }

  Widget get _selectTractors => Obx(() => CommonTractorTileView(
        title: controller.selectFilterTractor.value,
        onTab: () async {
                TractorModel? data = await Get.to(() => AdminIssueTractorView());
          if (data != null) {
            controller.selectFilterTractor.value = data?.idNo?.toString() ?? "";
            controller.update();
          }
        },
      ));

  Widget get _calenderView => Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.primary, width: 0.4)),
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.extendableRange,
          selectionColor: AppColors.primary,
          monthCellStyle:
              DateRangePickerMonthCellStyle(selectionColor: AppColors.primary),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs data) {
            controller.selectedDateRange.value = data;
            print("check  all date ${data.value}");
            controller.refresh();
          },
        ),
      );

  Widget get saveButton => TractorButton(
        text: AppStrings.save,
        onTap: () {
          controller.hitApiToApplyFilterOnMaintenanceOnList();
        },
      );
}
