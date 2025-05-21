import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../app/util/export_file.dart';
import '../../../../data/models/maintenance_detail_model.dart';
import '../../../../data/models/maintenance_model.dart';
import '../../../../data/models/state_model.dart';
import '../../../../data/repositories/maintenance_provider/impl/remote_maintenance_provider.dart';
import '../../../../data/repositories/maintenance_provider/interface/maintenance_repository.dart';

class MaintenanceController extends GetxController with BaseController {
  IMaintenanceRepository? iMaintenanceRepository;
  MaintenanceDataModel? maintenanceDataModel;
  RxString selectState = AppStrings.documentation.obs;
  RxString selectTractor = AppStrings.selectSingleTractor.obs;
  RxString selectFilterTractor = AppStrings.selectSingleTractor.obs;
  ITractorRepository? iTractorRepository;
  var maintenanceDateController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phnNumberController = TextEditingController();
  RxInt selectedIndex = 0.obs;
  var maintenanceModel = Rxn<MaintenanceDetailModel>();
  var updatedMaintenanceModel = Rxn<MaintenanceDetailModel>();
  var tractorModel = Rxn<TractorModel>();
  var scrollController = ScrollController();
  RxBool fromMaintenance = false.obs;
  RxInt currentPage = 1.obs;

  var selectedDateRange = Rxn<DateRangePickerSelectionChangedArgs>();

  RxList<MaintenanceDetailModel>? maintenanceList =
      <MaintenanceDetailModel>[].obs;

  RxInt tractorPage = 1.obs;

  var tractorIssueController = ScrollController();

  RxList<TractorModel>? tractorList = <TractorModel>[].obs;
  TractorDetailDataModel? tractorDetailDataModel;

  var tractorIssueModel = Rxn<TractorModel>();
  RxInt tractPage = 1.obs;

  RxList<TractorModel>? tractorIssueList = <TractorModel>[].obs;
  var tractorController = ScrollController();
  TractorDetailDataModel? tractorDetailIssueDataModel;

  RxList<StateModel>? stateList = <StateModel>[].obs;
  var conclusionController = TextEditingController();
  var searchController = TextEditingController();

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      stateListInit();
      iMaintenanceRepository = Get.put(RemoteIMaintenanceProvider());
      iTractorRepository = Get.put(RemoteITractorProvider());
      maintenanceList?.clear();
      tractorList?.clear();
      hitApiToGetAllMaintenanceList();
      addPaginationOnMaintenanceList();




