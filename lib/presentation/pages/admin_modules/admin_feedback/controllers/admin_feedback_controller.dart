import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../../data/models/feedback_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../../../../data/repositories/feedback_provider/impl/remote_feedback_provider.dart';
import '../../../../../data/repositories/feedback_provider/interface/feedback_repository.dart';

class AdminFeedbackController extends GetxController with BaseController {
  var selectedIssueId = "".obs;
  RxString selectState = AppStrings.active.obs;
  RxInt page = 1.obs;
  RxString progress = '0'.obs;
  var _localPath;
  ITractorRepository? iTractorRepository;
  var scrollController = ScrollController();

  RxList<StateModel>? stateList = <StateModel>[].obs;

  var detailFeedbackModel = Rxn<FeedbackDetailModel>();

  var conclusionController = TextEditingController();
  var technicalController = TextEditingController();

  RxBool isUpdating = false.obs;
  var updatingId = "".obs;
  Timer? timer;
  ProgressDialog? progressDialog;
  FeedbackDataModel? feedbackDataModel;
  RxList<FeedbackDetailModel>? feedbackList = <FeedbackDetailModel>[].obs;

  IFeedbackRepository? iFeedbackRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iFeedbackRepository = Get.put(RemoteIFeedbackProvider());
      iTractorRepository = Get.put(RemoteITractorProvider());
      feedbackList?.clear();
      hitApiToGetFeedbackList();
      addPaginationForDeviceList();
    });
    stateListInit();
    super.onInit();
  }

  stateListInit() {
    stateList?.clear();
    stateList?.add(StateModel(stateId: 1, title: AppStrings.active));
    stateList?.add(StateModel(stateId: 0, title: AppStrings.completed));
    stateList?.add(StateModel(stateId: 2, title: AppStrings.closed));
    stateList?.refresh();
  }

  Future hitApiToGetFeedbackList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = page.value;

    await iFeedbackRepository?.getAllFeedBackList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        feedbackDataModel = value.data;
        if (feedbackDataModel != null) {
          feedbackList?.addAll(feedbackDataModel?.feedback ?? []);
        }

        feedbackList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationForDeviceList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (feedbackDataModel != null &&
            int.parse(feedbackDataModel?.pageNo?.toString() ?? "1") <
                int.parse(feedbackDataModel?.totalPages?.toString() ?? "1")) {
          page.value = page.value + 1;
          page.refresh();
          hitApiToGetFeedbackList();
        }
      }
    });
  }

  hitApiToAddConclusion({id}) async {
    if (technicalController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterTechnical);
      return;
    }
    if (conclusionController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterConclusion);
      return;
    }

    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['conclusion'] = conclusionController.text.trim();
    map['tech_details'] = technicalController.text.trim();
    map['id'] = id;
    map['state_id'] = getIdBasedOnTitle(selectState.value);

    await iFeedbackRepository?.addFarmerConclusion(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value.message ?? "");

        Get.back();
        page.value = 1;
        feedbackList?.clear();
        hitApiToGetFeedbackList();
        hitApiToGetFeedbackDetails(id: id);
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToGetFeedbackDetails({id}) async {
    showLoading("Loading");

    Map<String, dynamic> map = {};

    map['id'] = id;

    await iFeedbackRepository?.feedbackDetails(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        detailFeedbackModel.value = value.data;
        detailFeedbackModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToExportFeedbackReports() async {
    progressDialog = ProgressDialog(context: Get.overlayContext!);
    progressDialog?.show(msg: "File Exporting..");
    Map<String, dynamic> map = {};
    map['type_id']=APIEndpoint.exportFeedback;
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
      _localPath +
          "/" +
          "tractor-reports_${DateFormat("yyyy-MM-dd").format(DateTime.now())}.csv",
      onReceiveProgress: (rcv, total) {
        progress.value = ((rcv / total) * 100).toStringAsFixed(0);
        progress.refresh();
        if (progress.value == '100') {
           progressDialog?.close();
           showToast(message: AppStrings.fileDownloaded);

        } else if (double.parse(progress.value) < 100) {

        }
      },
      deleteOnError: true,
    ).then((_) {
      progressDialog?.close();
    });
  }


  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
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
