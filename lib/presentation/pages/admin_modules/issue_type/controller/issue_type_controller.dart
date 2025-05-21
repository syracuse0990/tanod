import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/feedback_model.dart';
import '../../../../../data/models/issue_model.dart';
import '../../../../../data/repositories/issue_provider/impl/remote_issue_provider.dart';
import '../../../../../data/repositories/issue_provider/interface/issue_repository.dart';

class IssueTypeController extends GetxController with BaseController {
  IIssueRepository? issueRepository;

  var titleController = TextEditingController();
  RxString selectState = AppStrings.active.obs;

  var updatedIssueModel = Rxn<IssueType>();
  RxInt currentIndex = 0.obs;

  RxInt issuePage = 1.obs;
  var selectedIssueId = "".obs;

  RxBool isUpdating = false.obs;
  RxBool fromUser = false.obs;
   IssueTypeDataModel? issueTypeDataModel;
  RxList<IssueType>? issueTypeList = <IssueType>[].obs;

  var issueController = ScrollController();

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      issueRepository = Get.put(RemoteIIssueProvider());
      issueTypeList?.clear();
      hitApiToGetIssueList();
      addPaginationList();
    });
    super.onInit();
  }

  showPopUpMenuButton({onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.editTitle),
        ),
        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteIssueTitle),
        )
      ],
    );
  }

  Future hitApiToAddNewTitle() async {
    if (titleController.text.isEmpty) {
      showToast(message: AppStrings.titleIsEmpty);
      return;
    }
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map["title"] = titleController.text.trim();
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    await issueRepository?.addNewIssue(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        issueTypeList?.insert(0,value.data!);
        issueTypeList?.insert(0,value.data!);
        issueTypeList?.refresh();
        clearAllController();
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationList() {
    issueController.addListener(() {
      if (issueController.position.pixels ==
          issueController.position.maxScrollExtent) {
        if (issueTypeDataModel != null &&
            int.parse(issueTypeDataModel?.pageNo?.toString() ?? "1") <
                int.parse(issueTypeDataModel?.totalPages?.toString() ?? "1")) {
          issuePage.value = issuePage.value + 1;
          issuePage.refresh();
          hitApiToGetIssueList();
        }
      }
    });
  }

  Future hitApiToGetIssueList() async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = issuePage.value;

    await issueRepository?.getAllIssueTypeList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        issueTypeDataModel = value.data;
        if (issueTypeDataModel != null) {
          issueTypeList?.addAll(issueTypeDataModel?.issueType ?? []);
          if(selectedIssueId.value!=""){
            List<IssueType>? list=issueTypeList?.where((element) =>element?.id?.toString()==selectedIssueId.value ).toList();
            if(list!=null&&list!=[]){
              list.forEach((element) {
                element.isSelected=true;
              });
            }
          }
        }
        issueTypeList?.refresh();
        print("check list length ${issueTypeList?.length}");
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToDeleteIssueTitle(id, index) async {
    showLoading("Loading");
    await issueRepository?.deleteIssueTitle(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null) {
        showToast(message: value?.message ?? "");
        issueTypeList!.removeAt(index);
        issueTypeList!.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  clearAllController() {
    titleController.text = "";
    selectState.value = AppStrings.active;
    refresh();
  }

  Future hitApiToUpdateTitle({id, index}) async {
    if (titleController.text.isEmpty) {
      showToast(message: AppStrings.titleIsEmpty);
      return;
    }
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map["title"] = titleController.text.trim();
    map["id"] = id;
    map['state_id'] = getStateIdBaseOnValues(selectState.value);

    await issueRepository?.updateNewIssue(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        issueTypeList![index] = value.data!;
        issueTypeList?.refresh();
        clearAllController();
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }
}
