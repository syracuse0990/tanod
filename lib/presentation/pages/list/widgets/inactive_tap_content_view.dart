import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_state_handler/page_state_handler.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

import '../../../../app/config/app_colors.dart';
import 'list_tile_widget.dart';

class InactiveTabContentView extends GetWidget<ListController> {
  const InactiveTabContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageStateHandler(
      controller: controller.pageStateController,
   //   onRefresh: () => Future(() => controller.retry()),
      rColor: AppColors.primary,
      loading: CircularProgressIndicator(
        color: AppColors.primary,
      ),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTileWidget(
              text: 'Tractor $index',
              id: '12312312444',
              status: 'Stopped',
            );
          }),
    );
  }
}
