import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/presentation/components/tractor_textfeild.dart';
import 'package:tanod_tractor/presentation/pages/add/traktor/controller/add_traktor_controller.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_constants.dart';
import '../../../components/tractor_appbar.dart';
import '../../../components/tractor_button.dart';
import '../../../components/tractor_text.dart';

class AddTraktor extends GetView<AddTraktorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: "Add Tractor",
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TractorText(
                      text: "Traktor Info",
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
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.driverId,
                  hint: "Driver ID",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.deviceId,
                  hint: "Device ID",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.groupId,
                  hint: "Group ID",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.imei,
                  hint: "IMEI",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.noPlate,
                  hint: "No Plate",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.idNo,
                  hint: "ID Number",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.engineNo,
                  hint: "Engine Number",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.fuelConsumption,
                  hint: "Fuel Consumption",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.brand,
                  hint: "Brand",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.model,
                  hint: "Model",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.manufactureDate,
                  hint: "Manufacture Date",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.installationTime,
                  hint: "Installation Time",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.installationAddress,
                  hint: "Installation Address",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.maxSpeed,
                  hint: "Max Speed",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.maintenanceKilometer,
                  hint: "Maintenance Kilometer",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.firstMaintenanceHr,
                  hint: "First Maintenance Hour",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.runningKm,
                  hint: "Running KM",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.totalDistance,
                  hint: "Total Distance",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.chasisNo,
                  hint: "Chasis Number",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.insuranceEffectDate,
                  hint: "Insurance Effect Date",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.insuranceExpireDate,
                  hint: "Insurance Expire Date",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.firstAlert,
                  hint: "First Alert",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.lastAlertHours,
                  hint: "Last Alert Hours",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.drDate,
                  hint: "DR Date",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.actualDeliveryDate,
                  hint: "Actual Delivery Date",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.drNo,
                  hint: "DR Number",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.frontLoaderSn,
                  hint: "Front Loader SN",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.rotaryTillerSn,
                  hint: "Rotary Tiller SN",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.rotatingDiscPlowSn,
                  hint: "Rotating Disc Plow SN",
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.stateId,
                  hint: "State ID",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                TractorTextfeild(
                  controller: controller.typeId,
                  hint: "Type ID",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 25.h),
                TractorButton(
                  onTap: () async {
                    await controller.addTractor();
                  },
                  text: "Add Device",
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
