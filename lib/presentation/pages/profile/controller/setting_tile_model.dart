class SettingTileModel {
  final String icon;
  final String title;
  final String? description;
  final bool? isIcon;
  final Function? onTab;



  SettingTileModel({required this.icon, required this.title, this.description,this
  .isIcon,this.onTab});
}
