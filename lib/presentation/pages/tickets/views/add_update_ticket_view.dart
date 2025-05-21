import 'package:tanod_tractor/presentation/pages/tickets/controllers/ticket_controller.dart';

import '../../../../app/util/export_file.dart';

class AddUpdateTicketView extends GetView<TicketController> {
  bool? isUpdating;
  AddUpdateTicketView({this.isUpdating,super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: TractorBackArrowBar(
          firstLabel: controller.isUpdating.isTrue
              ? AppStrings.updateTicket
              : AppStrings.addTicket,
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TractorText(text: 'Title'),
              TractorTextfeild(
                controller: controller.titleController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                hint: 'Enter Ticket title',
              ),
              AddSpace.vertical(30.h),



              const TractorText(text: 'Description'),
              AddSpace.vertical(20.h),
              SizedBox(
                height: Get.height * 0.13,
                child: TextField(
                  maxLines: 100,
                  controller: controller.descriptionController,
                  cursorColor: AppColors.primary,
                  style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                      height: 1.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: 'Please Describe issue',
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.lightGray.withOpacity(0.5),
                      height: 0.0,
                      fontFamily: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500)
                          .fontFamily,
                    ),
                    fillColor: AppColors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightGray.withOpacity(0.2),
                      ),
                    ),
                    focusColor: AppColors.lightGray.withOpacity(0.2),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              AddSpace.vertical(20.h),

              Spacer(),
              TractorButton(
                text: controller.isUpdating.isTrue
                    ? AppStrings.update
                    : AppStrings.save,
                onTap: () {
                  Get.back();
                  // if (controller.isUpdating.isTrue) {
                  //   controller.hitApiToUpdateFeedback(id: controller.updatingId.value,index: controller.selectedIndex.value );
                  // } else {
                  //   controller.hitApiToCreateFeedback();
                  // }
                },
              ),
              AddSpace.vertical(20.h),
            ],
          ),
        ));;
  }
}
