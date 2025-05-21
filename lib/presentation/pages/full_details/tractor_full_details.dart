import 'package:carousel_slider/carousel_slider.dart';
import 'package:tanod_tractor/presentation/pages/full_details/common_controller.dart';

import '../../../app/util/dialog_helper.dart';
import '../../../app/util/export_file.dart';
import '../../router/route_page_strings.dart';

class TractorFullDetails extends GetView<CommonController> {
  TractorModel? tractorModel;

  TractorFullDetails({this.tractorModel, super.key}) {

    Future.delayed(Duration(milliseconds: 600), () {

      controller.hitApiToGetDeviceDetails(tractorModel?.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.allDetails,
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
        child: Obx(() => Column(
          children: [
            controller.tractorModel.value != null &&
                controller.tractorModel.value ?.images != null &&
                controller.tractorModel.value ?.images?.length != 0
                ? _allImageWidget
                : loadingContainer,
            SizedBox(
              height: 15.h,
            ),
            detailWidget,
          ],
        )),
      ),
    );
  }


  Widget get loadingContainer=> Container(
    width: Get.width,
      height: Get.height * 0.3,
    margin: EdgeInsets.all(3.r),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.primary,width: 0.3.h)
    ),
    child: noDataFoundWidget(msg: AppStrings.noImages),


  );

  Widget get _allImageWidget => CarouselSlider(
          items: [
            for (int i = 0; i < controller.tractorModel.value !.images!.length; i++)
              Container(
                width: Get.width,
                margin: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.primary,width: 0.3.h)
                ),
                child: Image.network(
                  '${APIEndpoint.imageUrl}${controller.tractorModel.value !.images![i].path}',
                  height: Get.height * 0.3,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppPngAssets.noImageFound,
                      height: Get.height * 0.3,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              )
          ],
          options: CarouselOptions(
            height: Get.height * 0.3,
            aspectRatio: 16 / 12,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
             enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {},
            scrollDirection: Axis.horizontal,
          ));

  Widget get detailWidget => Container(
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.all(3.r),
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey.withOpacity(0.3), width: 0.9.w),
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          children: [
            itemViewWidget(
                title: AppStrings.numberPlate,
                value: controller.tractorModel.value ?.noPlate?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.idNumber,
                value: controller.tractorModel.value ?.idNo?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.engineNumber,
                value: controller.tractorModel.value ?.engineNo?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.fuelPerKm,
                value: controller.tractorModel.value ?.fuelConsumption?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.tractorBrand,
                value: controller.tractorModel.value ?.brand?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.maintenanceKilometer,
                value: '${controller.tractorModel.value ?.maintenanceKilometer?.toString() ?? "0"} Km'),

            itemViewWidget(
                title: AppStrings.totalKilometer,
                value: '${controller.tractorModel.value ?.totaldistance?.toString() ?? "0"} Km'),
            itemViewWidget(
                title: AppStrings.tractorModel,
                value: controller.tractorModel.value ?.model?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.manuFactureDate,
                value: controller.tractorModel.value ?.manufactureDate?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.installationTime,
                value: controller.tractorModel.value ?.installationTime?.toString() ?? ""),
            itemViewWidget(
                title: AppStrings.installationAddress,
                value: controller.tractorModel.value ?.installationAddress?.toString() ?? ""),
            box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole

                ? itemViewWidget(title: AppStrings.createdBy, value: "Admin")
                : SizedBox(),
            box.read(roleType) == APIEndpoint.aminRole|| box.read(roleType) == APIEndpoint.subAdminRole

                ? Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: underLineTextWidget(
                        onTab: () {
                          Get.toNamed(RoutePage.adminBookingView,
                              arguments: {'id': controller.tractorModel.value ?.id,"hideCalender":false});
                        },
                        txt: AppStrings.viewBookingDetails),
                  )
                : SizedBox()
          ],
        ),
      );

  itemViewWidget({title, value}) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Text(
            title ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 13.sp),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }
}
