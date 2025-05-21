import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/util/util.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';

import '../../../../data/models/tractor_group_model.dart';
import 'common_tile_view.dart';

class FarmerListScreen extends GetView<ListController> {
  List<FarmerModel>? farmerList = [];
  ScrollController? farmerController = ScrollController();
  bool? isSelected;

  Function(int)? onTab;

  FarmerListScreen({this.onTab,this.farmerList,this.isSelected=false, this.farmerController,super.key});

  @override
  Widget build(BuildContext context) {
    return  farmerList!=null&&farmerList?.length!=0?ListView.builder(
        shrinkWrap: true,
        controller: farmerController??ScrollController(),
        itemCount: farmerList?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              if(onTab!=null){
                onTab!(index);
              }
            },
            child: CommonTileView(
              isSelected: farmerList?[index].isSelected??false,
              title: farmerList?[index].name ?? farmerList?[index].email,
            ),
          );
        }):noDataFoundWidget();
  }
}
