import 'package:flutter/scheduler.dart';
import 'package:page_state_handler/page_state_handler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../data/models/admin_booking_model.dart';
import '../../../../data/repositories/admin_booking_provider/impl/remote_admin_booking_provider.dart';
import '../../../../data/repositories/admin_booking_provider/interface/iadmin_booking_repository.dart';
import '../../../../data/repositories/home_provider/impl/remote_home_provider.dart';
import '../../../../data/repositories/home_provider/interface/ihome_repository.dart';
import '../tractor_groups_page.dart';
import '../widgets/all_tap_content_view.dart';

class ListController extends GetxController with BaseController {
  RxInt selectedIndex = 0.obs;
  RxInt selectedDetailIndex = 0.obs;

  PageStateController pageStateController = PageStateController();
  IAdminBookingRepository? iAdminBookingRepository;
  IHomeRepository? iHomeRepository;
  TractorGroupDataModel? tractorGroupDataModel;
  RxList<GroupsModel>? groupList = <GroupsModel>[].obs;
  RxInt pageNumber = 1.obs;
  ScrollController scrollController = ScrollController();

  RxInt selectedGroupIndex = 0.obs;

  RxList<PopupMenuItem> popupList = <PopupMenuItem>[].obs;

  RxList<DevicesModel>? stateDeviceList = <DevicesModel>[].obs;
  RxList<DeviceDataModel>? deviceList = <DeviceDataModel>[].obs;
  
  List<String> tabTitles = [];
  List<String> detailTabList = ['Farmers', 'Tractors', 'Devices', 'Bookings'];

  ISubAdminRepository? iSubAdminRepository;

  List<Widget> pageList = [];

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setListBasesOnRoles();
      setPageList();
      //setDetailPageList();
    });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iSubAdminRepository = Get.put(RemoteISubAdminProvider());
      iAdminBookingRepository = Get.put(RemoteIAdminBookingProvider());
      iHomeRepository = Get.put(RemoteIHomeProvider());
      groupList?.clear();

      if (box.read(tokenKeys) != null) {
        hitApiToGetTractorList();
        addPaginationOnTractorList();
      }
    });
    super.onInit();
  }

  //todo for the assign groups to user
  Future hitApiToAssignGroup(
      {index, id, subAdminId, isAssigned, groupIndex}) async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['user_id'] = subAdminId;
    map['state'] = isAssigned;

    await iSubAdminRepository?.assignGroupToSubAdmin(map: map).then((value) {
      hideLoading();
      if (value != null) {
        groupList?[groupIndex].subAdmin = null;
        groupList?.refresh();


        groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();

      showToast(message: error?.toString());
    });
  }

  setListBasesOnRoles() {
    if (box.read(roleType) == APIEndpoint.subAdminRole||box.read(roleType) == APIEndpoint.aminRole) {
      tabTitles = [
        'Groups',
        'All',
        'Online',
        'Offline',
      ];
    } else {
      tabTitles = [
        'Devices',
      ];
    }
    Get.forceAppUpdate();
  }

  setPageList() {
    if (box.read(roleType) == APIEndpoint.subAdminRole||box.read(roleType) == APIEndpoint.aminRole) {
      pageList = [
        TractorGroupsPage(),
        AllTabContentView(),
        AllTabContentView(),
        AllTabContentView(),
      ];
    } else {
      pageList = [
        // TractorGroupsPage(),
        AllTabContentView(),
      ];
    }
    Get.forceAppUpdate();
  }

  setDetailPageList() {
    if (box.read(roleType) == APIEndpoint.subAdminRole||box.read(roleType) == APIEndpoint.aminRole) {
      detailTabList = ['Farmers', 'Tractors', 'Devices', 'Bookings'];
    } else {
      detailTabList = ['Farmers', 'Tractors', 'Devices', ""];
    }
    Get.forceAppUpdate();
  }

  //here we get all list basesd on state
  Future hitApiToGetDeviceList({stateId}) async {
    iHomeRepository = Get.put(RemoteIHomeProvider());
    stateDeviceList?.clear();
    showLoading("Loading");
    stateId['role_id']=box.read(roleType);
    await iHomeRepository?.getAllDeviceStateList(map: stateId).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        stateDeviceList?.addAll(value.data ?? []);
        stateDeviceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

   //here we get all list basesd on state
  Future hitApiToGetDeviceListTechnician() async {
    iHomeRepository = Get.put(RemoteIHomeProvider());
    deviceList?.clear();
    showLoading("Loading");

    await iHomeRepository?.getAllDeviceList().then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        deviceList?.addAll(value.data as Iterable<DeviceDataModel>);
        deviceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  showPopUpMenuButton({onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 0,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.viewDetails),
        ),
        // PopupMenuItem(
        //   onTap: () {
        //     if (onEditTab != null) {
        //       onEditTab!();
        //     }
        //   },
        //   value: 1,
        //   // row has two child icon and text.
        //   child: TractorText(text: AppStrings.edit),
        // ),
        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteGroup),
        )
      ],
    );
  }

  Future hitApiToGetTractorList({showLoader}) async {
    try{
    //  if (showLoader == null) {
     //   showLoading("Loading");
    //  }

      Map<String, dynamic> map = {};
      map['records_per_page'] = 10;
      map['page_no'] = pageNumber.value;
      iHomeRepository = Get.put(RemoteIHomeProvider());
      await iHomeRepository?.getAllGroupTractorList(map: map).then((value) {
        if (showLoader == null) {
          hideLoading();
        }
        if (value != null && value.data != null) {
          tractorGroupDataModel = value.data;
          groupList?.addAll(tractorGroupDataModel?.groups ?? []);
          groupList?.refresh();
        }
      }).onError((error, stackTrace) {
       // if (showLoader == null) {
       //   hideLoading();
      //  }
        showToast(message: error?.toString());
      });
    }catch(e){
      print("exceptions ${e}");
     // if (showLoader == null) {
      //  hideLoading();
     // }
    }
  }

  addPaginationOnTractorList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (tractorGroupDataModel != null &&
            int.parse(tractorGroupDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    tractorGroupDataModel?.totalPages?.toString() ?? "1")) {
          pageNumber.value = pageNumber.value + 1;
          pageNumber.refresh();
          hitApiToGetTractorList();
        }
      }
    });
  }

  Future hitApiToDeleteGroup(id, index) async {
    showLoading("Loading");
    await iHomeRepository?.deleteGroup(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message:value.message ?? "");
        groupList?.removeAt(index);
        groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message:error?.toString());
    });
  }

  hitApiToChangeBookingStatus(List<BookingModel>? bookingList,
      {id, status, index, reason}) async {
    showLoading();

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['status'] = status;
    map['reason'] = reason;

    await iAdminBookingRepository?.changeBookingStatus(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        groupList?[selectedGroupIndex.value].bookings![index] = value.data!;
        groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message:error?.toString());
    });
  }

}
