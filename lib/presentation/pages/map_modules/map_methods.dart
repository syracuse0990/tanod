import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../../../app/util/export_file.dart';

class MapMethods {
  Future getBytesFromAsset({speed, accStatus, status, mintues}) async {
    ByteData? data;
    ui.Codec? codec;
    print("check the speed pf y s${speed} and ${mintues}");

    if (int.parse(mintues?.toString() ?? "0") > 8) {
      data = await rootBundle.load(AppPngAssets.tractorLocationMarkerRed);
      codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetHeight: 100, targetWidth: 120);

    } else if (int.parse(speed ?? "0") == 0 && status?.toString() == "1") {
      data = await rootBundle.load(AppPngAssets.tractorLocationMarkerYellow);
      codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
    } else if (int.parse(speed ?? "0") > 0 && accStatus?.toString() == "1" && status?.toString() == "1") {
      data = await rootBundle.load(AppPngAssets.tractorLocationMarkerGreen);
      codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetHeight: 100, targetWidth: 120);
    } else {
      data = await rootBundle.load(AppPngAssets.tractorLocationMarkerRed);
      codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
          targetHeight: 100, targetWidth: 120);
    }

    ui.FrameInfo fi = await codec!.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  Widget mapIconsWidget(
          {onCurrentLocationTab, onMapTypeChangeTab, onRefreshTab,onPlayBackTab}) =>
      Positioned(
        top: 100,
        right: 10,
        child: Container(
          padding: EdgeInsets.only(top: 8.h, bottom: 42.h),
          decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (onMapTypeChangeTab != null) {
                    onMapTypeChangeTab!();
                  }
                },
                child: Image.asset(
                  AppPngAssets.switchMapImage,
                  height: 100.h,
                  width: 80.h,
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onRefreshTab != null) {
                    onRefreshTab!();
                  }
                },
                child: Image.asset(
                  AppPngAssets.mapRefreshImage,
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  if (onCurrentLocationTab != null) {
                    onCurrentLocationTab!();
                  }
                  //   controller.getLocation();
                },
                child: Image.asset(
                  AppPngAssets.mapCurrentLocation,
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  if (onPlayBackTab != null) {
                    onPlayBackTab!();
                  }
                  //   controller.getLocation();
                },
                child: Image.asset(
                  AppPngAssets.playBackImage,
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
}
