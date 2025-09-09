import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:tanod_tractor/app/util/export_file.dart';
import 'package:tanod_tractor/data/models/farmers_model.dart';
import 'package:tanod_tractor/presentation/components/tractor_dropdown.dart';
import 'package:tanod_tractor/presentation/pages/common_modules/fca/models/tractor_listing_model.dart';

import '../../../../../data/models/devices_list_model.dart';
import '../controller/FCAController.dart';
import '../../../../../app/util/export_file.dart';




class FCAView extends GetView<FCAController> {
  FCAView({super.key}) { }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: TractorBackArrowBar(
        actions: [
          SizedBox(width:10.w,),

          Bounce(
            duration: const Duration(milliseconds: 180),
            onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Text(
                              "Tag FCA",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            // Search Recipient
                            TractorText(
                            text: "FCA/Recipient",
                            fontSize: 10.sp,
                            ),
                            TractorDropdown<Farmer>(
                              hint: "Search Recipient",
                              items: controller.farmerList,
                              displayItem: (item) => item.name,
                              onChanged: (selectedFarmer) {
                                controller.fcaID = selectedFarmer!.id;

                              },
                              validator: (value) => value == null ? "Recipient is required" : null,
                            ),
                            SizedBox(height: 16),

                            // Search Device IMEI
                            TractorText(
                              text: "Device",
                               fontSize: 10.sp,
                            ),
                            TractorDropdown<Device>(
                              hint: "Search IMEI No.",
                              items: controller.deviceList,
                              displayItem: (item) => item.imeiNo,
                              onChanged: (selectedDevice) {
                                controller.deviceID = selectedDevice!.id;
                    
                              },
                              validator: (value) => value == null ? "Device is required" : null,
                            ),
                            SizedBox(height: 16),

                            // Search Tractor
                            TractorText(
                              text: "Tractor",
                               fontSize: 10.sp,
                            ),
                            TractorDropdown<Tractor>(
                              hint: "Search Tractor",
                              items: controller.tractorList,
                              displayItem: (item) => item.tractorName,
                              onChanged: (selectedTractor) {
                                controller.tractorID = selectedTractor!.id;
                              },
                              validator: (value) => value == null ? "Tractor is required" : null,
                            ),
                            SizedBox(height: 20),

                            TractorButton(
                              fontSize: 16,
                              onTap: () async {
                                 if (_formKey.currentState!.validate()) {
                                    await controller.tagFCA();
                                    Get.back(); 
                                  }
                              },
                              text: "Submit",
                            ),
    ],)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            child: CircleAvatar(
              radius: 15.r,
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.add,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
        firstLabel: 'FCA Tagging',
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Show circular loader while fetching data
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.recipients.isEmpty) {
          return Center(child: noDataFoundWidget());
        }

        return ListView.separated(
          padding: EdgeInsets.all(12),
          itemCount: controller.recipients.length,
          separatorBuilder: (_, __) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = controller.recipients[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    item.userName[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.edit, size: 18, color: Colors.blueAccent),
                    //   onPressed: () {
                    //     // TODO: handle edit action
                    //     // controller.editRecipient(item);
                    //   },
                    // ),
                  ],
                ),
                                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.map, size: 16, color: Colors.blueGrey),
                                  SizedBox(width: 6),
                                  Text(
                                    "Area: ${item.groupName}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.agriculture, size: 16, color: Colors.green),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "Tractor: ${item.tractorName}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 16), // space between two columns

                        // Right Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.memory, size: 16, color: Colors.deepPurple),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      "Device: ${item.deviceName}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade800,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: 16, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text(
                                    item.dateTagged,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


                isThreeLine: true,
              ),
            );
          },
        );
      }),
    );
  }
}