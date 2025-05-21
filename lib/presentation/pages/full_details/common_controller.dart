import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';


class CommonController extends GetxController with BaseController{

  ITractorRepository? iTractorRepository;

  var tractorModel=Rxn<TractorModel>();


  Future hitApiToGetDeviceDetails(id) async {
    showLoading("Loading");
    iTractorRepository=Get.put(RemoteITractorProvider());
    await iTractorRepository?.getTractorDetails(map: {"id": id}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        tractorModel.value=value.data;
        tractorModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }



}