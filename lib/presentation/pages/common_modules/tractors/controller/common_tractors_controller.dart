import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../app/util/media_select_dialog.dart';

class CommonTractorController extends GetxController with BaseController {
  RxString selectState = AppStrings.active.obs;
  ProgressDialog? progressDialog;
  var numberPlateTextFieldController = TextEditingController();
  var idNumberTextFieldController = TextEditingController();
  var engineNumberTextFieldController = TextEditingController();
  var fuelTextFieldController = TextEditingController();
  var maintenanceTextFieldController = TextEditingController();
  var tractorBrandTextFieldController = TextEditingController();
  var tractorModelTextFieldController = TextEditingController();
  var manufactureDateTextFieldController = TextEditingController();
  var installationTimeTextFieldController = TextEditingController();
  var installationAddressTextFieldController = TextEditingController();

  RxList<File> imageList = <File>[].obs;

  RxString progress = '0'.obs;

  var _localPath;
  RxInt tractorId = 0.obs;
  RxInt currentIndex = 0.obs;

  RxBool isUpdating = false.obs;

  ScrollController tractorController = ScrollController();
  RxInt tractorPage = 1.obs;
  TractorDetailDataModel? tractorDetailDataModel;

  RxList<TractorModel>? tractorList = <TractorModel>[].obs;

