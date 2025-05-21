import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/presentation/pages/list/controller/list_controller.dart';
import 'package:tanod_tractor/presentation/pages/list/widgets/device_tile_view.dart';

class AllTabContentView extends GetWidget<ListController> {
  const AllTabContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Obx(() => Expanded(
              child: controller.stateDeviceList?.length != 0
                  ? ListView.builder(
                  itemCount: controller.stateDeviceList?.length??0,
                  itemBuilder: (context, index) {
                      return DeviceTileView(
                        isAdmin: true,
                        devicesModel: controller.stateDeviceList![index],
                      );
                    })
                  : noDataFoundWidget(),
            ))
      ],
    );
  }
}
