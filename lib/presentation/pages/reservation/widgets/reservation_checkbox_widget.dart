import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanod_tractor/app/config/app_colors.dart';
import 'package:tanod_tractor/presentation/components/add_space.dart';
import 'package:tanod_tractor/presentation/components/tractor_text.dart';

class ReservationCheckBoxWidget extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?)? onChanged;

  const ReservationCheckBoxWidget({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColors.primary),
          child: value == true
              ? Icon(
                  Icons.done,
                  color: AppColors.white,
                  size: 20.r,
                )
              : SizedBox(
                  height: 20.w,
                  width: 20.w,
                ),
        ),
        AddSpace.horizontal(8.w),
        TractorText(
          textAlign: TextAlign.center,
          text: label,
          fontSize: 17.sp,
        ),
      ],
    );
  }
}
