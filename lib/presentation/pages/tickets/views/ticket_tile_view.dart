import 'package:tanod_tractor/presentation/pages/tickets/controllers/ticket_controller.dart';

import '../../../../app/util/export_file.dart';

class TicketTileView extends GetView<TicketController> {
  const TicketTileView({super.key});

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
        children: [
          Expanded(
              child: Column(
            children: [
              showTitleAndValue(
                  title: '${AppStrings.name} :- ',
                  value:
                      "asjuhrfdilsufhydisufdfhisuhiuhiuhi     wrw wer we rwer ewr ewr ewr ew rew rewrewrr we ewrererer udfsdfhisu"
                      ""),
              SizedBox(
                height: 5.h,
              ),
              showTitleAndValue(
                  title: '${AppStrings.description} :- ',
                  value:
                      "asjuhrfdilsufhydisufdfhisuhiuhiuhi     wrw wer we rwer ewr ewr ewr ew rew rewrewrr we ewrererer udfsdfhisu"
                      ""),
            ],
          )),
          controller.showPopUpMenuButton()
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
