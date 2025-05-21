import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/repositories/profile_provider/impl/remote_profile_provider.dart';
import 'package:tanod_tractor/data/repositories/profile_provider/interface/iprofile_repository.dart';

import '../../../../app/util/media_select_dialog.dart';
import '../../../../data/models/feedback_model.dart';
import '../../../../data/repositories/feedback_provider/impl/remote_feedback_provider.dart';
import '../../../../data/repositories/feedback_provider/interface/feedback_repository.dart';

class FeedbackController extends GetxController with BaseController {
  var selectedIssueId = "".obs;

  RxInt page = 1.obs;
  RxInt selectedIndex = 0.obs;

  var scrollController = ScrollController();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var descriptionController = TextEditingController();
  var issueTypeController = TextEditingController().obs;

  RxBool isUpdating = false.obs;
  var updatingId = "".obs;
  RxList<File> imageList = <File>[].obs;

  FeedbackDataModel? feedbackDataModel;
  RxList<FeedbackDetailModel>? feedbackList = <FeedbackDetailModel>[].obs;
  IProfileRepository? iProfileRepository;

  IFeedbackRepository? iFeedbackRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iFeedbackRepository = Get.put(RemoteIFeedbackProvider());
      iProfileRepository = Get.put(RemoteIProfileProvider());
      feedbackList?.clear();
      hitApiToGetFeedbackList();
      addPaginationForDeviceList();
    });
    super.onInit();
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

  showDataOnFields(FeedbackDetailModel? feedbackDetailModel) {
    if (feedbackDetailModel != null) {
      nameController.text = feedbackDetailModel.name ?? "";
      emailController.text = feedbackDetailModel.email ?? "";
      descriptionController.text = feedbackDetailModel.description ?? "";

      selectedIssueId.value =
          feedbackDetailModel.issueType?.id?.toString() ?? "";
      issueTypeController.value.text =
          feedbackDetailModel.issueType?.title ?? "";
      if (feedbackDetailModel.images != null &&
          feedbackDetailModel.images?.isNotEmpty == true) {
        feedbackDetailModel?.images?.forEach((element) {
          if (element.path != null && element.path.toString().isNotEmpty) {
            imageList.add(File("${APIEndpoint.imageUrl}${element.path}"));
          }
        });
        imageList.refresh();
      }
      update();
    }
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

  hitApiToCreateFeedback() async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return false;
    } else if (issueTypeController.value.text.isEmpty) {
      showToast(message: AppStrings.selectIssueType);
      return;
    } else if (descriptionController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterDescription);
      return;
    } else if (imageList.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectOneImage);
      return;
    }

    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['name'] = nameController.text.trim();
    map['email'] = emailController.text.trim();
    map['description'] = descriptionController.text.trim();
    map['issue_type_id'] = selectedIssueId.value;

    await iFeedbackRepository?.addNewFeedback(map: map,imageList: imageList).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value.message ?? "");
        feedbackList?.insert(0,  value.data!);
        Get.back();
        clearAllFields();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetUserDetails() async {
    showLoading("Loading");

    await iProfileRepository?.getUserDetails().then((value) {
      hideLoading();
      if (value != null&&value.success!=null) {
        nameController.text=value?.success?.name??"";
        emailController.text=value?.success?.email??"";
        print(":check all detail ${ emailController.text}");
        Get.forceAppUpdate();

      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToUpdateFeedback({id,index}) async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return false;
    } else if (issueTypeController.value.text.isEmpty) {
      showToast(message: AppStrings.selectIssueType);
      return;
    } else if (descriptionController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterDescription);
      return;
    }else if (imageList.isEmpty == true) {
      showToast(message: AppStrings.pleaseSelectOneImage);
      return;
    }

    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = nameController.text.trim();
    map['email'] = emailController.text.trim();
    map['description'] = descriptionController.text.trim();
    map['issue_type_id'] = selectedIssueId.value;

    await iFeedbackRepository?.updateFeedback(map: map,imageList: imageList).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value.message ?? "");
        feedbackList![index]=value.data!;
        feedbackList?.refresh();
        Get.back();
        clearAllFields();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  clearAllFields() {
    nameController.clear();
    emailController.clear();
    descriptionController?.clear();
    issueTypeController?.value?.clear();
    update();
  }
}
