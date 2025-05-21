import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/components/span_text.dart';
import 'package:tanod_tractor/presentation/pages/splash/views/splash_page.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import 'controller/auth_controller.dart';
import 'widgets/sign_in_form_widget.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.showSplash.value
          ? const SplashPage()
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.w),
                      child: Image.asset(AppPngAssets.appLogo),
                    )),
                Expanded(flex: 5, child: SignInFormView()),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 30.h),
                      alignment: Alignment.bottomCenter,
                      child: TractorSpanText(
                          onTap: () {

                            Get.offAllNamed(RoutePage.signUp);
                          },
                          firstLabel: '${AppStrings.doNotHaveAccount} ',
                          secondLabel: AppStrings.signUp,
                          align: Alignment.bottomCenter),
                    )),
              ],
            ),
    ));
  }
}