  ITractorRepository? iTractorRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    iTractorRepository = Get.put(RemoteITractorProvider());
    super.onInit();
  }





  Future hitApiToGetDeviceDetails(id) async {
    showLoading("Loading");
    await iTractorRepository?.getTractorDetails(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        imageList.clear();
        numberPlateTextFieldController.text =
            value.data?.noPlate.toString() ?? "";
        idNumberTextFieldController.text = value.data?.idNo.toString() ?? "";
        engineNumberTextFieldController.text =
            value.data?.engineNo.toString() ?? "";
        fuelTextFieldController.text =
            value.data?.fuelConsumption.toString() ?? "";
        maintenanceTextFieldController.text =
            value.data?.maintenanceKilometer.toString() ?? "";
        tractorBrandTextFieldController.text =
            value.data?.brand.toString() ?? "";
        tractorModelTextFieldController.text =
            value.data?.model.toString() ?? "";
        manufactureDateTextFieldController.text =
            value.data?.manufactureDate.toString() ?? "";
        installationTimeTextFieldController.text =
            value.data?.installationTime.toString() ?? "";
        installationAddressTextFieldController.text =
            value.data?.installationAddress.toString() ?? "";
        selectState.value = getStateTitle(value.data?.stateId?.toInt());
        if (value.data?.images != null &&
            value.data?.images?.isNotEmpty == true) {
          value.data?.images?.forEach((element) {
            if (element.path != null && element.path.toString().isNotEmpty) {
              imageList.add(File("${APIEndpoint.imageUrl}${element.path}"));
            }
          });
          imageList.refresh();
        }
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  // Future<void> downloadFile(var saveUrl) async {
  //
  //     isDownloading.value = true;
  //     fileProgress.value = "Downloading...";
  //
  //
  //   try {
  //     String url = saveUrl;
  //     String fileName = "data_import_format.csv";
  //
  //     // Get the directory to save the file
  //     Directory? directory = await getApplicationDocumentsDirectory();
  //     String savePath = "${directory.path}/$fileName";
  //
  //     Dio dio = Dio();
  //     await dio.download(
  //       url,
  //       savePath,
  //       onReceiveProgress: (received, total) {
  //         print(total);
  //         fileProgress.value = "0.6";
  //         //fileProgress.value = (received / total * 100).toStringAsFixed(0) + "%";
  //       },
  //     );
  //     isDownloading.value = false;
  //     fileProgress.value = "Download Complete: $savePath";
  //     print("File saved to: $savePath");
  //   } catch (e) {
  //       isDownloading.value = false;
  //       fileProgress.value = "Download Failed: $e";
  //       print("Download error: $e");
  //   }
  // }




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

  Future hitApiToGetTractorList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractorPage.value;
    map['allData'] = 1;

    await iTractorRepository?.getAllTractorList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        tractorDetailDataModel = value.data;
        tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
        tractorList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
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

  Future hitApiToAddNewTractors() async {
    if (numberPlateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseNumberPlate);
      return;
    } else if (idNumberTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseIdNumber);
      return;
    } else if (engineNumberTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEngineNumber);
      return;
    } else if (fuelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseFuelPerKm);
      return;
    } else if (maintenanceTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseMaintenanceKilometer);
      return;
    } else if (tractorBrandTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseTractorBrand);
      return;
    } else if (tractorModelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseTractorModel);
      return;
    } else if (manufactureDateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseManuFactureDate);
      return;
    } else if (installationTimeTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseInstallationTime);
      return;
    } else if (installationAddressTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseInstallationAddress);
      return;
    } else if (imageList.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectOneImage);
      return;
    }

    Map<String, dynamic> map = {};
    map['no_plate'] = numberPlateTextFieldController.text.trim();
    map['id_no'] = idNumberTextFieldController.text.trim();
    map['engine_no'] = engineNumberTextFieldController.text.trim();
    map['fuel_consumption'] = fuelTextFieldController.text.trim();
    map['maintenance_kilometer'] = maintenanceTextFieldController.text.trim();
    map['brand'] = tractorBrandTextFieldController.text.trim();
    map['model'] = tractorModelTextFieldController.text.trim();
    map['manufacture_date'] = manufactureDateTextFieldController.text.trim();
    map['installation_time'] = installationTimeTextFieldController.text.trim();
    map['installation_address'] =
        installationAddressTextFieldController.text.trim();
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    showLoading("Loading");
    await iTractorRepository
        ?.addNewTractor(map: map, listImage: imageList.value)
        .then((value) {
      hideLoading();
      if (value != null) showToast(message: value?.message ?? "");
      Get.back();
      resetAllController();
      tractorList?.insert(0, value.data!);
      tractorList?.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToUpdateTractors(id, currentIndex) async {
    print("chekc current indesx ${currentIndex}");
    if (numberPlateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseNumberPlate);
      return;
    } else if (idNumberTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseIdNumber);
      return;
    } else if (engineNumberTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEngineNumber);
      return;
    } else if (fuelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseFuelPerKm);
      return;
    } else if (maintenanceTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseMaintenanceKilometer);
      return;
    } else if (tractorBrandTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseTractorBrand);
      return;
    } else if (tractorModelTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseTractorModel);
      return;
    } else if (manufactureDateTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseManuFactureDate);
      return;
    } else if (installationTimeTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseInstallationTime);
      return;
    } else if (installationAddressTextFieldController.text.isEmpty) {
      showToast(message: AppStrings.pleaseInstallationAddress);
      return;
    } else if (imageList.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectOneImage);
      return;
    }

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['no_plate'] = numberPlateTextFieldController.text.trim();
    map['id_no'] = idNumberTextFieldController.text.trim();
    map['engine_no'] = engineNumberTextFieldController.text.trim();
    map['fuel_consumption'] = fuelTextFieldController.text.trim();
    map['maintenance_kilometer'] = maintenanceTextFieldController.text.trim();
    map['brand'] = tractorBrandTextFieldController.text.trim();
    map['model'] = tractorModelTextFieldController.text.trim();
    map['manufacture_date'] = manufactureDateTextFieldController.text.trim();
    map['installation_time'] = installationTimeTextFieldController.text.trim();
    map['installation_address'] =
        installationAddressTextFieldController.text.trim();
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    showLoading("Loading");
    await iTractorRepository
        ?.updateTractor(map: map, listImage: imageList.value)
        .then((value) {
      hideLoading();
      if (value != null && value.data != null)
        showToast(message: value?.message ?? "");
      Get.back();
      resetAllController();
      tractorList![currentIndex] = value.data!;
      tractorList?.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToDeleteTractors(id, index) async {
    showLoading("Loading");
    await iTractorRepository?.deleteTractors(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null) showToast(message: value?.message ?? "");
      tractorList!.removeAt(index);
      tractorList!.refresh();
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  resetAllController() {
    numberPlateTextFieldController.clear();
    idNumberTextFieldController.clear();
    fuelTextFieldController.clear();
    maintenanceTextFieldController.clear();
    tractorBrandTextFieldController.clear();
    tractorModelTextFieldController.clear();
    engineNumberTextFieldController.clear();
    manufactureDateTextFieldController.clear();
    installationTimeTextFieldController.clear();
    installationAddressTextFieldController.clear();
    imageList.clear();
    selectState.value = AppStrings.active;
    update();
  }

  showImageDialog() {
    Get.dialog(MediaSelectDialog(
      selectedImage: (fileImage) {
        var bytes = fileImage.readAsBytesSync().length;
        if (bytes > 5000000) {
          showToast(message: AppStrings.imageSizeLength);
          return;
        }

        imageList.add(fileImage);
        imageList.refresh();
      },
    ));
  }

  hitApiToExportFeedbackReports() async {
    if(tractorList?.isEmpty==true){
     return;
    }
    var data=tractorList?.where((element) => element?.isSelected==true).map((e) => e.id).toList();
    print("check data ${data?.isEmpty} ${data?.join(",")}");

    progressDialog = ProgressDialog(context: Get.overlayContext!);
    progressDialog?.show(msg: "File Exporting..");
    Map<String, dynamic> map = {};
    map['type_id']=APIEndpoint.exportTractors;
    if(data?.isNotEmpty==true){
      map["tractor_ids"]=data?.join(",");
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
    await iTractorRepository
        ?.exportReportsFileExists(map: map)
        .then((value) {
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



  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print('check the lcoal path ${_localPath}');
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
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
