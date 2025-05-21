import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/user_management/views/user_management_tile_view.dart';
import 'package:tanod_tractor/presentation/pages/list/tractor_groups_page.dart';

import '../../../../../app/util/export_file.dart';
import '../controller/user_management_controller.dart';

//
class UserManagementView extends StatelessWidget {

  final controller = Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.userManagement,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        actions: [
          importWidget((){}),
          SizedBox(width: 10.w,),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              controller.hitApiToExportFeedbackReports();
            },
            child: Image.asset(
              AppPngAssets.exportImage,
              height: 35.h,
              width: 35.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),

          Expanded(child: TractorGroupsPage()),

          // Obx(() => Expanded(
          //       child: controller.userList?.length != 0
          //           ? ListView.builder(
          //               controller: controller.userController,
          //               itemCount: controller.userList?.value.length ?? 0,
          //               shrinkWrap: true,
          //               itemBuilder: (context, index) {
          //                 return
          //
          //
          //                   UserManagementTileView(
          //                   index:index ,
          //                   userDataModel: controller.userList![index],
          //                 );
          //               })
          //           : noDataFoundWidget(),
          //     ))
        ],
      ),

      // bottomNavigationBar: Obx(()=> controller.isDownloading.isTrue?
      // LinearProgressIndicator(
      //     minHeight: 6.0,
      //     valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      //
      //     value: double.parse(controller.fileProgress.value) ).paddingOnly(bottom: 15.0,left: 15.0,right: 15.0):SizedBox()),

    );
  }



  Widget importWidget(Function? onTab){
    return GestureDetector(
        onTap: (){
          showCustomDialog(Get.context!);
        },
        child: Icon(Icons.import_export,color: Colors.white,size: 30.sp,));
  }


  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing when tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Import Data",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600),),
              SizedBox(width: 10.w,),

              GestureDetector(
                  onTap: (){
                    controller.downloadImportFile();
                  },

                  child: Icon(Icons.info,size: 25.sp,color: Colors.black,)),

              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.close,size: 25.sp,color: Colors.black,)),
            ],
          ),
          content: Obx(()=>
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose File:",style: TextStyle(fontSize: 18.0,color: Colors.black),),
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap: (){
                  controller.pickFile();
                },
                child: Container(
              padding: EdgeInsets.all(15.0),
                  width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(width: 1.w,color: Colors.black) ),

                  child:  Center(child: Text(
                    controller.filePath.isEmpty ?
                    "No file chosen": controller.filePath.value,
                    style: TextStyle(fontSize: 16.0,color: Colors.black),)),

                ),
              )

            ],
          ),),
          actions: [
            TextButton(
              onPressed: () {
                if(controller.filePath.isNotEmpty){
                  controller.uploadImportFile();
                }else{
                  showToast(message: "Please select file");
                }
              },
              child: Container(
                  height: 40.h,

                  decoration: BoxDecoration(borderRadius:
                  BorderRadius.circular(10.r),
                      color: Colors.green ),

                  child: Center(child: Text("Upload",style: TextStyle(color: Colors.white,fontSize: 16.sp),))),
            ),
          ],
        );
      },);}


}
