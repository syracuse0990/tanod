



import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../../app/util/export_file.dart';

class PinPutView extends StatelessWidget {
  var controller;

  Function(String)? onComplete;

  PinPutView({this.controller, this.onComplete,super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,

      submittedPinTheme: PinTheme(
        width: 50.r,
        height: 50.r,
        textStyle: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.white),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(13.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      closeKeyboardWhenCompleted: true,
      focusedPinTheme: PinTheme(
        width: 50.r,
        height: 50.r,
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.primary),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(color: Colors.white, width: 1.w)),
      ),
      forceErrorState: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      scrollPadding: EdgeInsets.only(right: 30.w),
      defaultPinTheme: PinTheme(
        width: 50.r,
        height: 50.r,
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.primary),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            border: Border.all(
                color:Colors.white, width: 0.7.w)),
      ),
      onCompleted: (pin) {
        if(onComplete!=null){
          onComplete!(pin);
        }
      }
    );
  }
}
