import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

import '../../../../data/models/tractor_group_model.dart';
import 'device_tile_view.dart';

class DeviceListScreen extends GetView<ListController> {
  List<DevicesModel>? devicesList = [];
  bool? isAdmin;
  DeviceListScreen({this.devicesList,this.isAdmin, super.key});

  @override
  Widget build(BuildContext context) {
    return  devicesList !=null&&  devicesList?.length !=0 ? ListView.builder(
        shrinkWrap: true,
        itemCount: devicesList?.length ?? 0,
        itemBuilder: (context, index) {
          return DeviceTileView(
            devicesModel: devicesList?[index],
            isAdmin: isAdmin??false,
          );
        }):noDataFoundWidget();
  }
}
