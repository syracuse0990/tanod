import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../../app/util/export_file.dart';

class CommonDeviceController extends GetxController with BaseController {
  RxString selectState = AppStrings.active.obs;

  var imeiTextFieldController = TextEditingController();
  var deviceSimTextFieldController = TextEditingController();
  var deviceNameTextFieldController = TextEditingController();
  var deviceModelTextFieldController = TextEditingController();
  var subscriptionExpirationTextFieldController = TextEditingController();
  var expirationDateTextFieldController = TextEditingController();
  var stateTextFieldController = TextEditingController();
  RxString progress = '0'.obs;
  DeviceDetailDataModel? deviceDetailDataModel;
  RxList<DevicesModel>? deviceList = <DevicesModel>[].obs;
  RxInt devicePage = 1.obs;
  ITractorRepository? iTractorRepository;
  ProgressDialog? progressDialog;
  RxInt currentIndex = 0.obs;

  var _localPath;
  RxInt deviceId = 0.obs;
  RxBool isUpdating = false.obs;
  ScrollController deviceController = ScrollController();
  IDeviceRepository? iDeviceRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    iDeviceRepository = Get.put(RemoteIDeviceProvider());
    iTractorRepository = Get.put(RemoteITractorProvider());

    super.onInit();
  }

  Future hitApiToGetDeviceDetails(id) async {
    showLoading("Loading");
    await iDeviceRepository?.getDeviceDetails(map: {"id": id}).then((value) {
      hideLoading();

      if (value != null && value.devicesModel != null) {
        imeiTextFieldController.text =
            value.devicesModel?.imeiNo?.toString() ?? "";

        deviceSimTextFieldController.text =
            value.devicesModel?.sim?.toString() ?? "";
        deviceModelTextFieldController.text =
            value.devicesModel?.deviceModal?.toString() ?? "";
        deviceNameTextFieldController.text =
            value.devicesModel?.deviceName?.toString() ?? "";
        subscriptionExpirationTextFieldController.text =
            value.devicesModel?.subscriptionExpiration?.toString() ?? "";
        expirationDateTextFieldController.text = DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(
                value.devicesModel?.expirationDate?.toString() ?? ""));
        selectState.value = getStateTitle(value.devicesModel?.stateId?.toInt());
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetDeviceList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['allData'] = 1;
    map['page_no'] = devicePage.value;

    await iDeviceRepository?.getAllDeviceList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        deviceDetailDataModel = value.data;
        if (deviceDetailDataModel != null) {
          deviceList?.addAll(deviceDetailDataModel?.tractors ?? []);
        }

        print("check data ${deviceList?.length}");
        deviceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
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

  Future hitApiToAddNewDevice() async {
    if (imeiTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterImei);
      return;
    } else if (deviceSimTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.simName);
      return;
    } else if (deviceModelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterDeviceModel);
      return;
    } else if (deviceNameTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterDeviceName);
      return;
    } else if (subscriptionExpirationTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseSubscriptionExpiration);
      return;
    } else if (expirationDateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseExpirationDate);
      return;
    }

    Map<String, dynamic> map = {};

    map['imei_no'] = imeiTextFieldController.text.trim();
    map['sim'] = deviceSimTextFieldController.text.trim();
    map['device_modal'] = deviceModelTextFieldController.text.trim();
    map['device_name'] = deviceNameTextFieldController.text.trim();
    map['subscription_expiration'] =
        subscriptionExpirationTextFieldController.text.trim();
    map['expiration_date'] = expirationDateTextFieldController.text.trim();
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    showLoading("Loading");
    await iDeviceRepository?.addNewDevices(map: map).then((value) {
      hideLoading();
      if (value != null && value.devicesModel != null)
        showToast(message: value?.message ?? "");
      Get.back();
      resetAllController();
      deviceList?.insert(0, value.devicesModel!);
      deviceList?.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToUpdateDevice(id, index) async {
    if (imeiTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterImei);
      return;
    } else if (deviceSimTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.simName);
      return;
    } else if (deviceModelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterDeviceModel);
      return;
    } else if (deviceNameTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.enterDeviceName);
      return;
    } else if (subscriptionExpirationTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseSubscriptionExpiration);
      return;
    } else if (expirationDateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseExpirationDate);
      return;
    }

    Map<String, dynamic> map = {};

    map['id'] = id;
    map['sim'] = deviceSimTextFieldController.text.trim();
    map['imei_no'] = imeiTextFieldController.text.trim();
    map['device_modal'] = deviceModelTextFieldController.text.trim();
    map['device_name'] = deviceNameTextFieldController.text.trim();
    map['subscription_expiration'] =
        subscriptionExpirationTextFieldController.text.trim();
    map['expiration_date'] = expirationDateTextFieldController.text.trim();
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    showLoading("Loading");
    await iDeviceRepository?.updateDevices(map: map).then((value) {
      hideLoading();
      if (value != null && value.devicesModel != null)
        showToast(message: value?.message ?? "");
      Get.back();
      resetAllController();
      deviceList![index] = value.devicesModel!;
      deviceList?.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToDeleteDevice(id, index) async {
    showLoading("Loading");
    await iDeviceRepository?.deleteDevice(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null) showToast(message: value?.message ?? "");
      deviceList!.removeAt(index);
      deviceList!.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  resetAllController() {
    imeiTextFieldController.clear();
    deviceSimTextFieldController.clear();
    deviceModelTextFieldController.clear();
    deviceNameTextFieldController.clear();
    subscriptionExpirationTextFieldController.clear();
    expirationDateTextFieldController.clear();
  }

  hitApiToExportDeviceReports() async {
    if (deviceList?.isEmpty == true) {
      return;
    }
    var data = deviceList
        ?.where((element) => element?.isSelected == true)
        .map((e) => e.id)
        .toList();
    print("check data ${data?.isEmpty} ${data?.join(",")}");

    progressDialog  =  ProgressDialog(context: Get.overlayContext!);
    progressDialog?.show(msg: "File Exporting..");
    Map<String, dynamic> map = {};
    map['type_id'] = APIEndpoint.exportDevice;
    if (data?.isNotEmpty == true) {
      map["device_ids"] = data?.join(",");
    }
    await iTractorRepository?.exportReports(map: map).then((value) {
      if (value != null && value.data != null) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          hitApiToCheckExportExist(fileName: value.data?.fileName);
        });
      }
    }).onError((error, stackTrace) {
      showToast(message: error?.toString());
    });
  }

  hitApiToCheckExportExist({fileName}) async {
    Map<String, dynamic> map = {};
    map['filename'] = fileName;
    await iTractorRepository?.exportReportsFileExists(map: map).then((value) {
      if (value != null) {
        if (value.isDownload == true) {
          timer?.cancel();
          progressDialog?.close();
          downloadFarmerFeedbackReportFile(url: value?.downloadUrl);
        }
      }
    }).onError((error, stackTrace) {
      showToast(message: error?.toString());
    });
  }

  downloadFarmerFeedbackReportFile({url}) async {
    await _prepareSaveDir();
    progressDialog?.show(msg: "File Downloading..", max: 100);
    Dio dio = Dio(BaseOptions(headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      "Authorization":
          box.read(tokenKeys) != null ? "Bearer ${box.read(tokenKeys)}" : null
    }));
    dio.download(
      url,
      _localPath + "/" +"devices_${DateFormat("yyyy-MM-dd").format(DateTime.now())}.csv",
      onReceiveProgress: (rcv, total) {
        progress.value = ((rcv / total) * 100).toStringAsFixed(0);
        progress.refresh();
        if (progress.value == '100') {
          progressDialog?.close();
          showToast(message: AppStrings.fileDownloaded);
        } else if (double.parse(progress.value) < 100) {}
      },
      deleteOnError: true,
    ).then((value) {
      print("---------_${value}");
      progressDialog?.close();
    });
  }
  Future<void> _prepareSaveDir() async {
   try{
      _localPath = (await _findLocalPath())!;
     final savedDir = Directory(_localPath);
     bool hasExisted = await savedDir.exists();
     if (!hasExisted) {
       savedDir.create();
     }
   }catch(e){
     progressDialog?.close();
   }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return "/sdcard/download/Tanod";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

}
