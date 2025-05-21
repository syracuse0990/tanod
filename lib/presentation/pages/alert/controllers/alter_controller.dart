import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../../../data/models/alert_detail_model.dart';
import '../../../../data/models/alert_model.dart';
import '../../../../data/repositories/alert_provider/impl/remote_alert_provider.dart';
import '../../../../data/repositories/alert_provider/interface/alert_repository.dart';


class AlertController extends GetxController with BaseController {
  IAlertRepository? iAlertRepository;
  var alertController = ScrollController();
  RxInt currentPage = 1.obs;

  RxString selectedAlterValue = AppStrings.all.obs;


  List<String> alertFilterList=[AppStrings.all,AppStrings.accOn,AppStrings.accOFF,AppStrings.geofenceIn,AppStrings.geofenceOut];

  AlertDataModel? alertDataModel;
  RxList<AlertDetailModel>? alertList = <AlertDetailModel>[].obs;

  @override
  void onInit() {
     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      alertList?.clear();
      iAlertRepository = Get.put(RemoteAlertProvider());
      hitApiToGetAlertList(alarmType: "");
      addPaginationList();
    });
    // TODO: implement onInit
    super.onInit();
  }

  Future hitApiToGetAlertList({alarmType}) async {
    Map<String, dynamic> map = {};
    map['records_per_page'] = 10;
    map['page_no'] = currentPage.value;
    map['alarm_type'] =alarmType??"";

    showLoading("Loading Alert");
    await iAlertRepository?.getAllAlertList(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        alertDataModel = value.data;
        alertList?.addAll(alertDataModel?.alerts ?? []);
        alertList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  addPaginationList() {
    alertController.addListener(() {
      if (alertController.position.pixels ==
          alertController.position.maxScrollExtent) {
        if (alertDataModel != null &&
            int.parse(alertDataModel?.pageNo?.toString() ?? "1") <
                int.parse(alertDataModel?.totalPages?.toString() ?? "1")) {
          currentPage.value = currentPage.value + 1;
          currentPage.refresh();
          if( selectedAlterValue.value==AppStrings.all){
            hitApiToGetAlertList(alarmType: "");
          }else{
            hitApiToGetAlertList(alarmType: getAlertBasedId(selectedAlterValue.value));
          }
        }
      }
    });
  }
}
