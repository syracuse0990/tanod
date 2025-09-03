import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/data/providers/network/api_endpoint.dart';
import 'package:tanod_tractor/presentation/components/tractor_appbar.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../data/providers/network/local_keys.dart';
import '../../../main.dart';

class ListPage extends StatelessWidget {
  final controller = Get.put(ListController());
  ListPage({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TractorBackArrowBar(
          leading: SizedBox(),
          firstLabel:  'Lists',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          actions: [
            box.read(roleType) == APIEndpoint.aminRole
                ? Bounce(
                    duration: const Duration(milliseconds: 180),
                    onPressed: () {
                      Get.toNamed(RoutePage.createNewGroup);
                    },
                    child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: AppColors.white,
                        child: SvgPicture.asset(
                          AppSvgAssets.add,
                          height: 25.h,
                        )),
                  )
                : SizedBox(),
          ],
        ),
        body: DefaultTabController(
          length: controller.tabTitles.length,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TabBar(
                  isScrollable:
                  box.read(roleType) == APIEndpoint.aminRole || box.read(roleType) == APIEndpoint.subAdminRole 
                      ? false : true,
                  tabAlignment:              box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole
                      ?null:TabAlignment.start,
                  physics: NeverScrollableScrollPhysics(),
                  overlayColor: MaterialStatePropertyAll(AppColors.white),
                  indicatorColor: AppColors.primary,
                  unselectedLabelColor: AppColors.lightGray,
                  labelColor: AppColors.primary,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  labelStyle: TextStyle(
                    fontFamily:
                        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                            .fontFamily,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily:
                        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                            .fontFamily,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGray,
                  ),
                  tabs: controller.tabTitles.map((title) {
                    return Tab(
                      text: title,
                    );
                  }).toList(),
                  onTap: (index) {
                    controller.selectedIndex.value = index;
                    if( box.read(roleType) == APIEndpoint.technicianRole){
                       controller.hitApiToGetDeviceList(stateId: {'state': 1});
                    }
                    if (index == 1) {
                      controller.hitApiToGetDeviceList(stateId: {'state': 1});
                    } else if (index == 2) {
                      controller.hitApiToGetDeviceList(stateId: {'state': 2});
                    } else if (index == 3) {
                      controller.hitApiToGetDeviceList(stateId: {'state': 3});
                    }
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: controller.pageList,
                ),
              ),
            ],
          ),
        ));
  }
}
