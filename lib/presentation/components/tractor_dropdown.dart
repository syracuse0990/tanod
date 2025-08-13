import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanod_tractor/app/util/export_file.dart';

import '../../app/config/app_colors.dart';

class TractorDropdown<T extends Object> extends StatelessWidget {
  final String? hint;
  final double? height;
  final List<T> items;
  final String Function(T)? displayItem;
  final T? value;
  final Function(T?)? onChanged;
  final bool isEnabled;

  const TractorDropdown({
    super.key,
    this.hint,
    this.height,
    required this.items,
    this.displayItem,
    this.value,
    this.onChanged,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      child: Autocomplete<T>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          // Create a local typed list to ensure type safety
          final List<T> filteredItems = List<T>.from(items);
          
          if (textEditingValue.text.isEmpty) {
            return filteredItems;
          }
          return filteredItems.where((T item) {
            final displayValue = displayItem != null ? displayItem!(item) : item.toString();
            return displayValue.toLowerCase().contains(textEditingValue.text.toLowerCase());
          });
        },
        displayStringForOption: (T option) => displayItem != null ? displayItem!(option) : option.toString(),
        fieldViewBuilder: (BuildContext context, 
            TextEditingController textEditingController, 
            FocusNode focusNode, 
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            enabled: isEnabled,
            decoration: InputDecoration(
              hintText: hint,
              focusedBorder: const UnderlineInputBorder(),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lightGray.withOpacity(0.5),
                height: 0.0,
                fontFamily: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                ).fontFamily,
              ),
            ),
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.primary,
              height: 1.0,
              fontFamily: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
              ).fontFamily,
            ),
          );
        },
        onSelected: onChanged,
        initialValue: value != null 
            ? TextEditingValue(text: displayItem != null ? displayItem!(value!) : value.toString())
            : null,
      ),
    );
  }
}