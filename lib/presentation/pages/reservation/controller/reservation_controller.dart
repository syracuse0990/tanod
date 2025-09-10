import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tanod_tractor/presentation/pages/base/base_controller.dart';

import '../../../../app/config/app_constants.dart';
import '../../../../data/models/device_model.dart';
import '../../../../data/models/farmer_model.dart';
import '../../../../data/models/tractor_group_model.dart';
import '../../../../data/models/tratcor_model.dart';
import '../../../../data/repositories/home_provider/impl/remote_home_provider.dart';
import '../../../../data/repositories/home_provider/interface/ihome_repository.dart';

class ReservationController extends GetxController with BaseController {
  RxString selectTractor = "Select Tractor".obs;
  RxString selectDevice = "Select Device".obs;
  IHomeRepository? iHomeRepository;
  var purposeDetailController = TextEditingController();

  DeviceDetailDataModel? deviceDetailDataModel;
  RxList<DevicesModel>? updatedDeviceList = <DevicesModel>[].obs;

  FarmerDataModel? farmerDataModel;
  RxInt farmerPage = 1.obs;
  ScrollController farmerController = ScrollController();
  RxList<FarmerModel>? farmerList = <FarmerModel>[].obs;

  var deviceModel = Rxn<DevicesModel>();
  var tractorModel = Rxn<TractorModel>();
  var farmerModel = Rxn<FarmerModel>();
  var dateTime = Rxn<DateTime>();

  RxInt tractorPage = 1.obs;
  ScrollController tractorController = ScrollController();

  RxInt devicePage = 1.obs;
  ScrollController deviceController = ScrollController();
  RxList<DevicesModel>? deviceList = <DevicesModel>[].obs;

  RxBool fromMaintenance = false.obs;

  TractorDetailDataModel? tractorDetailDataModel;
  RxList<TractorModel>? tractorList = <TractorModel>[].obs;

  @override
  void onInit() {
    iHomeRepository = Get.put(RemoteIHomeProvider());

    super.onInit();
  }

  Future hitApiToGetTractorList() async {
    // showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractorPage.value;

    await iHomeRepository?.getAllTractorList(map: map).then((value) {
      // hideLoading();
      if (value != null && value.data != null) {
        tractorDetailDataModel = value.data;

        if (tractorModel != null) {
          tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
          int? index = tractorList
              ?.indexWhere((element) => element.id == tractorModel.value?.id);
          if (index != -1) {
            tractorList![index!].isSelected = true;
          }
        } else {
          tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
        }

        tractorList?.refresh();
      }
    }).onError((error, stackTrace) {
      // hideLoading();
      showToast(error?.toString());
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

  Future hitApiToGetDeviceList({maps}) async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = devicePage.value;
     if(maps!=null&&maps?.isNotEmpty==true){
       map.addAll(maps);
     }


    await iHomeRepository?.getAllDeviceList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        deviceDetailDataModel = value.data;
        if (deviceDetailDataModel != null) {
          deviceList?.addAll(deviceDetailDataModel?.tractors ?? []);
          int? index = deviceList
              ?.indexWhere((element) => element.id == deviceModel.value?.id);
          if (index != -1) {
            deviceList![index!].isSelected = true;
          }
        } else {
          deviceList?.addAll(deviceDetailDataModel?.tractors ?? []);
        }

        deviceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(error?.toString());
    });
  }

  addPaginationForDeviceList({maps}) {
    deviceController.addListener(() {
      if (deviceController.position.pixels ==
          deviceController.position.maxScrollExtent) {
        if (deviceDetailDataModel != null &&
            int.parse(deviceDetailDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    deviceDetailDataModel?.totalPages?.toString() ?? "1")) {
          devicePage.value = devicePage.value + 1;
          devicePage.refresh();
          hitApiToGetDeviceList(maps: maps);
        }
      }
    });
  }

  hitApiToAddSlots() async {
    if (purposeDetailController.text.isEmpty) {
      showToast(AppStrings.purposeIsEmpty);
      return;
    } else if (tractorModel.value == null) {
      showToast(AppStrings.selectTractor);
      return;
    } else if (deviceModel.value == null) {
      showToast(AppStrings.selectDevice);
      return;
    }
    showLoading();
    Map<String, dynamic> map = {};
    map['purpose'] = purposeDetailController.text;
    map['tractor_id'] = tractorModel.value?.id;
    map['device_id'] = deviceModel.value?.id;
    map['date'] =
        DateFormat("yyyy-MM-dd").format(dateTime.value ?? DateTime.now());

    await iHomeRepository?.createNewBooking(map: map).then((value) {
      hideLoading();
      if (value != null) {
        Get.back();
        showToast(value.message ?? "");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(error?.toString());
    });
  }

  Future hitApiToGetFarmerList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = farmerPage.value;

    await iHomeRepository?.farmerListApi(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        farmerDataModel = value.data;

        if (farmerDataModel != null) {
          farmerList?.addAll(farmerDataModel?.farmers ?? []);
          int? index = farmerList
              ?.indexWhere((element) => element.id == farmerModel?.value?.id);
          if (index != -1) {
            farmerList![index!].isSelected = true;
          }
        } else {
          farmerList?.addAll(farmerDataModel?.farmers ?? []);
        }

        farmerList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(error?.toString());
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
}
