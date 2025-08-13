import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/data/repositories/login_provider/interface/ilogin_repository.dart';
import 'package:tanod_tractor/presentation/pages/auth/controller/auth_controller.dart';
import 'package:tanod_tractor/presentation/pages/base/base_controller.dart';
import 'package:tanod_tractor/presentation/pages/profile/controller/setting_tile_model.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/util/media_select_dialog.dart';
import '../../../../app/util/util.dart';
import '../../../../calender_view.dart';
import '../../../../data/models/my_booking_model.dart';
import '../../../../data/models/user_booking_detail_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/providers/network/api_endpoint.dart';
import '../../../../data/providers/network/local_keys.dart';
import '../../../../data/repositories/home_provider/impl/remote_home_provider.dart';
import '../../../../data/repositories/home_provider/interface/ihome_repository.dart';
import '../../../../data/repositories/login_provider/impl/remote_login_provider.dart';
import '../../../../data/repositories/profile_provider/impl/remote_profile_provider.dart';
import '../../../../data/repositories/profile_provider/interface/iprofile_repository.dart';
import '../../../../main.dart';
import '../../../router/route_page_strings.dart';
import '../../reservation/controller/reservation_bindings.dart';
import '../../settings/controller/settings_bindings.dart';
import '../widgets/logout_dialog.dart';
import '../widgets/my_bookings.dart';
import '../widgets/my_bookings_calender_tile.dart';

class ProfileController extends GetxController with BaseController {
  IProfileRepository? iProfileRepository;
  IHomeRepository? iHomeRepository;
  var dateTime = Rxn<DateTime>();
  RxList<Meeting>? meetingList = <Meeting>[].obs;
  Map<String, dynamic> bookingMap = {};
  var bookingDetail = Rxn<UserBookingDetailDataModel>();

  RxList<BookingDetailModel>? bookingList = <BookingDetailModel>[].obs;
  RxList<BookingDetailModel>? selectedBookingList = <BookingDetailModel>[].obs;
  ILoginRepository? iLoginRepository;

  var eventList = Rxn<EventList<Event>>();

  var profileImage = Rxn<File>();

  var userDataModel = Rxn<UserDataModel>();
  RxList<SettingTileModel> profileTiles = <SettingTileModel>[].obs;

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iHomeRepository = Get.put(RemoteIHomeProvider());
      iProfileRepository = Get.put(RemoteIProfileProvider());
      iLoginRepository = Get.put(RemoteILoginProvider());
      initListBasedOnRole();
      hitApiToGetUserDetails();

