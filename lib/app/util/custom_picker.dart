import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static Future<File> cameraImage() {
    return ImagePicker()
        .pickImage(source: ImageSource.camera)
        .then((value) async {
      if (value != null) {
        return await cropImage(imageFile: File(value.path));
      } else {
        return File("");
      }
    });
  }

  static Future<File> galleryImage() {
    return ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) async {
      if (value != null) {
        return await cropImage(imageFile: File(value.path));
      } else {
        return File("");
      }
    });
  }




  static Future<File> cropImage({File? imageFile}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 40,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings: [
        AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );

    return File(croppedFile?.path ?? "");
  }
}
