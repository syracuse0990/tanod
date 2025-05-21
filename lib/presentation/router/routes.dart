import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/assign_groups/bindings/assign_group_bindings.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/assign_groups/views/assign_group_view.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/sub_admin/bindings/sub_admin_bindings.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/sub_admin/views/sub_admin_view.dart';
import 'package:tanod_tractor/presentation/pages/alert/views/alert_view.dart';
import 'package:tanod_tractor/presentation/pages/auth/controller/auth_binding.dart';
import 'package:tanod_tractor/presentation/pages/auth/sign_in_page.dart';
import 'package:tanod_tractor/presentation/pages/auth/sign_up_page.dart';
import 'package:tanod_tractor/presentation/pages/auth/widgets/phone_verification_view.dart';
import 'package:tanod_tractor/presentation/pages/dashboard/dashboard_page.dart';
import 'package:tanod_tractor/presentation/pages/geofence/geofence_page.dart';
import 'package:tanod_tractor/presentation/pages/list/tractor_groups_page.dart';
import 'package:tanod_tractor/presentation/pages/reservation/reservation_page.dart';
import 'package:tanod_tractor/presentation/pages/settings/settings_page.dart';
import 'package:tanod_tractor/presentation/pages/splash/views/splash_page.dart';
import 'package:tanod_tractor/presentation/pages/tickets/controllers/ticket_controller.dart';
import 'package:tanod_tractor/presentation/pages/tickets/views/ticket_view.dart';
import 'package:tanod_tractor/presentation/pages/userlog/userlog_page.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../pages/admin_modules/admin_bookings/bindings/admin_booking_bindings.dart';
import '../pages/admin_modules/admin_bookings/views/admin_booking_view.dart';
import '../pages/admin_modules/admin_feedback/bindings/admin_feedback_bindings.dart';
import '../pages/admin_modules/admin_feedback/views/admin_feedback_view.dart';
import '../pages/admin_modules/calender_view/bindings/calender_view_bindings.dart';
import '../pages/admin_modules/calender_view/views/tractor_calender_view.dart';
import '../pages/admin_modules/create_group/bindings/create_group_bindings.dart';
import '../pages/admin_modules/create_group/views/create_group_view.dart';
import '../pages/admin_modules/geofence/bindings/geofence_binding.dart';
import '../pages/admin_modules/geofence/views/admin_geofence_view.dart';
import '../pages/admin_modules/issue_type/bindings/issue_type_bindings.dart';
import '../pages/admin_modules/issue_type/views/issue_type_view.dart';
import '../pages/admin_modules/static_pages/bindings/static_page_bindings.dart';
import '../pages/admin_modules/static_pages/views/admin_static_page_view.dart';
import '../pages/admin_modules/user_management/bindings/user_management_bindings.dart';
import '../pages/admin_modules/user_management/views/user_management_view.dart';
import '../pages/alert/bindings/alert_bindings.dart';
import '../pages/common_modules/devices/bindings/device_bindings.dart';
import '../pages/common_modules/devices/views/common_device_view.dart';
import '../pages/common_modules/tractors/bindings/tractors_bindings.dart';
import '../pages/common_modules/tractors/views/add_new_tractor.dart';
import '../pages/common_modules/tractors/views/common_tractor_view.dart';
import '../pages/dashboard/controller/dishboard_bindings.dart';
import '../pages/device_all_alert/bindings/device_all_alert_bindings.dart';
import '../pages/device_all_alert/views/device_all_alert_view.dart';
import '../pages/feedback/bindings/feedback_bindings.dart';
import '../pages/feedback/views/feedback_view.dart';
import '../pages/list/controller/list_bindings.dart';
import '../pages/list/widgets/group_detail_page.dart';
import '../pages/maintenance/bindings/maintenance_binding.dart';
import '../pages/maintenance/views/issue_maintenance_page.dart';
import '../pages/maintenance/views/maintenance_page_view.dart';

