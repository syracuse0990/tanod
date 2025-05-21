import 'package:flutter_svg/svg.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../alert/views/alert_view.dart';
import '../list/list_page.dart';
import '../map_modules/map_home_screen.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/profile_page.dart';
import 'controller/dishboard_controller.dart';

class DashBoardPage extends GetView<DashboardController> {
  DashBoardPage({super.key}) {
    // controller. iProfileRepository = Get.put(RemoteIProfileProvider());
    print("on init called  DashBoardPage");
  }

  final List<Widget> _pages = [
    MapHomeScreen(),
    ListPage(),

  //  SizedBox(),
   // ListPage(),
   AlertView(),
   // const MaintenancePageView(),
   ProfilePage(),
  ];

  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: Obx(() => _pages[_selectedIndex.value]),
        bottomNavigationBar: Obx(() => Container(
              height: Get.height * 0.11,
              width: Get.width,
              decoration: ShapeDecoration(
                  shape: Border(
                      top: BorderSide(
                          width: 1,
                          color: AppColors.lightGray.withOpacity(0.2)))),
              child: BottomNavigationBar(
                elevation: 10,
                showUnselectedLabels: true,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.lightGray,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.8)),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        color: AppColors.lightGray,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.8)),
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppSvgAssets.home,
                        height: 25.h,
                        colorFilter: ColorFilter.mode(
                            _selectedIndex.value == 0
                                ? AppColors.primary
                                : AppColors.lightGray,
                            BlendMode.srcIn),
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppSvgAssets.list,
                        height: 23.h,
                        colorFilter: ColorFilter.mode(
                            _selectedIndex.value == 1
                                ? AppColors.primary
                                : AppColors.lightGray,
                            BlendMode.srcIn),
                      ),
                      label: 'List'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppSvgAssets.alerts,
                        height: 25.h,
                        colorFilter: ColorFilter.mode(
                            _selectedIndex.value == 2
                                ? AppColors.primary
                                : AppColors.lightGray,
                            BlendMode.srcIn),
                      ),
                      label: 'Alert'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        AppSvgAssets.profile,
                        height: 25.h,
                        colorFilter: ColorFilter.mode(
                            _selectedIndex.value == 3
                                ? AppColors.primary
                                : AppColors.lightGray,
                            BlendMode.srcIn),
                      ),
                      label: 'Profile'),
                ],
                currentIndex: _selectedIndex.value,
            onTap: (index) {
                _selectedIndex.value = index;
                if(_selectedIndex.value==3){
                  Get.lazyPut(()=>ProfileController());
                }
              },
              ),
            )),
      ),
    );
  }
}