      //here we get list of tractor as admin
      hitApiToGetTractorList();
      addPaginationOnTractorList();

    });
    super.onInit();
  }

  stateListInit() {
    stateList?.clear();
    stateList?.add(StateModel(
        stateId: APIEndpoint.stateDocumentation,
        title: AppStrings.documentation));
    stateList?.add(
        StateModel(stateId: APIEndpoint.stateFilled, title: AppStrings.filled));
    stateList?.add(StateModel(
        stateId: APIEndpoint.stateInProgress, title: AppStrings.inProgress));
    stateList?.add(StateModel(
        stateId: APIEndpoint.statesCompleted, title: AppStrings.completed));
    stateList?.add(StateModel(
        stateId: APIEndpoint.statesCancelled, title: AppStrings.cancelled));
    stateList?.refresh();
  }

  showDetailsOnFields() {
    if (updatedMaintenanceModel.value != null) {
      tractorModel.value?.id=updatedMaintenanceModel.value?.tractor?.id;;
      tractorModel.refresh();
      selectTractor.value = updatedMaintenanceModel.value?.tractor?.noPlate?.toString() ?? "";
      if (tractorList != null && tractorList?.isNotEmpty == true) {
        tractorList?.forEach((element) {
          element?.isSelected=false;
        });
        int? index = tractorList?.indexWhere((model) => model.id?.toString() ==updatedMaintenanceModel.value?.tractorIds.toString());
        if (index != -1) {
          tractorList![index!].isSelected = true;
          tractorList?.refresh();
        }
      }
      maintenanceDateController.text =  updatedMaintenanceModel.value?.maintenanceDate ?? "";
      nameController.text = updatedMaintenanceModel.value?.techName ?? "";
      emailController.text = updatedMaintenanceModel.value?.techEmail ?? "";
      phnNumberController.text =
          updatedMaintenanceModel.value?.techNumber ?? "";
      update();
    }
  }

  Future hitApiToGetAllMaintenanceList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 4;
    map['page_no'] = currentPage.value;
    map['search'] = searchController.text;
    map;
    await iMaintenanceRepository?.getAllMaintenanceList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        maintenanceDataModel = value.data;
        if (searchController.text.isNotEmpty) {
          maintenanceList?.value = maintenanceDataModel?.maintenance ?? [];
        } else {
          maintenanceList?.addAll(maintenanceDataModel?.maintenance ?? []);
        }

        maintenanceList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnMaintenanceList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {

        if (maintenanceDataModel != null&&maintenanceDataModel?.totalPages!=null&& maintenanceDataModel?.pageNo!=null&&
            currentPage.value <
                int.parse(maintenanceDataModel?.totalPages.toString() ?? "1") &&
            int.parse(maintenanceDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    maintenanceDataModel?.totalPages?.toString() ?? "1")) {
          currentPage.value = currentPage.value + 1;
          currentPage.refresh();
          searchController.clear();
          hitApiToGetAllMaintenanceList();
        }
      }
    });
  }

  showPopUpMenuButton({onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      color: AppColors.white,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.details),
        ),
        PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.editTxt),
        ),
        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 3,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteTxt),
        )
      ],
    );
  }

  Future hitApiToUpdateNewMaintenance({id, tractorId, index}) async {
    if (selectTractor.value == AppStrings.selectSingleTractor) {
      showToast(message: AppStrings.selectTractor);
      return;
    } else if (maintenanceDateController.text.isEmpty) {
      showToast(message: AppStrings.maintenanceDateIsEmpty);
      return;
    } else if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return;
    } else if (phnNumberController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterNumber);
      return;
    } else if (phnNumberController.text.length < 10 ||
        phnNumberController.text.length > 15) {
      showToast(message: AppStrings.numberInvalid);
      return;
    }

    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['tractor_ids'] = tractorModel.value==null?updatedMaintenanceModel.value?.tractorIds:tractorModel.value?.id;
    map['maintenance_date'] = maintenanceDateController.text;
    map['tech_name'] = nameController.text;
    map['tech_email'] = emailController.text;
    map['tech_number'] = phnNumberController.text;

    await iMaintenanceRepository?.updateMaintenance(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value.message);
        currentPage.value = 1;
        currentPage.refresh();

        maintenanceList?.clear();
        maintenanceList?.refresh();
        hitApiToGetAllMaintenanceList();

        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToCreateNewMaintenance(int? index) async {
    if (selectTractor.value == AppStrings.selectSingleTractor) {
      showToast(message: AppStrings.selectTractor);
      return;
    } else if (maintenanceDateController.text.isEmpty) {
      showToast(message: AppStrings.maintenanceDateIsEmpty);
      return;
    } else if (nameController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterName);
      return;
    } else if (emailController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterEmail);
      return;
    } else if (!GetUtils.isEmail(emailController.text)) {
      showToast(message: AppStrings.emailInvalid);
      return;
    } else if (phnNumberController.text.isEmpty) {
      showToast(message: AppStrings.pleaseEnterNumber);
      return;
    } else if (phnNumberController.text.length < 10 ||
        phnNumberController.text.length > 15) {
      showToast(message: AppStrings.numberInvalid);
      return;
    }

    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['tractor_ids'] = tractorModel.value?.id;
    map['maintenance_date'] = maintenanceDateController.text;
    map['tech_name'] = nameController.text;
    map['tech_email'] = emailController.text;
    map['tech_number'] = phnNumberController.text;

    await iMaintenanceRepository?.createNewMaintenance(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        showToast(message: value.message);

        Get.back();
        clearAllFields();
        currentPage.value = 1;
        maintenanceList?.clear();
        hitApiToGetAllMaintenanceList();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToDeleteMaintenance({id, index}) async {
    showLoading("Loading");
    await iMaintenanceRepository
        ?.deleteMaintenance(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message: value.message);
        currentPage.value = 1;
        maintenanceList?.clear();
        hitApiToGetAllMaintenanceList();
        Get.forceAppUpdate();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToViewMaintenanceDetails({id}) async {
    showLoading("Loading");
    await iMaintenanceRepository
        ?.maintenanceDetails(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        maintenanceModel.value = value.data;
        maintenanceModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToChangeMaintenanceState({id, stateId}) async {
    showLoading("Loading");
    await iMaintenanceRepository?.changeMaintenanceState(
        map: {"id": id, "state_id": stateId}).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message: value?.message ?? "");
        selectState.value = AppStrings.selectState;
        hitApiToViewMaintenanceDetails(id: id);
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

//this api is used when user mark either complete or cancelled
  hitApiToChangeState({id, stateId}) async {
    if (conclusionController.text.isEmpty) {
      showToast(message: AppStrings.conclusionEmpty);
      return;
    }
    showLoading("Loading");
    await iMaintenanceRepository?.addMaintenanceConclusion(map: {
      "id": id,
      "state_id": stateId,
      "conclusion": conclusionController.text
    }).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message: value?.message ?? "");
        Get.back();
        selectState.value = AppStrings.selectState;
        hitApiToViewMaintenanceDetails(id: id);
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
          tractPage.value = tractPage.value + 1;
          tractPage.refresh();
          hitApiToGetTractorList();
        }
      }
    });
  }

  Future hitApiToGetTractorList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractPage.value;
    map['allData'] = 1;

    await iTractorRepository?.getAllTractorList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        tractorDetailDataModel = value.data;
        tractorList?.addAll(tractorDetailDataModel?.tractors ?? []);
        tractorList?.refresh();
        Get.forceAppUpdate();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnTractorIssueList() {
    tractorIssueController.addListener(() {
      if (tractorIssueController.position.pixels ==
          tractorIssueController.position.maxScrollExtent) {
        if (tractorDetailIssueDataModel != null &&
            int.parse(tractorDetailIssueDataModel?.pageNo?.toString() ?? "1") <
                int.parse(tractorDetailIssueDataModel?.totalPages?.toString() ??
                    "1")) {
          tractPage.value = tractPage.value + 1;
          tractPage.refresh();
          hitApiToGetTractorList();
        }
      }
    });
  }

  hitApiToApplyFilterOnMaintenanceOnList() async {
    Map<String, dynamic> map = {};
    if(selectFilterTractor.value==AppStrings.selectSingleTractor){
      showToast(message:AppStrings.selectSingleTractor);
      return;
    }else if(selectedDateRange.value==null){
      showToast(message:AppStrings.selectDateRange);
      return;
    }
    map['tractor_id'] = tractorIssueModel?.value?.id;
    map['start_date'] =selectedDateRange.value?.value.startDate;
    map['end_date'] = selectedDateRange.value?.value.endDate;

    showLoading("Loading");
    await iMaintenanceRepository
        ?.applyFilterOnMaintenance(map: map)
        .then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        maintenanceDataModel = value.data;
        maintenanceList?.clear();
        maintenanceList?.value=maintenanceDataModel?.maintenance??[];
        maintenanceList?.refresh();
        Get.back();

      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  hitApiToGetMaintenanceTractorList() async {
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = tractorPage.value;
    showLoading("Loading");
    await iMaintenanceRepository
        ?.getMaintenanceTractorList(map: map)
        .then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        tractorDetailIssueDataModel = value.data;
        tractorIssueList?.addAll(tractorDetailIssueDataModel?.tractors ?? []);
        tractorIssueList?.refresh();
        Get.forceAppUpdate();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationOnIssueMaintenanceList() {
    tractorIssueController.addListener(() {
      if (tractorIssueController.position.pixels ==
          tractorIssueController.position.maxScrollExtent) {
        if (tractorDetailIssueDataModel != null &&
            int.parse(tractorDetailIssueDataModel?.pageNo?.toString() ?? "1") <
                int.parse(tractorDetailIssueDataModel?.totalPages?.toString() ??
                    "1")) {
          tractorPage.value = tractorPage.value + 1;
          tractorPage.refresh();
          hitApiToGetMaintenanceTractorList();
        }
      }
    });
  }

  clearAllFields() {
    selectTractor.value = AppStrings.selectSingleTractor;
    maintenanceDateController.clear();
    nameController.clear();
    emailController.clear();
    phnNumberController.clear();
    update();
  }
}
