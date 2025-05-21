import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/profile_controller.dart';

import 'widgets/profile_tile_widget.dart';
import 'widgets/profile_top_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({super.key}){
    Get.lazyPut(()=>ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.profileBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileTopWidget(),
            Container(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              decoration: BoxDecoration(color: AppColors.white),
              child: Obx(() => Column(
                    children:
                        List.generate(controller.profileTiles.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.profileTiles[index].onTab != null) {
                            controller.profileTiles[index].onTab!();
                          }
                        },
                        child: ProfileTilesWidget(
                          index: index,
                        ),
                      );
                    }),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
