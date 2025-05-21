import 'package:tanod_tractor/presentation/pages/map_modules/play_back_view.dart';

import '../../../app/util/export_file.dart';
import '../../../data/models/admin_booking_model.dart';
import '../../../data/models/home_device_model.dart';

class MapDetailsScreen extends StatefulWidget {
  HomeDeviceDataModel? bookingModel;
  String? address;
  bool? fromMap = true;

  MapDetailsScreen(
      {this.bookingModel, this.fromMap = true, this.address, super.key});

  @override
  State<MapDetailsScreen> createState() => _MapDetailsScreenState();
}

class _MapDetailsScreenState extends State<MapDetailsScreen> {
  String? deviceSpeedStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.details,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            itemViewWidget(
                imageName: AppPngAssets.deviceNameImage,
                title: AppStrings.deviceName,
                value: widget?.bookingModel?.deviceName ?? ""),
            itemViewWidget(
                imageName: AppPngAssets.deviceTypeImage,
                title: AppStrings.deviceType,
                value: widget?.bookingModel?.deviceModal ?? ""),
            itemViewWidget(
                imageName: AppPngAssets.deviceImeiImage,
                title: AppStrings.imei,
                value: widget?.bookingModel?.apiData?.imei?.toString() ??
                    ""),
            itemViewWidget(
                imageName: AppPngAssets.deviceExpirationImage,
                title: AppStrings.expirationDate,
                value: widget?.bookingModel?.apiData?.expireFlag
                            ?.toString() ==
                        "1"
                    ? AppStrings.expired
                    : AppStrings.notExpired),
            itemViewWidget(
                imageName: AppPngAssets.deviceSimImage,
                title: AppStrings.sim,
                value: "-"),
            itemViewWidget(
                imageName: AppPngAssets.deviceIgnition,
                title: AppStrings.ignition,
                value:
                    widget?.bookingModel?.apiData?.status?.toString() ==
                            "1"
                        ? AppStrings.onTxt
                        : AppStrings.offTxt),
            itemViewWidget(
                imageName: AppPngAssets.deviceLocation,
                title: AppStrings.deviceLocationTime,
                value:
                    widget?.bookingModel?.apiData?.hbTime?.toString() ??
                        ""),
            itemViewWidget(
                imageName: AppPngAssets.deviceLatestUpdate,
                title: AppStrings.deviceLocationUpdate,
                value: widget?.bookingModel?.apiData?.locDesc ?? ""),
            itemViewWidget(
                imageName: AppPngAssets.deviceSpeed,
                title: AppStrings.deviceSpeed,
                value:
                    "${widget?.bookingModel?.apiData?.speed ?? ""} ${AppStrings.kmUnit}"),
            itemViewWidget(
                imageName: AppPngAssets.deviceLatitudeLongitude,
                title: AppStrings.deviceLatLng,
                value:
                    "${widget?.bookingModel?.apiData?.lat?.toString() ?? ""}/${widget?.bookingModel?.apiData?.lng?.toString() ?? ""}"),
            itemViewWidget(
                imageName: "",
                defaultImage: AppPngAssets.deviceAddressImage,
                title: AppStrings.deviceAddress,
                value: widget.address ?? ""),
            itemViewWidget(
                imageName: "",
                defaultImage: AppPngAssets.deviceStatusImage,
                title: AppStrings.deviceStatus,
                value: getDeviceStatus()??""),
            widget.fromMap == true ? showAllHistoryWidget() : SizedBox()
          ],
        ),
      ),
    );
  }

  getDeviceStatus(){
    if(widget?.bookingModel?.apiData?.speed==null){
      return;
    }
    if(int.parse(widget?.bookingModel?.apiData?.speed.toString()??"0")==0&&int.parse(widget?.bookingModel?.apiData?.accStatus.toString()??"0")==1){
      deviceSpeedStatus="Idle (Acc On)";
    }else if(int.parse(widget?.bookingModel?.apiData?.speed.toString()??"0")>0&&int.parse(widget?.bookingModel?.apiData?.accStatus.toString()??"0")==1){
      deviceSpeedStatus="Moving (Acc On)";
    }else if(int.parse(widget?.bookingModel?.apiData?.accStatus.toString()??"0")==0){
      deviceSpeedStatus="Offline (Acc Off)";
    }else{
      deviceSpeedStatus="Undefined";
    }

    return deviceSpeedStatus;


  }

  itemViewWidget({imageName, title, value, defaultImage}) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          imageName != ""
              ? Image.asset(
                  imageName ?? "",
                  height: 40.h,
                  width: 40.w,
                )
              : Container(
                  padding: EdgeInsets.all(10.r),
                  height: 40.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withOpacity(0.1)),
                  width: 40.w,
                  child: Image.asset(
                    defaultImage,
                    width: 40.w,
                    color: Colors.grey,
                    height: 40.h,
                  ),
                ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 13.sp),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }

  showAllHistoryWidget({title}) {
    return GestureDetector(
      onTap: () {
        Get.to(PlayBackView(
          deviceImei: widget?.bookingModel?.apiData?.imei?.toString(),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 100.h),
        padding: EdgeInsets.all(10.r),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
            color: AppColors.primary),
        child: Center(
          child: TractorText(
            text: AppStrings.playBack,
            fontSize: 16.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
