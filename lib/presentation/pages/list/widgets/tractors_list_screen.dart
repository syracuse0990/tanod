import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/tractor_tile_view.dart';

import '../../../../data/models/tractor_group_model.dart';

class TractorsListScreen extends GetView<ListController> {
  List<TractorModel>? tractorList = [];
  bool? isAdmin;

   TractorsListScreen({this.isAdmin,this.tractorList,super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: tractorList?.length ?? 0,
        itemBuilder: (context, index) {
          return TractorTileView(tractorModel: tractorList?[index],isAdmin:isAdmin??false,);
        });
  }
}
