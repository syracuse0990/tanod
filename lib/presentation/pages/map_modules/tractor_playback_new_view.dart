import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:tanod_tractor/presentation/pages/map_modules/poly_map_view.dart';

import '../../../app/util/export_file.dart';
import '../../../data/models/filter_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';
import 'filter_type_view.dart';

class TractorPlaybackNewView extends StatefulWidget {
  const TractorPlaybackNewView({super.key});

  @override
  State<TractorPlaybackNewView> createState() => _TractorPlaybackNewViewState();
}

class _TractorPlaybackNewViewState extends State<TractorPlaybackNewView> {
  RxString selectDevice = "Select Device".obs;
  DevicesModel ? selectedDeviceModel;
  String selectType = AppStrings.last3Days;
  String dateRange = AppStrings.dateRange;
  List<DateTime?> dateList = [];
  FilterModel? selectedFilterType;
  List<FilterModel> filterList = [
    FilterModel(title: AppStrings.custom, value: 8, isSelected: false),
    FilterModel(title: AppStrings.today, value: 1, isSelected: false),
    FilterModel(title: AppStrings.yesterday, value: 2, isSelected: false),
    FilterModel(title: AppStrings.last3Days, value: 3, isSelected: true),
    FilterModel(title: AppStrings.thisWeek, value: 4, isSelected: false),
    FilterModel(title: AppStrings.lastWeek, value: 5, isSelected: false),
    FilterModel(title: AppStrings.thisMonth, value: 6, isSelected: false),
    FilterModel(title: AppStrings.lastMonth, value: 7, isSelected: false),
  ];

  IMapRepository? iMapRepository;

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iMapRepository = Get.put(RemoteIMapProvider());
      selectedDefaultDays();

    });
    super.initState();
  }

  selectedDefaultDays(){
    selectedFilterType=filterList[3];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.tracks,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CommonTractorTileView(
                title: selectDevice.value,
                onTab: () async {
                  if (!Get.isRegistered<ReservationController>()) {
                    Get.lazyPut(() => ReservationController());
                  }
                  DevicesModel? deviceModel =
                      await Get.to(DeviceView(maps: {"allData": 1}));
                  if (deviceModel != null) {
                    selectedDeviceModel=deviceModel;
                    selectDevice.value = deviceModel.deviceName ?? "";
                    setState(() {});
                  }
                }),
            SizedBox(
              height: 20.h,
            ),
            CommonTractorTileView(
                title: selectType,
                onTab: () async {
                  if (!Get.isRegistered<ReservationController>()) {
                    Get.lazyPut(() => ReservationController());
                  }
                  FilterModel? filterModel = await Get.to(FilterTypeScreen(
                    filterList: filterList,
                  ));
                  if (filterModel != null) {
                    selectedFilterType = filterModel;
                    dateList.clear();
                    selectType = filterModel.title ?? "";
                    setState(() {});
                  }
                }),
            SizedBox(
              height: 20.h,
            ),
            selectedFilterType != null && selectedFilterType?.value == 8
                ? CommonTractorTileView(
                    title: dateRange,
                    showArrow: false,
                  )
                : SizedBox(),
            selectedFilterType != null && selectedFilterType?.value == 8
                ? Container(
                    margin: EdgeInsets.only(top: 30.h, bottom: 40.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.7), width: 0.6)),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                          animateToDisplayedMonthDate: false),
                      value: dateList,
                      onValueChanged: (dates) {
                        print("check dates ${dates}");
                        dateList = dates;
                        if (dateList.length == 1) {
                          String date = DateFormat("yyyy-MM-dd").format(dateList.first ?? DateTime.now());
                          dateRange = '${date}';
                          print("check ${date}");
                        } else if (dateList.length == 2) {
                          String date1 = DateFormat("yyyy-MM-dd")
                              .format(dateList.first ?? DateTime.now());
                          String date2 = DateFormat("yyyy-MM-dd")
                              .format(dateList.last ?? DateTime.now());
                          dateRange = '${date1} - ${date2}';
                          setState(() {});
                        }

                        setState(() {});
                      },
                    ),
                  )
                : SizedBox(),
            TractorButton(
              text: AppStrings.save,
              onTap: (){
                if(selectDevice.value=="Select Device"){
                  showToast(message: AppStrings.selectDevice);
                  return;
                }else if(selectedFilterType?.value==8){
                  if(dateRange==AppStrings.dateRange){
                    showToast(message: AppStrings.pleaseSelectDateRange);
                    return;
                  }
                  hitApiToSaveTracks();
                  return;
                }else{
                  hitApiToSaveTracks();
                }
              },
            )
          ],
        ),
      ),
    );
  }



  hitApiToSaveTracks() {

    try {
      showLoading();
      Map<String, dynamic> map = {};
      map['id']=selectedDeviceModel?.id;
      map['period']=selectedFilterType?.value;
      map['date_range']=dateRange;
      iMapRepository?.saveDeviceTrack(map: map).then((value) {
        hideLoading();
        if (value.data != null) {
          Get.to(LocationMovingMarkerScreen(deviceId: selectedDeviceModel?.id,list:value.data ,));
        }else{
          showToast(message: "No data found");
        }
      });
    } catch (e) {
      hideLoading();
      print("cehck all exceptions ${e}");
    }
  }
}
