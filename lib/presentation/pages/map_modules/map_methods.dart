import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tanod_tractor/presentation/pages/add/device/add_device.dart';
import 'package:tanod_tractor/presentation/pages/add/device/controller/add_device_binding.dart';
import 'package:tanod_tractor/presentation/pages/add/traktor/add_traktor.dart';
import 'package:tanod_tractor/presentation/pages/add/traktor/controller/add_traktor_binding.dart';

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
    } else if (int.parse(speed ?? "0") > 0 &&
        accStatus?.toString() == "1" &&
        status?.toString() == "1") {
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
          {onCurrentLocationTab,
          onMapTypeChangeTab,
          onRefreshTab,
          onPlayBackTab}) =>
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
              Visibility(
                visible: false,
                child:SizedBox(
                height: 20.h,
              ),
              ),
              Visibility(
                visible: false,// box.read(roleType) == APIEndpoint.technicianRole,
                child: GestureDetector(
                  onTap: () {
                    String? selectedType = "Device";
                
                    Get.bottomSheet(
                      Wrap(
                        children: [
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add New",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primary, width: 2),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      hint: Text("Choose an option"),
                                      value: selectedType,
                                      items: ['Device', 'Tractor'].map((item) {
                                        return DropdownMenuItem(
                                            value: item, child: Text(item));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedType = value;
                                        });
                                        print('Selected: $value');
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                TractorButton(
                                  onTap: () {
                                    if (selectedType != null) {
                                      Get.back(); // Close bottom sheet
                                      if (selectedType == "Device") {
                                        Get.to(() => AddDevice(),
                                            binding: AddDeviceBinding());
                                      } else {
                                        Get.to(() => AddTraktor(),
                                            binding: AddTraktorBinding());
                                      }
                                    } else {
                                      Get.snackbar("Error",
                                          "Please select an option first");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Icon(
                    Icons.add_circle_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
