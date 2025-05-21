import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base/base_controller.dart';

enum CameraState { loading, loaded, error }

class CameraControllerG extends GetxController with BaseController {
  late CameraController cameraC;
  late List<CameraDescription> cameras;

  var isGallery = false.obs;
  var cameraState = CameraState.loading.obs;
  //camera page

  var farmImagePath = List.filled(2, '', growable: false);
  //GeoTagging
  late Position pos;
  var currentAddress = Address().obs;
  var formattedDate = ''.obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   // getLocation();
  // }

  @override
  void onInit() async {
    super.onInit();
    pos = Get.arguments;
    await checkStoragePermission();

    cameras = await availableCameras();
    updateCamera();
  }

  int count = 0;
  getLocation() async {
    try {
      DateTime now = DateTime.now();
      formattedDate.value =
          DateFormat('EEE, MMM d, ' 'yyyy – HH:mm').format(now);
      showLoading();
      currentAddress.value = await GeoCode()
          //34.42333, 74.03857

          .reverseGeocoding(latitude: pos.latitude, longitude: pos.longitude);
      if (currentAddress.value.timezone!.contains('Throttled!') && count <= 5) {
        count++;
        getLocation();
      }
      if (!currentAddress.value.timezone!.contains('Throttled!')) {
        count = 0;
      }
      print(currentAddress.value);

      hideLoading();
    } catch (e) {
      print(e);
      hideLoading();
    }
  }

  Future<void> updateCamera({id = 1}) async {
    showLoading();
    cameraState.value = CameraState.loading;
    if (cameras.length < 2) {
      id = 0;
    }
    cameraC = CameraController(
      cameras[id],
      ResolutionPreset.max,
      enableAudio: false,
    );
    await cameraC.initialize().then((_) {
      cameraState.value = CameraState.loaded;
      print('dafasdfasdf${cameraState.value}');
      hideLoading();
      // if (!mounted) {
      //   return;
      // }
      // setState(() {});
      // cameraC.resumePreview();
      // cameraC.buildPreview();
    }).catchError((Object e) {
      cameraState.value = CameraState.error;
      hideLoading();
      handleError(e, () {});
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            handleError('Camera Access Denied', () {});
            break;
          default:
            handleError(
                'Something Went Wrong!!\n Please Check Camera Permission.',
                () {});
            break;
        }
      }
    });
  }

  //Permission checker
  Future<void> checkStoragePermission() async {
    var permission = await Permission.photos.request().isGranted;

    ///TODO : SetUp for IOS Permission is pending

    // check android api level

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (int.parse(androidInfo.version.release) >= 13) {
      permission = await Permission.photos.request().isGranted;
    } else {
      permission = await Permission.storage.request().isGranted;
    }
    // if true
    if (permission) {
      print('permission Granted Succesfully');
      //do somthing
    } else {
      if (int.parse(androidInfo.version.release) >= 13) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
        ].request();
        if (statuses[Permission.photos.isPermanentlyDenied] == null) {
          print('photos');
          openAppSettings();
        }
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
        if (statuses[Permission.storage.isPermanentlyDenied] == null) {
          print('storage');
          openAppSettings();
        }
      }
    }
  }

  Future<String> pickFile() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

      if (pickedFile != null) {
        if (pickedFile.path.contains('.gif')) {
          Future.delayed(const Duration(milliseconds: 200), () {
            handleError('Gif files not supported', () {});
          });

          return '';
        } else {
          return pickedFile.path;
        }
      }
    } catch (e) {
      hideLoading();
      debugPrint('no image selected$e');
    }
    return pickedFile == null ? '' : pickedFile.path;
  }
}
