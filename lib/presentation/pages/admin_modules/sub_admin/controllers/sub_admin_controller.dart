import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../app/util/media_select_dialog.dart';
import '../../../../../data/models/admin_user_model.dart';
import '../../../../../data/models/state_model.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/user_management_provider/impl/remote_user_management_provider.dart';
import '../../../../../data/repositories/user_management_provider/interface/user_management_repository.dart';

class SubAdminController extends GetxController with BaseController {
  RxString selectState = AppStrings.active.obs;
  RxString selectGender = AppStrings.selectGender.obs;
  IUserManagementRepository? iUserManagementRepository;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  PhoneNumber? phoneNumber;
  RxInt? groupSelectedIndex=0.obs;
  RxInt? groupId=0.obs;
  RxList<StateModel>? genderList = <StateModel>[].obs;
  ISubAdminRepository? iSubAdminRepository;
  var scrollController = ScrollController();
  RxInt currentPage = 1.obs;
  AdminUserDataModel? adminUserDataModel;
  RxList<UserDataModel>? userList = <UserDataModel>[].obs;
  var profileImage = Rxn<File>();
  var userDataModel = Rxn<UserDataModel>();

  showDetailsOnField(UserDataModel ? userDataModel){
    if(userDataModel==null)
      return;

    nameController.text = userDataModel.name ?? "";
    emailController.text = userDataModel.email ?? "";
    phoneController.text = userDataModel.phone ?? "";
    selectState.value = getStateTitle(userDataModel?.stateId) ?? "";
    phoneNumber=PhoneNumber(countryISOCode: userDataModel?.countryCode, countryCode: userDataModel.phoneCountry, number: userDataModel.phone);
    selectGender.value = userDataModel.gender == APIEndpoint.male
        ? AppStrings.male
        : userDataModel.gender == APIEndpoint.female
        ? AppStrings.female
        : AppStrings.selectGender;
    selectGender.refresh();
    update();
  }

  Future hitApiToGetUserList() async {
    showLoading();
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = currentPage.value;
    map['subAdmin'] = 1;
    await iSubAdminRepository?.getAllUserList(map: map).then((value) {
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

  Future hitApiToGetDetails({userId}) async {
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = userId;
    await iSubAdminRepository?.userDetails(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        userDataModel.value = value.data;
        userDataModel.refresh();
        if (userDataModel?.value?.profilePhotoPath != null) {
          profileImage.value = File(
              '${APIEndpoint.imageUrl}${userDataModel?.value?.profilePhotoPath}');
        } else {
          profileImage.value = null;
        }
        profileImage.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  showPopUpMenuButton({assignTxt,onAssignedTab,onDetailTab, onDeleteTab, onEditTab}) {
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
        PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.editTxt),
        ),



        PopupMenuItem(
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

  Future hitApiToDeleteUser({index, id}) async {
    showLoading();
    Map<String, dynamic> map = {};
    map['user_id'] = id;

    await iSubAdminRepository?.deleteUser(map: map).then((value) {
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

  addPaginationOnFarmerList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (adminUserDataModel != null &&
            int.parse(adminUserDataModel?.pageNo?.toString() ?? "1") <
                int.parse(adminUserDataModel?.totalPages?.toString() ?? "1")) {
          currentPage.value = currentPage.value + 1;
          currentPage.refresh();
          hitApiToGetUserList();
        }
      }
    });
  }

  genderListInit() {
    genderList?.clear();
    genderList
        ?.add(StateModel(stateId: APIEndpoint.male, title: AppStrings.male));
    genderList?.add(
        StateModel(stateId: APIEndpoint.female, title: AppStrings.female));

    genderList?.refresh();
  }

  hitApiToAddSubAdmin() async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return;
    } else if (phoneController.text.isEmpty) {
      showToast(message: AppStrings.numberInvalid);
      return;
    } else if (phoneController.text.length < 5 ||
        phoneController.text.length > 15) {
      showToast(message: AppStrings.numberInvalid);
      return;
    } else if (selectGender.value == AppStrings.selectGender) {
      showToast(message: AppStrings.selectGender);
      return;
    }

    Map<String, dynamic> map = {};
    showLoading();

    map['name'] = nameController.text.trim();
    map['phone'] = phoneController.text.trim();
    map['email'] = emailController.text.trim();
    map['gender'] = selectGender.value == AppStrings.male
        ? APIEndpoint.male
        : selectGender.value == AppStrings.female
            ? APIEndpoint.female
            : "";

    map['iso_code'] = phoneNumber?.countryISOCode?.toLowerCase();
    map['phone_code'] = phoneNumber?.countryCode;
    map['phone'] = phoneNumber?.number;

    await iSubAdminRepository?.createNewSubAdmin(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        userList?.add(value.data!);
        showToast(message: value?.message ?? "");

        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToUpdateSubAdmin({index, userId}) async {
    if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return;
    } else if (phoneController.text.isEmpty) {
      showToast(message: AppStrings.numberInvalid);
      return;
    } else if (phoneController.text.length < 5 ||
        phoneController.text.length > 15) {
      showToast(message: AppStrings.numberInvalid);
      return;
    } else if (selectGender.value == AppStrings.selectGender) {
      showToast(message: AppStrings.selectGender);
      return;
    }

    Map<String, dynamic> map = {};
    showLoading();

    map['id'] = userId;
    map['name'] = nameController.text.trim();
    map['phone'] = phoneController.text.trim();
    map['email'] = emailController.text.trim();
    map['gender'] = selectGender.value == AppStrings.male
        ? APIEndpoint.male
        : selectGender.value == AppStrings.female
            ? APIEndpoint.female
            : "";

    map['iso_code'] = phoneNumber?.countryISOCode?.toLowerCase();
    map['phone_code'] = phoneNumber?.countryCode;
    map['phone'] = phoneNumber?.number;

    await iSubAdminRepository?.updateSubAdmin(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value?.message ?? "");
        userList![index] = value.data!;
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToAssignGroup({index, id, subAdminId, isAssigned}) async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['user_id'] = subAdminId;
    map['state'] = isAssigned;

    await iSubAdminRepository?.assignGroupToSubAdmin(map: map).then((value) {
      hideLoading();
      if (value != null) {
        if (groupSelectedIndex?.value != null && value.data != null) {
          if (!Get.isRegistered<ListController>()) {
            Get.lazyPut(() => ListController());
          }
          Get.find<ListController>().groupList?[groupSelectedIndex!.value].subAdmin = SubAdminModel(user: value.data);
          Get.find<ListController>().groupList?.refresh();
          Get.back();
        }

      }
    }).onError((error, stackTrace) {
      hideLoading();

      showToast(message: error?.toString());
    });
  }
}
