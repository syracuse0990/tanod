import 'package:flutter/gestures.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/auth/widgets/static_view.dart';

import '../../router/route_page_strings.dart';
import 'controller/auth_controller.dart';
import 'widgets/sign_up_form_widget.dart';

class SignUpPage extends GetView<AuthController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                    text: 'Sign Up'),
                GestureDetector(
                  onTap: () {
                     Get.offAllNamed(RoutePage.signIn);
                  },
                  child: TractorText(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    text: 'Cancel',
                  ),
                ),
              ],
            ),
            AddSpace.vertical(20.h),
            TractorSpanText(
              firstLabel: 'By click the sign up button, you’re agree to ',
              secondLabel: 'TanodTractor ',
              lastTextStyle: TextStyle(
                fontFamily:
                    GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800)
                        .fontFamily,
                color: AppColors.lightGray,
                fontSize: 12.sp,
              ),
            ),
            TractorSpanText(
              onFirstTap:  () {
                controller.detailDataModel.value=null;
                Get.to(StaticPages(title:  AppStrings.termsAndServices,type: APIEndpoint.termsAndCondition,));
              },
              firstLabel: AppStrings.termsAndServices,
              firstTextStyle: TextStyle(
                fontFamily:
                    GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)
                        .fontFamily,
                color: AppColors.primary,
                fontSize: 14.sp,
              ),
              secondLabel: ' and acknowledge the ',
              lastTextStyle: TextStyle(
                fontFamily:
                    GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)
                        .fontFamily,
                color: AppColors.lightGray,
                fontSize: 14.sp,
              ),
              third: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=(){
                    controller.detailDataModel.value=null;
                   Get.to(StaticPages(title:  AppStrings.privacyPolicy,type: APIEndpoint.privacyPolicy));
                  },
                  text: AppStrings.privacyPolicy,
                  style: TextStyle(
                    fontFamily:
                        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)
                            .fontFamily,
                    color: AppColors.primary,
                    fontSize: 14.sp,
                  )),
            ),
            const Expanded(flex: 5, child: SignUpFormView()),
          ],
        ),
      ),
    ));
  }
}
