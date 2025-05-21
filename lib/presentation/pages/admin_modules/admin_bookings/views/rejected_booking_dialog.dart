import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import '../../../../../app/util/export_file.dart';

class RejectedReasonDialog extends GetWidget<ProfileController> {
  Function(String)? onSubmitClick;
  var reasonController;

  RejectedReasonDialog({
    super.key,
    this.onSubmitClick,
    this.reasonController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:   RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),

       content: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
            Row(
              children: [
                Expanded(child: TractorText(
                  textAlign: TextAlign.center,
                  text: 'Reason',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold
                )),
                GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.clear,size: 25.r,)),
              ],
            ),
             SizedBox(
               height: 10.h,
             ),
             SizedBox(
               height: Get.height * 0.25,
               child: TextField(
                 maxLines: 100,
                 controller: reasonController,
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
                   hintText: 'Please enter reason',
                   filled: true,
                   hintStyle: TextStyle(
                     fontSize: 14.sp,
                     color: AppColors.lightGray.withOpacity(0.5),
                     height: 0.0,
                     fontFamily: GoogleFonts.plusJakartaSans(
                             fontWeight: FontWeight.w500)
                         .fontFamily,
                   ),
                   fillColor: AppColors.white.withOpacity(0.1),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10.r),
                     borderSide: BorderSide(
                       color: AppColors.lightGray.withOpacity(0.2),
                     ),
                   ),
                   focusColor: AppColors.lightGray.withOpacity(0.2),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10.r),
                     borderSide: BorderSide(
                       color: AppColors.primary,
                     ),
                   ),
                 ),
               ),
             ),
         
             AddSpace.vertical(32.h),
             TractorButton(
               text: 'Cancel',
               onTap: () {
                 Get.back();
               },
             ),
             AddSpace.vertical(15.h),
             Container(
               decoration: BoxDecoration(boxShadow: [
                 BoxShadow(
                     color: AppColors.lightGray.withOpacity(0.07),
                     spreadRadius: 12,
                     blurRadius: 10,
                     blurStyle: BlurStyle.normal)
               ]),
               child: TractorButton(
                 text: 'Submit',
                 textColor: AppColors.red,
                 color: AppColors.white,
                 border: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.r)),
                 onTap: () {
                   if (onSubmitClick != null) {
                     onSubmitClick!(reasonController.text);
                   }
                 },
               ),
             ),
             AddSpace.vertical(25.h),
           ],
         ),
       ),
    );
  }
}
