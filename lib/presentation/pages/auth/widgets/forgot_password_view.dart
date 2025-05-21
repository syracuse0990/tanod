import 'package:tanod_tractor/presentation/pages/auth/controller/auth_controller.dart';

import '../../../../app/util/export_file.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.forgotPassword,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Align(
              alignment: Alignment.center,
              child: TractorText(
                text: AppStrings.forgotYourPassword,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
              child: TractorText(
                text: AppStrings.resetByEmail,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),

            const TractorText(text: AppStrings.email),
            TractorTextfeild(
              controller: controller.forgotEmailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              hint: AppStrings.email,
            ),

            SizedBox(
              height: 100.h,
            ),


            TractorButton(
              text:AppStrings.submit,
              onTap: () {
                if (controller.forgotPasswordValidations()) {
                  FocusManager.instance.primaryFocus!.unfocus();
                  controller.hitAPiForForgotPassword();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
