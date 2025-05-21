import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tanod_tractor/app/util/dialog_helper.dart';

import 'custom_picker.dart';
import 'export_file.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }
}

String generateFarmRandomID() {
  return 'TEMP${randdomInt(1000)}';
}

int randdomInt(int maximun, {int minimum = 0}) {
  return max(minimum, Random.secure().nextInt(maximun));
}

showToast({message}) {
  if (message.toString().trim().isEmpty) {
    return;
  }
  if (message.toString().toLowerCase().contains("dio")) {
    return;
  }
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.sp);
}



showLoading([String? message]) {
  DialogHelper.showLoading(message??"");
}

hideLoading() {
  DialogHelper.hideLoading();
}


cacheNetworkImage({url, height, width, fit}) {
   return CachedNetworkImage(
    imageUrl: url,
    fit: fit ?? BoxFit.fill,
    width: width,
    height: height,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 180.0.h,
      ),
    ),
    errorWidget: (context, url, error) => Image.asset(
      AppPngAssets.noImageFound,
      height: height,
      width: width,
      fit: fit ?? BoxFit.fill,
    ),
  );
}

noDataFoundWidget({msg}) {
  return Align(
      alignment: Alignment.center,
      child: Text(
        msg ?? AppStrings.noDataFound,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 15.sp, color: Colors.black),
      ));
}

showDateTimePicker(
    {BuildContext? context,
    String? title,
    bool pastDisabled = true,
    final Function(DateTime)? onChanged,
    bool? isEnabled = false}) async {
  final DateTime? picked = await showDatePicker(
      context: context!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: pastDisabled ? DateTime(1999) : DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary, // <-- SEE HERE
              onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                 // primary: AppColors.primary // button text color
                  ),
            ),
          ),
          child: child!,
        );
      },
      lastDate: isEnabled == true ? DateTime.now() : DateTime(2040));

  if (picked != null) {
    onChanged!(picked);
  }
}

Future<TimeOfDay?> showCustomTimePicker(BuildContext context) async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary, // <-- SEE HERE
            onPrimary: Colors.black, // <-- SEE HERE
            onSurface: Colors.black, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                //primary: AppColors.primary // button text color
                ),
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        ),
      );
    },
  );
  // ignore: use_build_context_synchronously
  // DateTime date = DateFormat.jm().parse(pickedTime!.format(context).toString());
  // return DateFormat("HH:mm").format(date).toString();
  return pickedTime;
}

int getStateIdBaseOnValues(text) {
  return text == AppStrings.inactive
      ? AppStrings.inactiveId
      : text == AppStrings.active
          ? AppStrings.activeId
          : AppStrings.deleteId;
}

String getStateTitle(text) {
  return text == AppStrings.inactiveId
      ? AppStrings.inactive
      : text == AppStrings.activeId
          ? AppStrings.active
          : AppStrings.delete;
}

String getBookingStateTitle(id) {
  return id == AppStrings.activeId
      ? AppStrings.active
      : id == AppStrings.acceptedId
          ? AppStrings.accepted
          : AppStrings.rejected;
}

int getAlertBasedId(title) {
  return title == AppStrings.accOn
      ? APIEndpoint.ACC_ON
      : title == AppStrings.accOFF
          ? APIEndpoint.ACC_OFF
          : title == AppStrings.geofenceIn
              ? APIEndpoint.GEOZONE_IN
              : APIEndpoint.GEOZONE_OUT;
}

String getIssueTypeTitle(id) {
  return id == APIEndpoint.stateActive
      ? AppStrings.active
      : id == APIEndpoint.stateCompleted
          ? AppStrings.completed
          : AppStrings.closed;
}

getIdBasedOnTitle(title) {
  return title == AppStrings.active
      ? APIEndpoint.stateActive
      : title == AppStrings.completed
          ? APIEndpoint.stateCompleted
          : APIEndpoint.stateClosed;
}

Widget calenderView({text}) {
  return Container(
    padding: EdgeInsets.all(8.r),
    child: Text(
      text??AppStrings.calenderView,
      style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w900,
          fontSize: 10.sp),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r), color: AppColors.white),
  );
}

Future getLocationFromLatLong({latitude, longitude}) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    if (placemarks.isNotEmpty) {
      return '${placemarks.first.locality},${placemarks.first.subAdministrativeArea}';
    }
  } catch (e) {
    showToast(message: e.toString());
  }
}

String getAllStateTitles(id) {
  return id == AppStrings.inactiveId
      ? AppStrings.inactive
      : id == AppStrings.activeId
          ? AppStrings.active
          : id == AppStrings.deleteId
              ? AppStrings.delete
              : id == AppStrings.acceptedId
                  ? AppStrings.accepted
                  : AppStrings.rejected;
}

