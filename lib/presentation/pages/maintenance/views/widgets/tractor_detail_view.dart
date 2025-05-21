import '../../../../../app/util/export_file.dart';

class TractorDetailView extends StatelessWidget {
  TractorModel? tractorModel;
  TractorDetailView({this.tractorModel,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        rowTitleWidget(
            title: AppStrings.numberPlate ?? "",
            value: tractorModel?.noPlate.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.idNumber ?? "",
            value: tractorModel?.idNo.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.fuelPerKm ?? "",
            value: tractorModel?.fuelConsumption.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.tractorBrand ?? "",
            value: tractorModel?.brand.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.tractorModel ?? "",
            value: tractorModel?.model.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.installationTime ?? "",
            value: tractorModel?.installationTime.toString()??""),
        SizedBox(
          height: 5.h,
        ),
        rowTitleWidget(
            title: AppStrings.installationAddress ?? "",
            value: tractorModel?.installationAddress.toString()??""),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

}
