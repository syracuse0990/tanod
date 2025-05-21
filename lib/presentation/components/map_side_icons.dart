import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/config/app_colors.dart';
import '../../app/util/app_assets.dart';
import 'add_space.dart';

class MapSideIcons extends StatelessWidget {
  final VoidCallback? onAdd;
  final VoidCallback? onLayer;
  final VoidCallback? onMenu;
  final VoidCallback? onSwap;
  final VoidCallback? onLocation;
  final VoidCallback? onTractorGroup;

  const MapSideIcons({
    super.key,
    this.onAdd,
    this.onLayer,
    this.onMenu,
    this.onSwap,
    this.onLocation,
    this.onTractorGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onAdd ?? () {},
        child: CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.white,
            child: SvgPicture.asset(
              AppSvgAssets.add,
              height: 25.h,
            )),
      ),
      AddSpace.vertical(20.h),
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onLayer ?? () {},
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(
            AppSvgAssets.layer,
            height: 18.h,
          ),
        ),
      ),
      AddSpace.vertical(20.h),
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onLocation ?? () {},
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(
            AppSvgAssets.location,
            height: 18.h,
          ),
        ),
      ),
      AddSpace.vertical(20.h),
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onMenu ?? () {},
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(
            AppSvgAssets.menu,
            height: 22.h,
          ),
        ),
      ),
      AddSpace.vertical(20.h),
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onSwap ?? () {},
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(
            AppSvgAssets.swap,
            height: 18.h,
          ),
        ),
      ),
      AddSpace.vertical(20.h),
      Bounce(
        duration: const Duration(milliseconds: 180),
        onPressed: onTractorGroup ?? () {},
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.white,
          child: SvgPicture.asset(
            AppSvgAssets.adjust,
            height: 18.h,
          ),
        ),
      ),
    ]);
  }
}
