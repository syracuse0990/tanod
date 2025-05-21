import 'package:flutter/scheduler.dart';
import 'package:tanod_tractor/presentation/pages/map_modules/playback_tile_view.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../../data/models/admin_booking_model.dart';
import '../../../data/repositories/map_provider/impl/remote_map_provider.dart';
import '../../../data/repositories/map_provider/interface/imap_repository.dart';
import 'poly_map_view.dart';
import 'custom_poly_map_screen.dart';

class PlayBackView extends StatefulWidget {
  String? deviceImei;

  PlayBackView({this.deviceImei, super.key});

  @override
  State<PlayBackView> createState() => _PlayBackViewState();
}

class _PlayBackViewState extends State<PlayBackView> {
  List<BookingModel>? bookingList = <BookingModel>[].obs;

  IMapRepository? iMapRepository;

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iMapRepository = Get.put(RemoteIMapProvider());
      hitApiToGetAllDeviceBasedBooking();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.playBack,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: bookingList?.length == 0
                ? noDataFoundWidget()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookingList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          // Get.to(PolyMapView(deviceId: bookingList![index].id,));
                           Get.to(LocationMovingMarkerScreen(deviceId: bookingList![index].id,));
                        },
                        child: PlayBackTileView(
                          bookingDetailModel: bookingList![index],
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }

  //here we will get all booking bases on the imei
  Future hitApiToGetAllDeviceBasedBooking() async {
    bookingList?.clear();
    DialogHelper.showLoading();
    await iMapRepository
        ?.getAllDeviceBasedList(map: {"imei": widget.deviceImei}).then((value) {
      DialogHelper.hideLoading();
      if (value != null && value.data != null) {
        bookingList?.addAll(value.data?.bookings ?? []);
      }
      setState(() {});
    }).onError((error, stackTrace) {
      DialogHelper.hideLoading();
      showToast(message: error?.toString());
    });
  }
}
