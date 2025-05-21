import 'package:flutter/scheduler.dart';

import '../../../../../app/util/export_file.dart';
import '../../../list/controller/list_controller.dart';

class AssignGroupsController extends GetxController with BaseController {
  TractorGroupDataModel? tractorGroupDataModel;
  RxString? subAdminUserId = "".obs;
  var groupIndex = 0.obs;
  ISubAdminRepository? iSubAdminRepository;
  RxList<GroupsModel>? groupList = <GroupsModel>[].obs;
  RxInt pageNumber = 1.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  Future hitApiToGetAssignGroupList({subAdminId}) async {
    showLoading("Loading");

    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['user_id'] = subAdminId;
    map['page_no'] = pageNumber.value;

    await iSubAdminRepository?.getAllGroupList(map: map).then((value) {
      hideLoading();

      if (value != null && value.data != null) {
        tractorGroupDataModel = value.data;
        groupList?.addAll(tractorGroupDataModel?.groups ?? []);
        groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();

      showToast(message: error?.toString());
    });
  }

  addPaginationOnTractorList() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (tractorGroupDataModel != null &&
            int.parse(tractorGroupDataModel?.pageNo?.toString() ?? "1") <
                int.parse(
                    tractorGroupDataModel?.totalPages?.toString() ?? "1")) {
          pageNumber.value = pageNumber.value + 1;
          pageNumber.refresh();
          hitApiToGetAssignGroupList();
        }
      }
    });
  }

  //todo for the assign groups to user
  Future hitApiToAssignGroup({index, id, subAdminId, isAssigned}) async {
    showLoading("Loading");
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['user_id'] = subAdminId;
    map['state'] = isAssigned;

    await iSubAdminRepository?.assignGroupToSubAdmin(map: map).then((value) {
      hideLoading();
      if (value != null) {
        if (groupList?.isNotEmpty == true) {
          if (groupList![index].assign == true) {
            groupList![index].assign = false;
          } else {
            groupList![index].assign = true;
          }
        }

        groupList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();

      showToast(message: error?.toString());
    });
  }
}
