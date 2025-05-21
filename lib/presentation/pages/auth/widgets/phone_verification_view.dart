import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/auth/widgets/pinput_view.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../../app/util/export_file.dart';
import '../controller/auth_controller.dart';
import 'country_code_picker.dart';

class PhoneVerificationView extends GetView<AuthController> {

  int? userId;

   PhoneVerificationView({this.userId,super.key}){
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      print("check tyjhe ${userId}");

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: controller.otpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TractorText(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightblack,
                      text: 'Phone Verification'),
                  GestureDetector(
                    onTap: () {
                      controller. closeTimer();
                      controller.login();
                     },
                    child: TractorText(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      text: 'Skip',
                    ),
                  ),
                ],
              ),
              phoneWidget,
            Obx(() =>  controller.showPinView.isTrue? otpWidget:SizedBox())


            ],
          ),
        ),
      ),
    );
  }

  Widget get phoneWidget => Container(
        margin: EdgeInsets.only(top: 100.h),
        child: Column(
          children: [
            CountryCodePickerView(controller: controller.phoneController,
              onChanged: (phnNumber) {
                controller.phoneNumber = phnNumber;
                controller.update();
              },),
            SizedBox(
              height: 40.h,
            ),
            TractorButton(
              text: 'Send OTP',
              onTap: () {
                 if( controller.phoneController.text.isNotEmpty==true&&controller.otpKey.currentState?.validate()==true){
                   FocusManager.instance.primaryFocus!.unfocus();
                   controller.hitApiToSendOtp(userId: userId);
                }
              },
            ),
          ],
        ),
      );

  Widget get otpWidget => Container(
        margin: EdgeInsets.only(top: 50.h),
        child: Column(
          children: [
            Obx(() => Text(
                  "00:${controller.seconds.value < 10 ? "0${controller.seconds.value}" : controller.seconds.value}",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 24.sp),
                )),
            SizedBox(
              height: 20.h,
            ),
            TractorText(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.lightblack,
                textAlign: TextAlign.center,
                text: 'Type the verification code, We have sent you'),
            SizedBox(
              height: 20.h,
            ),
            Align(alignment: Alignment.center, child: PinPutView(
              controller: controller.otpController,
              onComplete: (pin){
                controller.hitApiToVerifyOtp(userId: userId,otp: pin);
              },
            )),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => GestureDetector(
                  onTap: () {
                    if (controller.seconds.value == 30) {
                      if( controller.phoneController.text.isNotEmpty==true&&controller.otpKey.currentState?.validate()==true){
                        FocusManager.instance.primaryFocus!.unfocus();
                        controller.hitApiToSendOtp(userId: userId);
                      }
                    }
                  },
                  child: TractorText(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: controller.seconds.value == 30
                          ? AppColors.lightGray
                          : AppColors.primary,
                      textAlign: TextAlign.center,
                      text: 'Resend OTP'),
                )),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      );
}
