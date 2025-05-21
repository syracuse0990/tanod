import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:tanod_tractor/data/repositories/login_provider/impl/remote_login_provider.dart';
import 'package:dio/dio.dart';
import '../../../../../app/util/export_file.dart';
import '../../../../../app/util/media_select_dialog.dart';
import '../../../../../data/models/admin_user_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/login_provider/interface/ilogin_repository.dart';
import '../../../../../data/repositories/user_management_provider/impl/remote_user_management_provider.dart';
import '../../../../../data/repositories/user_management_provider/interface/user_management_repository.dart';

class UserManagementController extends GetxController  {
  IUserManagementRepository? iUserManagementRepository;
  AdminUserDataModel? adminUserDataModel;
  RxList<UserDataModel>? userList = <UserDataModel>[].obs;
  var profileImage = Rxn<File>();
  var userDataModel = Rxn<UserDataModel>();
  var userController = ScrollController();
  RxInt currentPage = 1.obs;
  ILoginRepository? iLoginRepository;
  RxList<StateModel>? genderList = <StateModel>[].obs;
  var filePath = "".obs;
  ITractorRepository? iTractorRepository;
  var _localPath;
  RxString selectState = AppStrings.active.obs;
  RxString selectGender = AppStrings.selectGender.obs;
  RxString progress = '0'.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  ISubAdminRepository? iSubAdminRepository;
  ProgressDialog? progressDialog;
  TractorGroupDataModel? tractorGroupDataModel;
  RxList<GroupsModel>? groupList = <GroupsModel>[].obs;

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iSubAdminRepository = Get.put(RemoteISubAdminProvider());
      iTractorRepository = Get.put(RemoteITractorProvider());
      genderListInit();
      iUserManagementRepository = Get.put(RemoteIUserManagementProvider());
      iLoginRepository = Get.put(RemoteILoginProvider());
      userList?.clear();
      //hitApiToGetUserList();
      addPaginationOnFarmerList();
      hitApiToGetTractorList();
    });
    super.onInit();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'txt', 'xlsx', 'xls'],
    );
    if (result != null) {
      filePath.value = result.files.single.path ??"";
    }
  }

  Future downloadImportFile() async {
    showLoading("Loading");
    await iTractorRepository?.downloadImportFile().then((value) {
      hideLoading();
      if (value.data != null) {
        Get.back();
        downloadFarmerFeedbackReportFile(url:value.data?.path??"");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future uploadImportFile() async {
    showLoading("Loading");

    FormData formData = FormData.fromMap(
      {
        'fileInput': await MultipartFile.fromFile(
            filePath.value  ?? "",
            filename: filePath.value.split('/').last),
      },
    );

    await iTractorRepository?.uploadImportFile(formData:formData).then((value) {
      hideLoading();
      if (value.status == true) {
        filePath.value ="";
        Get.back();
        showToast(message: "File Select Successfully");

      }else{
        hideLoading();
        showToast(message: value.message);
      }
    }).onError((error, stackTrace) {
      hideLoading();
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
      _localPath + "/" +"farmers_${DateFormat("yyyy-MM-dd").format(DateTime.now())}.csv",
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

  genderListInit() {
    genderList?.clear();
    genderList
        ?.add(StateModel(stateId: APIEndpoint.male, title: AppStrings.male));
    genderList?.add(
        StateModel(stateId: APIEndpoint.female, title: AppStrings.female));

    genderList?.refresh();
  }

  //updateUserProfile
  showImageDialog({userId}) {
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
          hitApiToUpdateUserProfileImage(userId: userId, imagePath: fileImage);
        }
      },
    ));
  }

  Future hitApiToUpdateUserProfileImage({imagePath, userId}) async {
    Map<String, dynamic> map = {};

    showLoading();
    FormData formData = FormData.fromMap(
      {
        'user_id': userId,
        'profile_photo_path': await MultipartFile.fromFile(
            imagePath?.path ?? "",
            filename: imagePath?.path.split('/').last),
      },
    );

    await iUserManagementRepository
        ?.updateUserDetails(formData: formData)
        .then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value?.message ?? "");
        hitApiToGetDetails(userId: userId);
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  showDetailsOnFields(UserDataModel? userDataModel) {
    if (userDataModel != null) {
      nameController.text = userDataModel.name ?? "";
      emailController.text = userDataModel.email ?? "";
      phoneController.text = userDataModel.phone ?? "";
      selectState.value = getStateTitle(userDataModel?.stateId) ?? "";
      selectGender.value = userDataModel.gender == APIEndpoint.male
          ? AppStrings.male
          : userDataModel.gender == APIEndpoint.female
              ? AppStrings.female
              : AppStrings.selectGender;
      update();
    }
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
          child: TractorText(text: AppStrings.details),
        ),
        if(box.read(roleType) == APIEndpoint.aminRole)PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.editTxt),
        ),
        if(box.read(roleType) == APIEndpoint.aminRole) PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteTxt),
        )
      ],
    );
  }

  Future hitApiToGetUserList() async {
    showLoading();
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = currentPage.value;
    if (box.read(roleType) == APIEndpoint.aminRole){
      map['allData'] = 1;
    }

    await iUserManagementRepository?.getAllUserList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        adminUserDataModel = value.data;
        userList?.addAll(value.data?.farmers ?? []);
        userList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetDetails({userId}) async {
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = userId;
    await iUserManagementRepository?.userDetails(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        userDataModel.value = value.data;
        userDataModel.refresh();
        if (userDataModel?.value?.profilePhotoPath != null) {
          profileImage.value = File(
              '${APIEndpoint.imageUrl}${userDataModel?.value?.profilePhotoPath}');
        }else{
          profileImage.value=null;
        }
        profileImage.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnFarmerList() {
    userController.addListener(() {
      if (userController.position.pixels ==
          userController.position.maxScrollExtent) {
        if (adminUserDataModel != null &&
            int.parse(adminUserDataModel?.pageNo?.toString() ?? "1") <
                int.parse(adminUserDataModel?.totalPages?.toString() ?? "1")) {
          currentPage.value = currentPage.value + 1;
          currentPage.refresh();
       //   hitApiToGetUserList();
            hitApiToGetTractorList();
        }
      }
    });
  }

  Future hitApiToDeleteUser({index, id}) async {
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = id;

    await iUserManagementRepository?.deleteUser(map: map).then((value) {
      hideLoading();
      if (value != null) {
        userList?.removeAt(index!);
        userList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToUpdateUserDetails({index, id}) async {
    Map<String, dynamic> map = {};
    if (phoneController.text.isNotEmpty && phoneController.text.length < 10 ||
        phoneController.text.length > 15) {
      showToast(message: AppStrings.numberInvalid);
      return;
    }
    showLoading();
    map['user_id'] = id;
    map['name'] = nameController.text.trim();
    map['phone'] = phoneController.text.trim();
    map['gender'] = selectGender.value == AppStrings.male
        ? APIEndpoint.male
        : selectGender.value == AppStrings.female
            ? APIEndpoint.female
            : "";
    map['stateId'] = getStateIdBaseOnValues(selectState.value);
    await iUserManagementRepository
        ?.updateUserDetails(formData: FormData.fromMap(map))
        .then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value?.message ?? "");
        userList![index] = value.data!;
        userList?.refresh();
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetTractorList({showLoader}) async {

    if (showLoader == null) {
      showLoading("Loading");
    }
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = Get.find<ListController>().pageNumber.value;

    await Get.find<ListController>().iHomeRepository?.getAllGroupTractorList(map: map).then((value) {
      if (showLoader == null) {
        hideLoading();
      }
      if (value != null && value.data != null) {
         tractorGroupDataModel = value.data;
        groupList?.addAll(Get.find<ListController>().tractorGroupDataModel?.groups ?? []);
         groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      if (showLoader == null) {
        hideLoading();
      }
      showToast(message: error?.toString());
    });
  }


  hitApiToExportFeedbackReports() async {
    if(groupList?.isEmpty==true){
      return;
    }
    progressDialog = ProgressDialog(context: Get.overlayContext!);
    progressDialog?.show(msg: "File Exporting..");
    Map<String, dynamic> map = {};
    map['type_id']=APIEndpoint.exportGroup;

    await iTractorRepository?.exportReports(map: map).then((value) {
      if (value.status == true) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          hitApiToCheckExportExist(fileName: value.data?.fileName);
        });
      }else{
        hideLoading();
        showToast(message: value.message);
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

}
