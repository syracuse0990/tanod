



// ignore: must_be_immutable
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'custom_picker.dart';
import 'export_file.dart';

class MediaSelectDialog extends StatelessWidget {
  Function(File)? selectedImage;
  String? dialogTitle;

  MediaSelectDialog(
      {Key? key, this.selectedImage, this.dialogTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.selectProfilePicture,
           style: TextStyle(
               fontWeight: FontWeight.w700,
               fontSize: 18.sp
           ),
          ),
          SizedBox(height: 30.h),
          GestureDetector(
            onTap: () async {
              var status = await Permission.camera.request();
              if (status.isDenied) {
                showToast(message: AppStrings.grantCameraPermission);
              } else {
                Get.back();
                var result = await CustomImagePicker.cameraImage();
                if (result.path.isNotEmpty) {
                  selectedImage!(result);
                }
              }
            },
            child:  Text(
              AppStrings.takePhoto,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 0.3.w,
            color: Colors.black,
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () async {
              if (Platform.isAndroid) {
                var androidInfo = await DeviceInfoPlugin().androidInfo;
                if(androidInfo!=null){

                  if(androidInfo.version.sdkInt<=32){
                    var status = await Permission.storage.request();
                    if (status.isDenied) {
                      showToast(message: AppStrings.grantGalleryPermission);
                    } else {
                      Get.back();
                      var result = await CustomImagePicker.galleryImage();
                      if (result.path.isNotEmpty) {
                        selectedImage!(result);
                      }
                    }
                  }else{
                    var status = await Permission.photos.request();
                    if (status.isDenied) {
                      showToast(message: AppStrings.grantGalleryPermission);
                    } else {
                      Get.back();
                      var result = await CustomImagePicker.galleryImage();
                      if (result.path.isNotEmpty) {
                        selectedImage!(result);
                      }
                    }
                  }
                }



              }else{
                var status = await Permission.photos.request();
                if (status.isDenied) {
                  showToast(message: AppStrings.grantGalleryPermission);
                } else {
                  Get.back();
                  var result = await CustomImagePicker.galleryImage();
                  if (result.path.isNotEmpty) {
                    selectedImage!(result);
                  }
                }
              }
            },
            child : Text(
              AppStrings.chooseFromGallery,
              style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: 16.sp,),
            ),
          ),
          SizedBox(height: 10.h),


        ],
      ),
    );
  }
}
