import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/dialog_helper.dart';
import '../../../data/providers/network/api_provider.dart';

mixin class BaseController {
  String handleError(error, VoidCallback? hitApi, {bool isBack = true}) {
    String errorMessage = 'Something Went Wrong';
    if (isBack) {
      hideLoading();
    }

    if (error is BadRequestException) {
      var message = error.details;
      errorMessage = message;
      DialogHelper.showErroDialog(description: message, hitApi: hitApi);
    } else if (error is FetchDataException) {
      var message = error.details;
      errorMessage = message;
      DialogHelper.showErroDialog(description: message, hitApi: hitApi);
    } else if (error is UnauthorisedException) {
      var message = error.details;
      errorMessage = message;
      DialogHelper.showErroDialog(description: message, hitApi: hitApi);
    } else if (error is NoInternetException) {
      var message = error.details;
      errorMessage = message;
      DialogHelper.showErroDialog(description: message, hitApi: hitApi);
    } else if (error is FetchDataException) {
      errorMessage = 'Oops! It took longer to respond.';
      DialogHelper.showErroDialog(
          description: 'Oops! It took longer to respond.', hitApi: hitApi);
    } else {
      errorMessage = ErrorWidget(error).message;
      DialogHelper.showErroDialog(description: errorMessage, hitApi: hitApi);
    }
    return errorMessage;
  }


  showSuccessDialog(VoidCallback? hitApi,
      {String title = 'Success',
      String? description = 'Successfully',
      isNoButton = false}) {
      DialogHelper.showSuccesDialog(
        title: title,
        description: description,
        hitApi: hitApi,
        isNoButton: isNoButton);
  }

  showLoading([String? message]) {
    DialogHelper.showLoading(message??"");
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }

  showConfirmationDialog(VoidCallback onDelete) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                onDelete();

                print('Delete confirmed');
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Get.back();

                print('Delete canceled');
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showToast(message,
      {Color? bgColor, textColor, int? time}) {

    if (message.toString().trim().isEmpty) {
      return;
    }
    if (message.toString().toLowerCase().contains("dio")) {
      return;
    }

    Future.delayed(Duration(milliseconds: time ?? 300), () {
      Get.snackbar(
        AppStrings.title,
        message??"",
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(30.r),
        backgroundColor: bgColor ?? AppColors.primary,
        colorText: textColor ?? AppColors.white,
      );
      // Get.toNamed(RoutePageString.addFarm);
    });
  }
}
