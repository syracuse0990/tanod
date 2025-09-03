import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../components/add_space.dart';
import '../../../components/tractor_button.dart';
import '../../../components/tractor_text.dart';
import '../../../components/tractor_textfeild.dart';
import '../controller/auth_controller.dart';
import 'forgot_password_view.dart';

class SignInFormView extends GetView<AuthController> {
  SignInFormView({super.key}) {
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    controller.getRememberMe();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const TractorText(text: 'Email'),
          TractorTextfeild(
            controller: controller.emailLoginC,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            hint: 'Email',
          ),
          AddSpace.vertical(30.h),
          // const TractorText(text: 'Password'),
          Obx(
            () => TractorTextfeild(
              controller: controller.passwordLoginC,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Password',

              isSufix: true,
              isVisible:controller.isObsureText.value,
              obscureText:   controller.isObsureText.value ,
              onSufixTap: () {
                controller.isObsureText.value = !controller.isObsureText.value;
              },
            ),
          ),
          AddSpace.vertical(38.h),
          TractorButton(
            onTap: () {
              if (controller.loginValidation()) {
                FocusManager.instance.primaryFocus!.unfocus();
                controller.login();
              }
            },
          ),
          AddSpace.vertical(8.h),
          Row(
            children: [
              Obx(() => Checkbox(
                  visualDensity: VisualDensity.comfortable,
                  checkColor: AppColors.white,
                  fillColor: const MaterialStatePropertyAll(Colors.green),
                  value: controller.isRememberMe.value,
                  onChanged: (v) {
                    controller.isRememberMe.value = v ?? false;
                    controller.isRememberMe.refresh();
                  })),
              TractorText(
                text: 'Remember Me',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  Get.to(ForgotPasswordView());
                },
                child: TractorText(
                  text: 'Forgot Password?',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
