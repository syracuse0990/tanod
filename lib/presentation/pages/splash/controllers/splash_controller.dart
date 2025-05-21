import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/router/route_page_strings.dart';

import '../../../../data/providers/network/local_keys.dart';
import '../../../../main.dart';

class SplashController extends GetxController{


  Timer? timer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      moveToNextScreen();
    });
  }


  moveToNextScreen(){
    timer=Timer(Duration(seconds: 2), () {
      if(box.read(tokenKeys) == null){
        Get.offAllNamed(RoutePage.signIn);
      }else{
        Get.offAllNamed(RoutePage.dashboard);
      }

    });
  }

  @override
  void dispose() {
    if(timer!=null){
      timer?.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
}