import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';

import '../../../../../app/util/util.dart';
import '../../../../../data/models/device_model.dart';
import '../../../../../data/models/farmer_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../../../../data/models/tractor_group_model.dart';
import '../../../../../data/models/tratcor_model.dart';
import '../../../../../data/repositories/home_provider/impl/remote_home_provider.dart';
import '../../../../../data/repositories/home_provider/interface/ihome_repository.dart';
import '../../../../../data/repositories/tractors_provider/impl/remote_tractor_provider.dart';
import '../../../../../data/repositories/tractors_provider/interface/itractor_repository.dart';
import '../../../base/base_controller.dart';
import '../../../list/controller/list_controller.dart';

class CreateGroupController extends GetxController with BaseController {
  RxString selectFarmers = AppStrings.selectFramer.obs;
  RxString selectTractor = AppStrings.selectGroupTractors.obs;
  RxString selectDevices = AppStrings.selectGroupDevices.obs;
  RxString selectState = AppStrings.selectState.obs;

  RxList<StateModel>? stateList = <StateModel>[].obs;

  IHomeRepository? iHomeRepository;
  var stateModel = Rxn<StateModel>();

  var nameController = TextEditingController();

  DeviceDetailDataModel? deviceDetailDataModel;

  var groupDetailModel = Rxn<GroupsModel>();
  RxInt devicePage = 1.obs;
  RxInt listCurrentIndex = 0.obs;
  ScrollController deviceController = ScrollController();
  RxList<DevicesModel>? deviceDataList = <DevicesModel>[].obs;

  ScrollController tractorController = ScrollController();
  RxInt tractorPage = 1.obs;
  TractorDetailDataModel? tractorDetailDataModel;

  RxList<TractorModel>? tractorList = <TractorModel>[].obs;
  ITractorRepository? iTractorRepository;

  FarmerDataModel? farmerDataModel;
  RxInt farmerPage = 1.obs;
  ScrollController farmerController = ScrollController();
  RxList<FarmerModel>? farmerList = <FarmerModel>[].obs;