rowTitleWidget({
  title,
  value,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 8.h),
    child: Row(
      children: [
        Expanded(
            child: TractorText(
          text: '$title:-' ?? "",
          fontSize: 14.sp,
          color: AppColors.lightblack,
          fontWeight: FontWeight.w700,
        )),
        Expanded(
            child: TractorText(
          text: value ?? "",
          fontSize: 13.sp,
          color: AppColors.lightblack,
          fontWeight: FontWeight.w500,
        )),
      ],
    ),
  );
}

conclusionTitleWidget({
  title,
  value,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      TractorText(
        text: '$title:-' ?? "",
        fontSize: 14.sp,
        color: AppColors.lightblack,
        fontWeight: FontWeight.w700,
      ),
      SizedBox(
        height: 5.h,
      ),
      TractorText(
        text: value ?? "",
        fontSize: 13.sp,
        color: AppColors.lightblack,
        fontWeight: FontWeight.w500,
      ),
    ],
  );
}

getMaintenanceTitles(id) {
  return id == APIEndpoint.stateDocumentation
      ? AppStrings.documentation
      : id == APIEndpoint.stateFilled
          ? AppStrings.filled
          : id == APIEndpoint.stateInProgress
              ? AppStrings.inProgress
              : id == APIEndpoint.statesCompleted
                  ? AppStrings.completed
                  : AppStrings.cancelled;
}

getMaintenanceId(text) {
  return text == AppStrings.documentation
      ? APIEndpoint.stateDocumentation
      : text == AppStrings.filled
          ? APIEndpoint.stateFilled
          : text == AppStrings.inProgress
              ? APIEndpoint.stateInProgress
              : text == AppStrings.completed
                  ? APIEndpoint.statesCompleted
                  : APIEndpoint.statesCancelled;
}

utcToLocal({dateUtc}) {
  if (dateUtc != null && dateUtc.toString().contains("T")) {
    dateUtc = dateUtc.toString().replaceAll("T", " ");

    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateUtc);
    DateTime localDateTime = dateTime.toLocal();
    return DateFormat("yyyy-MM-dd HH:mm").format(localDateTime);
  }
  return "";
}

getPagesTitle(id) {
  return id == APIEndpoint.privacyPolicy
      ? AppStrings.privacyPolicy
      : AppStrings.termsAndServices;
}

getPagesConstant(title) {
  return title == AppStrings.privacyPolicy
      ? APIEndpoint.privacyPolicy
      : APIEndpoint.termsAndCondition;
}

underLineTextWidget({txt, onTab}) {
  return GestureDetector(
    onTap: () {
      // ignore: unnecessary_statements
      if (onTab != null) {
        onTab!();
      }
    },
    child: Align(
      alignment: Alignment.bottomRight,
      child: Text(
        txt ?? AppStrings.viewOtherDetails,
        style: TextStyle(
          color: AppColors.primary,
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900)
              .fontFamily,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

Future<String?> findLocalPath() async {
  if (Platform.isAndroid) {
    return "/sdcard/download/Tanod";
  } else {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path + Platform.pathSeparator + 'Download';
  }
}

Future<void> prepareSaveDir() async {
  var localPath = (await findLocalPath())!;

  final savedDir = Directory(localPath);
  bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create();
  }
}

Widget exportWidget(Function? onTab) {
  return GestureDetector(
    onTap: () async {
      if (onTab != null) {
        if (Platform.isAndroid) {
          var androidInfo = await DeviceInfoPlugin().androidInfo;
          if(androidInfo!=null){

            if(androidInfo.version.sdkInt<=32){
              var status = await Permission.storage.request();
              if (status.isDenied) {
                showToast(message: AppStrings.grantGalleryPermission);
              }
            }else{
              var status = await Permission.photos.request();
              if (status.isDenied) {
                showToast(message: AppStrings.grantGalleryPermission);
              }
          }



        }else{
          var status = await Permission.photos.request();
          if (status.isDenied) {
            showToast(message: AppStrings.grantGalleryPermission);
          }
          }
        }
        onTab();
      }
      // controller.hitApiToExportFeedbackReports();
    },
    child: Image.asset(
      AppPngAssets.exportImage,
      height: 35.h,
      width: 35.w,
      fit: BoxFit.contain,
    ),
  );
}



String gmtToLocal(date) {
  print("cehck date for ${date}");
  if (date.toString().isNotEmpty && date != null) {
    DateTime dateTime = DateTime.parse(date).toUtc();
    return DateFormat("yyyy-MM-dd hh:mm a").format(dateTime.toLocal());
  }
  return "Invalid date";
}