appRoutes() => [
      GetPage(
        name: RoutePage.signIn,
        page: () => const SignInPage(),
        middlewares: [LoginMiddelware()],
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.splash,
        page: () => const SplashPage(),
        binding: AuthBinding(),
        middlewares: [LoginMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutePage.signUp,
        page: () => const SignUpPage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutePage.phone,
        page: () => PhoneVerificationView(userId: Get.arguments as int),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
          name: RoutePage.dashboard,
          page: () => DashBoardPage(),
          binding: DashboardBindings()

          // transition: Transition.rightToLeft,
          ),
      GetPage(
        name: RoutePage.tractorGroups,
        page: () => const TractorGroupsPage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutePage.issueMaintenance,
        page: () => IssueMaintenancePage(maintenanceDetailModel: null),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
          name: RoutePage.maintenance,
          page: () => const MaintenancePageView(),
          binding: MaintenanceBindings()),
      GetPage(
        name: RoutePage.geoFence,
        page: () => const GeoFencePage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.userLog,
        page: () => const UserLogPage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutePage.settings,
        page: () => const SettingPage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutePage.reservation,
        page: () => ReservationPage(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.adminAddIssueTitle,
        page: () =>
            IssueTypeView(arguments: Get.arguments as Map<String, dynamic>),
        binding: IssueTypeBindings(),
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.tractorCalenderView,
        page: () => TractorCalenderView(),
        binding: TractorCalenderBindings(),
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.userManagementView,
        page: () => UserManagementView(),
        binding: UserManagementBindings(),
        // transition: Transition.rightToLeft,
      ),

      GetPage(
        name: RoutePage.groupPageDetail,
        page: () => GroupDetailPage(index: Get.arguments as int),
        binding: ListBindings(),
        middlewares: [MyMiddelware()],
        // transition: Transition.rightToLeft,
      ),

      //for admin
      GetPage(
        name: RoutePage.createNewGroup,
        page: () => CreateGroupView(groupsModel: Get.arguments as dynamic),
        binding: CreateGroupBindings(),
      ),

      GetPage(
        name: RoutePage.adminFeedback,
        page: () => AdminFeedbackPage(),
        binding: AdminFeedbackBindings(),
      ),

      GetPage(
        name: RoutePage.addNewTractors,
        page: () =>
            AddNewTractorView(arguments: Get.arguments as Map<String, dynamic>),
        binding: CommonTractorBindings(),
      ),

      GetPage(
        name: RoutePage.commonDeviceView,
        page: () => CommonDeviceView(),
        binding: CommonDeviceBindings(),
      ),

      GetPage(
        name: RoutePage.staticPages,
        page: () => AdminStaticPageView(),
        binding: StaticPageBindings(),
      ),

      GetPage(
        name: RoutePage.commonTractorView,
        page: () => CommonTractorView(),
        binding: CommonTractorBindings(),
      ),

      GetPage(
        name: RoutePage.alertView,
        page: () => DeviceAllAlertView(
            arguments: Get.arguments as Map<String, dynamic>),
        binding: DeviceAllAlertBindings(),
      ),

      GetPage(
        name: RoutePage.adminBookingView,
        page: () =>
            AdminBookingView(arguments: Get.arguments as Map<String, dynamic>),
        binding: AdminBookingBindings(),
      ),

      GetPage(
        name: RoutePage.geofence,
        page: () => AdminGeoFenceView(),
        binding: GeoFenceBindings(),
      ),

      GetPage(
          name: RoutePage.feedback,
          page: () => const FeedbackPage(),
          binding: FeedbackBindings()
          // transition: Transition.rightToLeft,
          ),

      GetPage(
          name: RoutePage.ticket,
          page: () => const TicketView(),
           binding: BindingsBuilder(() {
            Get.lazyPut(() => TicketController());
          })),

      GetPage(
          name: RoutePage.subAdmin,
          page: () =>
              SubAdminView(arguments: Get.arguments as Map<String, dynamic>),
          binding: SubAdminBindings()
          // transition: Transition.rightToLeft,
          ),

      GetPage(
          name: RoutePage.assignGroups,
          page: () => AssignGroupsView(
                arguments: Get.arguments as Map<String, dynamic>?,
              ),
          binding: AssignGroupBindings()
          // transition: Transition.rightToLeft,
          ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint(page?.name);
    return super.onPageCalled(page);
  }
}

class LoginMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    debugPrint(page?.name);
    return super.onPageCalled(page);
  }
}
