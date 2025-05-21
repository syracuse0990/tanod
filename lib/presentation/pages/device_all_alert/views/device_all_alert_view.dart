import '../../../../app/util/export_file.dart';
import '../../alert/views/alert_tile_view.dart';
import '../../alert/views/alter_other_details.dart';
import '../controllers/device_all_alerts_controller.dart';

class DeviceAllAlertView extends GetView<DeviceAllAlertsController> {
  Map<String,dynamic>? arguments;
  DeviceAllAlertView({this.arguments,super.key}){
     Future.delayed(Duration(milliseconds: 500),() {
       if(arguments!=null&&arguments?.isNotEmpty==true){
         controller.imei.value=arguments!['imei'];
         controller.imei.refresh();
         controller.hitApiToGetAlertBaseOnDevice();
        }
     },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.viewAlertDetails,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_sharp,
            size: 25.r,
            color: AppColors.white,
          ),
        ),


      ),
      body: Column(
        children: [
          SizedBox(height: 10.h,),
          Obx(() => Expanded(
              child: controller.alertList?.length != 0
                  ? ListView.builder(
                      controller: controller.alertController,
                      shrinkWrap: true,
                      itemCount: controller.alertList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AlertTileWidget(alertDetailModel:controller.alertList![index] ,);
                      })
                  : noDataFoundWidget()))
        ],
      ),
    );
  }
}
