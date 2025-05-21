import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/presentation/pages/auth/controller/auth_binding.dart';
import 'package:tanod_tractor/presentation/pages/auth/sign_in_page.dart';
import 'package:tanod_tractor/presentation/pages/dashboard/dashboard_page.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';
import 'package:tanod_tractor/presentation/router/routes.dart';

import '../app/config/app_colors.dart';
import '../data/providers/network/local_keys.dart';
import '../main.dart';

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
       initialRoute: RoutePage.splash ,
        getPages: appRoutes(),
       // home: TableEventsExample(),
        initialBinding: AuthBinding(),
       // home: box.read(tokenKeys) == null? SignInPage():DashBoardPage(),
      ),
      builder: (context, child) =>
          NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: child!),
    );
  }
}