  @override
  void onInit() {
    ///stateListInit();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iHomeRepository = Get.put(RemoteIHomeProvider());
      iTractorRepository = Get.put(RemoteITractorProvider());

      addPaginationOnFarmerList();
      addPaginationForDeviceList();
      addPaginationOnTractorList();

      showDataOnScreen();
    });
    // TODO: implement onInit
    super.onInit();
  }

  showDataOnScreen() async {
    deviceDataList?.clear();
    tractorList?.clear();
    farmerList?.clear();
    devicePage.value = 1;
    farmerPage.value = 1;
    tractorPage.value = 1;
    if (groupDetailModel.value != null) {
      if (deviceDataList == null || deviceDataList?.isEmpty == true) {
        await hitApiToGetDeviceList();
      }

      if (farmerList == null || farmerList?.isEmpty == true) {
        await hitApiToGetFarmerList();
      }

      if (tractorList == null || tractorList?.isEmpty == true) {
        await hitApiToGetTractorList();
      }

      nameController.text = groupDetailModel.value?.name ?? "";

      if (deviceDataList != null && deviceDataList?.isNotEmpty == true) {
        if (groupDetailModel.value?.deviceIds != null) {
          int listLength = groupDetailModel.value?.deviceIds?.length ?? 0;
          for (int i = 0; i < listLength; i++) {
            var index = deviceDataList?.indexWhere((element) =>
                element.id?.toString() ==
                groupDetailModel.value?.deviceIds![i].toString());
            if (index != -1) {
              deviceDataList![index!].isSelected = true;
              deviceDataList?.refresh();
            }
          }
        }
      }

      selectDevices.value = deviceDataList?.value
              .where((element) => element?.isSelected == true)
              .toList()
              .map((e) => e.deviceName)
              .toList()
              .join(",") ??
          "";
      if (selectDevices.value.isEmpty == true) {
        selectDevices.value = AppStrings.selectGroupDevices;
      }
      selectDevices.refresh();

      if (farmerList != null && farmerList?.isNotEmpty == true) {
        if (groupDetailModel.value?.farmerIds != null) {
          int listLength = groupDetailModel.value?.farmerIds?.length ?? 0;
          for (int i = 0; i < listLength; i++) {
            var index = farmerList?.indexWhere((element) =>
                element.id?.toString() ==
                groupDetailModel.value?.farmerIds![i].toString());
            if (index != -1) {
              farmerList![index!].isSelected = true;
              farmerList?.refresh();
            }
          }
        }
      }

      selectFarmers.value = farmerList?.value
              .where((element) => element?.isSelected == true)
              .toList()
              .map((e) => e.email)
              .toList()
              .join(",") ??
          "";

      if (selectFarmers.value.isEmpty == true) {
        selectFarmers.value = AppStrings.selectFramer;
      }
      selectFarmers.refresh();

      if (tractorList != null && tractorList?.isNotEmpty == true) {
        if (groupDetailModel.value?.tractorIds != null) {
          int listLength = groupDetailModel.value?.tractorIds?.length ?? 0;
          for (int i = 0; i < listLength; i++) {
            var index = tractorList?.indexWhere((element) =>
                element.id?.toString() ==
                groupDetailModel.value?.tractorIds![i].toString());
            if (index != -1) {
              tractorList![index!].isSelected = true;
              tractorList?.refresh();
            }
          }
        }
      }

      selectTractor.value = tractorList?.value
              .where((element) => element?.isSelected == true)
              .toList()
              .map((e) => e.noPlate)
              .toList()
              .join(",") ??
          "";

      if (selectTractor.value.isEmpty == true) {
        selectTractor.value = AppStrings.selectGroupTractors;
      }
      selectTractor.refresh();

      selectState.value = getStateTitle(groupDetailModel.value?.stateId);
      update();
    } else {
      deviceDataList?.clear();
      tractorList?.clear();
      farmerList?.clear();
      devicePage.value = 1;
      farmerPage.value = 1;
      tractorPage.value = 1;

      hitApiToGetTractorList();
      hitApiToGetDeviceList();
      hitApiToGetFarmerList();
    }

    update();
  }

  //groupDetailUrl

  Future hitApiToGetGroupDetails(id) async {
    showLoading("Loading");
    await iHomeRepository?.groupDetailApi(map: {'id': id}).then((value) {
      hideLoading();
      if (value != null) {
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  stateListInit() {
    stateList?.clear();
    stateList?.add(StateModel(stateId: 1, title: AppStrings.active));
    stateList?.add(StateModel(stateId: 0, title: AppStrings.inactive));
    stateList?.add(StateModel(stateId: 2, title: AppStrings.delete));
    stateList?.refresh();
    Get.forceAppUpdate();

  }

  Future hitApiToCreateSlotList() async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.enterGroupName);
      return;
    } else if (farmerList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectFramer);
      return;
    } else if (tractorList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectGroupTractors);
      return;
    } else if (deviceDataList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectGroupDevices);
      return;
    } else if (selectState.value == AppStrings.selectState) {
      showToast(message: AppStrings.pleaseSelectState);
      return;
    }

    Map<String, dynamic> map = {};
    map['name'] = nameController.text.trim();
    map['tractor_ids'] = tractorList
        ?.where((element) => element.isSelected == true)
        .toList()
        .map((element) => element.id?.toString() as String)
        .toList()
        .cast();
    map['device_ids'] = deviceDataList
        ?.where((element) => element.isSelected == true)
        .toList()
        .map((element) => element.id?.toString())
        .toList();
    map['farmer_ids'] = farmerList
        ?.where((element) => element?.isSelected == true)
        .toList()
        .map((element) => element.id?.toString())
        .toList();
    map['state_id'] = stateModel?.value?.stateId;
    print("check all ${(jsonEncode(map))}");
    showLoading("Loading");
    await iHomeRepository?.createNewGroup(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        Get.back();
        Get.find<ListController>().groupList?.insert(0, value.data!);
        Get.find<ListController>().groupList?.refresh();
        showToast(message: value.message ?? "");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetDeviceList() async {
    //  showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = devicePage.value;
    map['group_id'] = groupDetailModel.value?.id;

    await iHomeRepository?.getAllDeviceList(map: map).then((value) {
      //  hideLoading();
      if (value != null && value.data != null) {
        deviceDetailDataModel = value.data;
        if (deviceDetailDataModel != null) {
          deviceDataList?.addAll(deviceDetailDataModel?.tractors ?? []);
        }
        deviceDataList?.refresh();
      }
    }).onError((error, stackTrace) {
      // hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationForDeviceList() {
    deviceController.addListener(() {
      if (deviceController.position.pixels ==
          deviceController.position.maxScrollExtent) {
        if (deviceDetailDataModel != null &&
            int.parse(deviceDetailDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    deviceDetailDataModel?.totalPages?.toString() ?? "1")) {
          devicePage.value = devicePage.value + 1;
          devicePage.refresh();
          hitApiToGetDeviceList();
        }
      }
    });
  }

  Future hitApiToGetTractorList() async {
    //  showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractorPage.value;
    map['group_id'] = groupDetailModel.value?.id;

    await iTractorRepository?.getAllTractorList(map: map).then((value) {
      //   hideLoading();
      if (value != null && value.data != null) {
        tractorDetailDataModel = value.data;
        tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
        tractorList?.refresh();
      }
    }).onError((error, stackTrace) {
      //   hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnTractorList() {
    tractorController.addListener(() {
      if (tractorController.position.pixels ==
          tractorController.position.maxScrollExtent) {
        if (tractorDetailDataModel != null &&
            int.parse(tractorDetailDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    tractorDetailDataModel?.totalPages?.toString() ?? "1")) {
          tractorPage.value = tractorPage.value + 1;
          tractorPage.refresh();
          hitApiToGetTractorList();
        }
      }
    });
  }

  Future hitApiToGetFarmerList() async {
    // showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = farmerPage.value;
    map['group_id'] = groupDetailModel.value?.id;

    await iHomeRepository?.farmerListApi(map: map).then((value) {
      //  hideLoading();
      if (value != null && value.data != null) {
        farmerDataModel = value.data;
        farmerList?.addAll(farmerDataModel?.farmers ?? []);
        farmerList?.refresh();
      }
    }).onError((error, stackTrace) {
      //  hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnFarmerList() {
    farmerController.addListener(() {
      if (farmerController.position.pixels ==
          farmerController.position.maxScrollExtent) {
        if (farmerDataModel != null &&
            int.parse(farmerDataModel?.pageNo?.toString() ?? "1") <
                int.parse(farmerDataModel?.totalPages?.toString() ?? "1")) {
          farmerPage.value = farmerPage.value + 1;
          farmerPage.refresh();
          hitApiToGetFarmerList();
        }
      }
    });
  }

  Future hitApiToUpdateSlotList() async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.enterGroupName);
      return;
    } else if (farmerList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectFramer);
      return;
    } else if (tractorList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectGroupTractors);
      return;
    } else if (deviceDataList?.value.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectGroupDevices);
      return;
    } else if (selectState.value == AppStrings.selectState) {
      showToast(message: AppStrings.pleaseSelectState);
      return;
    }

    Map<String, dynamic> map = {};
    map['name'] = nameController.text.trim();
    map['group_id'] = groupDetailModel.value?.id;
    map['name'] = nameController.text.trim();
    map['tractor_ids'] = tractorList
        ?.where((element) => element.isSelected == true)
        .toList()
        .map((element) => element.id?.toString() as String)
        .toList()
        .cast();
    map['device_ids'] = deviceDataList
        ?.where((element) => element.isSelected == true)
        .toList()
        .map((element) => element.id?.toString())
        .toList();
    map['farmer_ids'] = farmerList
        ?.where((element) => element?.isSelected == true)
        .toList()
        .map((element) => element.id?.toString())
        .toList();
    map['state_id'] = stateModel?.value?.stateId;
    print("check all ${(jsonEncode(map))}");
    showLoading("Loading");
    await iHomeRepository?.updateGroup(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        Get.back();
        Get.find<ListController>().pageNumber.value = 1;
        Get.find<ListController>().groupList![
            Get.find<ListController>().selectedGroupIndex.value] = value.data!;
        showToast(message: value.message ?? "");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }
}
