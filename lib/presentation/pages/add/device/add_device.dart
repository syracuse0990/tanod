import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/devices_list_model.dart';
import 'package:tanod_tractor/presentation/components/tractor_dropdown.dart';
import 'package:tanod_tractor/presentation/components/tractor_textfeild.dart';
import 'package:tanod_tractor/presentation/pages/add/device/controller/add_device_controller.dart';

class AddDevice extends GetView<AddDeviceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: "Add Device",
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TractorText(
                    text: "Device Info",
                    fontSize: 20.sp,
                  ),
                  SizedBox(width: 15.w), // spacing between text and line
                  Expanded(
                    child: Container(
                      height: 2.h, // thin horizontal line
                      color: AppColors.primary, // your line color
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              
             TractorDropdown<Device>(
                hint: "Search IMEI No.",
                items: controller.deviceList, // Pass the observable list directly
                displayItem: (item) => item.imeiNo,
                onChanged: (selectedDevice) {
                  controller.imei = selectedDevice?.imeiNo;
                  // Optionally, auto-fill other fields
                  if (selectedDevice != null) {
                    controller.deviceModal.text = selectedDevice.deviceModal ?? '';
                    controller.deviceName.text = selectedDevice.deviceName;
                    // ... other fields ...
                  }
                },
              ),
           
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.deviceModal,
                hint: "Device Model",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.deviceName,
                hint: "Device Name",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.salesTime,
                hint: "Sales Time",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.subscriptionExpiration,
                hint: "Subscription Expiration",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.mcType,
                hint: "MC Type",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.mcTypeScope,
                hint: "MC Type Scope",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.sim,
                hint: "SIM No.",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.simIccid,
                hint: "SIM ICCID",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.simRegistration,
                hint: "SIM Registration",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.mobileDataLoad,
                hint: "Mobile Data Load",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.activationTime,
                hint: "Activation Time",
              ),
              SizedBox(
                height: 16.h,
              ),
              TractorTextfeild(
                controller: controller.remark,
                hint: "Remark",
              ),
              SizedBox(
                height: 26.h,
              ),
              TractorButton(
                onTap: () async {
                  await controller.addDevice();
                },
                text: "Add Device",
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Product {
  final String id;
  final String name;
  final double price;
  
  Product(this.id, this.name, this.price);
}
