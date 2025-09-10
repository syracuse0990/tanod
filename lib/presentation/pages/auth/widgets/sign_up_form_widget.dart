import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';

import '../../../../app/config/app_colors.dart';
import '../../../components/add_space.dart';
import '../../../components/tractor_button.dart';
import '../../../components/tractor_text.dart';
import '../../../components/tractor_textfeild.dart';
import '../../../router/route_page_strings.dart';
import '../controller/auth_controller.dart';

class SignUpFormView extends GetWidget<AuthController> {
  const SignUpFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signupKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddSpace.vertical(30.h),
          // const TractorText(text: 'Name'),
          TractorTextfeild(
            controller: controller.nameC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,


            hint: 'Name',
          ),
          AddSpace.vertical(30.h),
          // const TractorText(text: 'Email'),
          TractorTextfeild(
            controller: controller.emailC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            isSufix: true,
            suffixWidget: Icon(
              Icons.arrow_circle_right_outlined,
              color: AppColors.primary,
            ),
            sufixIcons: AppSvgAssets.verification,
            onSufixTap: () {
              controller.hitApiToSendEmailOtp();
            },
            hint: 'Email',
          ),
          // AddSpace.vertical(30.h),
          // const TractorText(
          //   text: 'Verification Code',
          // ),
          // TractorTextfeild(
          //   controller: controller.otpC,
          //   textInputAction: TextInputAction.next,
          //   keyboardType: TextInputType.emailAddress,
          //   hint: 'Verification Code',
          // ),
          AddSpace.vertical(30.h),
          // const TractorText(text: 'Password'),
          Obx(
            () => TractorTextfeild(
              controller: controller.passwordC,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Password',
              isSufix: true,
              isVisible:  controller.isPasswordVisible.value,
              obscureText: controller.isPasswordVisible.value,
              onSufixTap: () {
                controller.isPasswordVisible.value =
                    !controller.isPasswordVisible.value;
              },
            ),
          ),
          AddSpace.vertical(30.h),
          // const TractorText(text: 'Confirm Password'),
          Obx(
            () => TractorTextfeild(
              controller: controller.comfirmPasswordC,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Confirm Password',
              isSufix: true,
              isVisible:  controller.isConfirmPasswordVisible.value,
              obscureText: controller.isConfirmPasswordVisible.value,
              onSufixTap: () {
                controller.isConfirmPasswordVisible.value =
                    !controller.isConfirmPasswordVisible.value;
              },
              onValidator: (data) {
                print("check data ${data}");
              },
              onChanged: (_) {
                controller.passwordValidation();
              },
            ),
          ),
          AddSpace.vertical(20.h),
          FlutterPwValidator(
              controller: controller.comfirmPasswordC,
              minLength: 8,
              uppercaseCharCount: 1,
              lowercaseCharCount: 1,
              numericCharCount: 3,
              specialCharCount: 1,
              width: 400,
              height: 0,
              onSuccess: () {
                controller.passwordValidated.value = true;
                controller.passwordValidated.refresh();
              },
              onFail: () {
                controller.passwordValidated.value = false;
                controller.passwordValidated.refresh();
              }),
          AddSpace.vertical(10.h),
          TractorText(
            text:
                'Password must be at least 8 character, 1 uppercase, 1 lowercase, and 1 special character (Password@123)',
            color: Colors.red.withOpacity(0.8),
            fontWeight: FontWeight.w700,
          ),
          const Spacer(),
          TractorButton(
            text: 'Sign Up',
            onTap: () {

              if (controller.signUpValidation()) {
                controller.signUp();
              }
            },
          ),
          AddSpace.vertical(40.h),
        ],
      ),
    );
  }
}
