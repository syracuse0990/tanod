import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/config/app_constants.dart';
import 'package:tanod_tractor/app/util/app_assets.dart';
import 'package:tanod_tractor/presentation/pages/map_modules/play_back_view.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/mock.dart';
import '../../../app/util/util.dart';
import '../../../data/models/admin_booking_model.dart';
import '../../../data/models/home_device_model.dart';
import '../../components/add_space.dart';
import '../../components/label_icon_widget.dart';
import '../../components/tractor_text.dart';
import '../admin_modules/geofence/controller/geofence_controller.dart';
import '../admin_modules/geofence/views/add_new_geofence_view.dart';
import '../admin_modules/static_pages/views/update_static_page_view.dart';
import 'map_details_screen.dart';

class MapBottomSheetView extends StatelessWidget {
  HomeDeviceDataModel? bookingModel;
  Function? onTab;
  String? stoppedTime;

  MapBottomSheetView({
    this.bookingModel,
    this.onTab,
    this.stoppedTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: Container(
        color: Colors.white,
        height: Get.height * 0.45,
        width: Get.width,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20.w,),
                TractorText(
                  text: 'Group Name:-',
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                SizedBox(width: 5.w,),
                Expanded(
                  child: TractorText(
                    text: '${bookingModel?.group ?? ""}',
                    color: AppColors.primary,
                     fontWeight: FontWeight.bold,
                    fontSize: 19.sp,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    if (onTab != null) {
                      onTab!();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Icon(Icons.clear),
                  ),
                ),
              ],
            ),
            Container(
              height: 2.1.h,
              width: Get.width * 0.12,
              margin: EdgeInsets.only(top: 20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.lightGray,
                  shape: BoxShape.rectangle),
            ),
            AddSpace.vertical(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios),
                  // TractorText(
                  //   text: bookingModel?.createdBy?.name ??
                  //       bookingModel?.createdBy?.email ??
                  //       "",
                  //   color: AppColors.black,
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 16.sp,
                  // ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: randomColor().withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: TractorText(
                        text: bookingModel?.apiData?.imei?.toString() ?? ""),
                  )
                ],
              ),
            ),
            AddSpace.vertical(10.h),
            SizedBox(
              height: 80.h,
              child: Row(
                children: [
                  AddSpace.horizontal(30.w),
                  Container(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      children: [
                        TractorText(
                          text: 'Stopped',
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        const Spacer(),
                        TractorText(
                          text: stoppedTime??"No Data",
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? getDeviceStatus()
                              : index == 1
                                  ? getTractorSpeed()
                                  : index == 2
                                      ? getTractorPosType()
                                      : index == 3
                                          ? getTractorSettingView()
                                          : SizedBox();
                        }),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  AddSpace.vertical(5.h),
                  Divider(
                    thickness: 1.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppSvgAssets.lastPosition),
                        AddSpace.horizontal(15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TractorText(
                              text: 'No DATA',
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                            TractorText(
                              text: 'Last Position',
                              color: AppColors.lightGray,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset(AppSvgAssets.lastUpdate),
                        AddSpace.horizontal(15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TractorText(
                              text: 'No DATA',
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                            TractorText(
                              text: 'Last Update',
                              color: AppColors.lightGray,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AddSpace.vertical(5.h),
                  Divider(
                    thickness: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppIconLabel(
                        onTab: () {
                          Get.to(PlayBackView(
                            deviceImei:
                                bookingModel?.apiData?.imei?.toString(),
                          ));
                        },
                        svgIcon: AppSvgAssets.playBack,
                        label: AppStrings.playBack,
                        bgColor: Colors.transparent,
                        svgIconColor: AppColors.primary,
                      ),
                      AppIconLabel(
                        onTab: () async {
                          String address=await getLocationFromLatLong(latitude:bookingModel?.apiData?.lat??0.0,longitude: bookingModel?.apiData?.lng??0.0 );
                          Get.to(MapDetailsScreen(bookingModel: bookingModel,address: address,fromMap: false,));
                        },
                        svgIcon: AppSvgAssets.details,
                        label: AppStrings.details,
                        bgColor: Colors.transparent,
                        svgIconColor: AppColors.primary,
                      ),
                      AppIconLabel(
                        onTab: (){
                          if(!Get.isRegistered<AdminGeoFenceController>()){
                            Get.lazyPut(() => AdminGeoFenceController());
                          }

                          Get.to(() => AddNewGeoFenceView(isFromHome: true,deviceImei: bookingModel?.apiData?.imei,));


                        },
                        svgIcon: AppSvgAssets.geoFence,
                        label: AppStrings.geoFence,
                        bgColor: Colors.transparent,
                        svgIconColor: AppColors.primary,
                      ),
                      AppIconLabel(
                        svgIcon: AppSvgAssets.more,
                        label: AppStrings.more,
                        bgColor: Colors.transparent,
                        svgIconColor: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getDeviceStatus() {
    return detailWidget(
        bgColor: bookingModel?.apiData?.accStatus == "1"
            ? AppColors.primary.withOpacity(0.3)
            : AppColors.red,
        assetImage: AppPngAssets.onOffImage,
        value: bookingModel?.apiData?.accStatus == "1"
            ? AppStrings.onTxt
            : AppStrings.offTxt);
  }

  Widget getTractorSpeed() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: detailWidget(
          bgColor: Colors.white,
          assetImage: AppPngAssets.speedImage,
          value:
              "${bookingModel?.apiData?.speed?.toString()}\n${AppStrings.kmUnit}"),
    );
  }

  Widget getTractorPosType() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: detailWidget(
          bgColor: Colors.white,
          assetImage: AppPngAssets.gpsViewImage,
          value:
              bookingModel?.apiData?.posType?.toString().toUpperCase() ==
                      "GPS"
                  ? AppStrings.yesTxt
                  : AppStrings.noTxt),
    );
  }

  Widget getTractorSettingView() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: detailWidget(
          bgColor: Colors.white,
          assetImage: AppPngAssets.settingImage,
          value: "No Data"),
    );
  }

  Widget detailWidget({bgColor, assetImage, value}) {
    return Container(
      width: 100.w,
      height: 300.h,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary, width: 1.w),
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetImage,
            height: 25.h,
            width: 25.w,
          ),
          SizedBox(
            height: 4,
          ),
          TractorText(
            text: value ?? "",
            color: Colors.black,
            fontSize: 13.sp,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w800,
          )
        ],
      ),
    );
  }
}
