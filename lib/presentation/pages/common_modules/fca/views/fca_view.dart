import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../controller/FCAController.dart';
import '../../../../../app/util/export_file.dart';




class FCAView extends GetView<FCAController> {
  FCAView({super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadRecipients(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        actions: [],
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
                    item.recipient[0].toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Row(
  children: [
    Expanded(
      child: Text(
        item.recipient,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    IconButton(
      icon: Icon(Icons.edit, size: 18, color: Colors.blueAccent),
      onPressed: () {
        // TODO: handle edit action
        // controller.editRecipient(item);
      },
    ),
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
                    "Area: ${item.group}",
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
                      "Tractor: ${item.tractor}",
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
                      "Device: ${item.device}",
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