      dateTime.value = DateTime.now();
      dateTime.refresh();
    });
    // TODO: implement onInit
    super.onInit();
  }

  initListBasedOnRole() {
    profileTiles.clear();
    if (box.read(roleType) == APIEndpoint.aminRole ||
        box.read(roleType) == APIEndpoint.subAdminRole) {
      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.userManagementView);
          },
          isIcon: true,
          icon: AppPngAssets.userManagementImage,
          title: AppStrings.userManagement));

      if (box.read(roleType) == APIEndpoint.aminRole)
        profileTiles.add(SettingTileModel(
            onTab: () {
              Get.toNamed(RoutePage.subAdmin,
                  arguments: {"group_index": -1, "group_id": -1});
            },
            isIcon: true,
            icon: AppPngAssets.userManagementImage,
            title: AppStrings.subAdmin));

      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.maintenance,
          title: AppStrings.maintenance,
          onTab: () {
            Get.toNamed(RoutePage.maintenance);
          }));

      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.geofence);
          },
          icon: AppSvgAssets.geoFence,
          title: AppStrings.geoFence));

      profileTiles.add(SettingTileModel(
          isIcon: true,
          onTab: () {
            Get.toNamed(RoutePage.commonDeviceView);
          },
          icon: AppPngAssets.devices,
          title: AppStrings.devices));

      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.commonTractorView);
          },
          isIcon: true,
          icon: AppPngAssets.tractors,
          title: AppStrings.tractors));

      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.adminFeedback);
          },
          isIcon: true,
          icon: AppPngAssets.farmerFeedbackImage,
          title: AppStrings.tractorReports));

      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.adminBookingView, arguments: {"id": null});
          },
          icon: AppSvgAssets.commandLogs,
          title: AppStrings.bookings));
      if (box.read(roleType) == APIEndpoint.aminRole)
        profileTiles.add(SettingTileModel(
            onTab: () {
              Get.toNamed(RoutePage.adminAddIssueTitle,
                  arguments: {"from_user": false, "id": -1});
            },
            isIcon: true,
            icon: AppPngAssets.addNewIssues,
            title: AppStrings.issuesType));
      if (box.read(roleType) == APIEndpoint.aminRole)
        profileTiles.add(SettingTileModel(
            onTab: () {
              Get.toNamed(RoutePage.staticPages);
            },
            isIcon: true,
            icon: AppPngAssets.staticPageImage,
            title: AppStrings.staticPages));

      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.logout,
          title: 'Logout',
          onTab: () {
            Get.dialog(LogoutDialog(
              onLogout: () {
                hitApiToLogoutUser();
              },
            ));
          }));

    }else if(box.read(roleType) == APIEndpoint.technicianRole) {
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.maintenance,
          title: AppStrings.maintenance,
          onTab: () {
            Get.toNamed(RoutePage.maintenance);
          }));
      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.geofence);
          },
          icon: AppSvgAssets.geoFence,
          title: AppStrings.geoFence));

      profileTiles.add(SettingTileModel(
          isIcon: true,
          onTab: () {
            Get.toNamed(RoutePage.commonDeviceView);
          },
          icon: AppPngAssets.devices,
          title: AppStrings.devices));

      profileTiles.add(SettingTileModel(
          onTab: () {
            Get.toNamed(RoutePage.commonTractorView);
          },
          isIcon: true,
          icon: AppPngAssets.tractors,
          title: AppStrings.tractors));
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.logout,
          title: 'Logout',
          onTab: () {
            Get.dialog(LogoutDialog(
              onLogout: () {
                hitApiToLogoutUser();
              },
            ));
          }));
        
    } else {
      /* profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.geoFence,
          title: 'Geo Fence',
          onTab: () {
            GeoFenceBindings().dependencies();
            Get.toNamed(RoutePage.geoFence);
          }));*/
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.feedback,
          title: 'Feedback',
          onTab: () {
            Get.toNamed(RoutePage.feedback);
          }));
      profileTiles.add(SettingTileModel(
          icon: AppPngAssets.ticketImage,
          isIcon: true,
          title: 'Raise Ticket',
          onTab: () {
            Get.toNamed(RoutePage.ticket);
          }));
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.commandLogs,
          title: 'MyBookings',
          onTab: () {
            SettingBindings().dependencies();
            Get.to(MyBookingView());
          }));
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.settings,
          title: 'Settings',
          onTab: () {
            SettingBindings().dependencies();
            Get.toNamed(RoutePage.settings);
          }));
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.reservation,
          title: 'Reservation',
          onTab: () {
            ReservationBindings().dependencies();
            Get.toNamed(RoutePage.reservation);
          }));
      profileTiles.add(SettingTileModel(
          icon: AppSvgAssets.logout,
          title: 'Logout',
          onTab: () {
            Get.dialog(LogoutDialog(
              onLogout: () {
                hitApiToLogoutUser();
              },
            ));
          }));
    }
    profileTiles.refresh();
  }

  Future hitApiToGetUserDetails() async {
    showLoading("Loading");

    await iProfileRepository?.getUserDetails().then((value) {
      hideLoading();
      if (value != null) {
        userDataModel.value = value.success;
        if (userDataModel.value?.profilePhotoPath != null) {
          profileImage.value = File(
              "${APIEndpoint.imageUrl}${userDataModel.value?.profilePhotoPath}");
          profileImage.refresh();
        }
        userDataModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToGetBookingList(bookingMap) async {
    bookingList?.clear();
    eventList.value?.events.clear();

    await iHomeRepository?.bookingList(map: bookingMap).then((value) {
      if (value != null && value.data != null) {
        bookingList?.addAll(value.data?.bookings ?? []);
        bookingList?.refresh();
        setDataOnCalender();
      }
    }).onError((error, stackTrace) {
      showToast(message: error?.toString());
    });
  }

  setDataOnCalender() {
    meetingList?.clear();
    if (bookingList != null && bookingList?.length != 0) {
      bookingList?.forEach((element) {
        if (element.stateId?.toString() == AppStrings.activeId.toString()) {
          meetingList?.add(Meeting("Pending", DateTime.parse(element.date),
              DateTime.parse(element.date), Colors.yellow, false));
        } else if (element.stateId?.toString() ==
            AppStrings.acceptedId.toString()) {
          meetingList?.add(Meeting(
              AppStrings.accepted,
              DateTime.parse(element.date),
              DateTime.parse(element.date),
              AppColors.primary,
              false));
        } else {
          meetingList?.add(Meeting(
              AppStrings.rejected,
              DateTime.parse(element.date),
              DateTime.parse(element.date),
              AppColors.red,
              false));
        }
      });
    }
    meetingList?.refresh();
  }

  hitApiToBookingDetails({bookingId}) async {
    print("they have cliked me ");
    showLoading();
    await iHomeRepository
        ?.userBookingDetailApi(map: {"id": bookingId}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        bookingDetail.value = value.data;
        bookingDetail.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToLogoutUser() async {
    showLoading();
    await iLoginRepository?.logoutApi().then((value) {
      hideLoading();
      if (value != null) {
        box.remove(tokenKeys);
        box.remove(roleType);
        Get.offAllNamed(RoutePage.signIn);
        Get.put(AuthController(Get.find(), Get.find(), Get.find()));

        showToast(message: value.message ?? "");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  //updateUserProfile
  showImageDialog() {
    Get.dialog(MediaSelectDialog(
      selectedImage: (fileImage) {
        var bytes = fileImage.readAsBytesSync().length;
        if (bytes > 5000000) {
          showToast(message: AppStrings.imageSizeLength);
          return;
        }

        if (fileImage != null) {
          profileImage.value = fileImage;
          profileImage.refresh();
          hitApiToUpdateUserProfile(fileImage);
        }
      },
    ));
  }

  hitApiToUpdateUserProfile(File? file) async {
    showLoading();
    await iLoginRepository?.updateUserProfile(file: file).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message: value.message ?? "");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  getListBasedOnSelection(DateTime? selectedDate) {
    if (bookingList != null && bookingList?.length != 0) {
      String formattedDate =
          DateFormat("yyyy-MM-dd").format(selectedDate ?? DateTime.now());
      selectedBookingList?.clear();
      selectedBookingList?.value = bookingList?.value
              .where((element) => element?.date == formattedDate)
              .toList() ??
          [];
      Get.to(MyBookingCalenderTileView());
    }
  }
}
