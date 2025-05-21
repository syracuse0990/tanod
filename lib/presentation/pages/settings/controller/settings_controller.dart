import 'package:get/get.dart';
import 'package:tanod_tractor/presentation/pages/base/base_controller.dart';

import '../../../../app/util/app_assets.dart';
import '../../profile/controller/setting_tile_model.dart';

class SettingController extends GetxController with BaseController {
  List<SettingTileModel> settingsTiles = [
    SettingTileModel(
        icon: AppSvgAssets.map, title: 'Map', description: 'Google Map'),
    SettingTileModel(
        icon: AppSvgAssets.language,
        title: 'Language',
        description: 'Farmer...'),
    SettingTileModel(
        icon: AppSvgAssets.country,
        title: 'Country/Region',
        description: 'English | US'),
    SettingTileModel(
        icon: AppSvgAssets.unitDistance,
        title: 'Unit of Distance',
        description: '2027-02-028'),
    SettingTileModel(
        icon: AppSvgAssets.clearcache, title: 'Clear Cache', description: ''),
    SettingTileModel(
        icon: AppSvgAssets.versions, title: 'Version', description: 'Off'),
    SettingTileModel(
        icon: AppSvgAssets.locationTime,
        title: 'Location Time',
        description: '2023-10-18 04:50:20'),
    SettingTileModel(icon: AppSvgAssets.share, title: 'Share', description: ''),
  ];
}
