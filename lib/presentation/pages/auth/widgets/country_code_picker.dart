import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../app/util/export_file.dart';

class CountryCodePickerView extends StatelessWidget {
  Function(PhoneNumber)? onChanged;
  var controller;

  CountryCodePickerView({this.onChanged, this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      autofocus: false,

      controller: controller,
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: AppColors.primary,
        size: 22.sp,
      ),
      autovalidateMode: AutovalidateMode.disabled,
      flagsButtonPadding: EdgeInsets.only(left: 10.w),
      flagsButtonMargin: EdgeInsets.zero,

      dropdownIconPosition: IconPosition.trailing,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      showDropdownIcon: true,
      dropdownDecoration: BoxDecoration(
        //  color: greyColor,
        borderRadius: BorderRadius.all(Radius.circular(30.r)),
      ),
      //controller: textEditingController,
      initialCountryCode: PlatformDispatcher.instance.locale.countryCode ?? 'IN',
      decoration: InputDecoration(
        fillColor: AppColors.lightGray.withOpacity(0.1),
        filled: true,
        counterText: '',
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        isDense: true,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0.r)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0.r),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
      ),

      style: TextStyle(fontSize: 14.sp, color: AppColors.black),
      validator: (phn) {},

      onChanged: (phone) {
        onChanged!(phone);
      },
    );
  }
}
