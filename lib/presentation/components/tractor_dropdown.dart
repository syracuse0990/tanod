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
  final String? Function(T?)? validator; // 👈 Add validator

  const TractorDropdown({
    super.key,
    this.hint,
    this.height,
    required this.items,
    this.displayItem,
    this.value,
    this.onChanged,
    this.isEnabled = true,
    this.validator, // 👈
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator, // 👈 Hook validator
      initialValue: value,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height ?? 48.h,
              child: Autocomplete<T>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  final List<T> filteredItems = List<T>.from(items);

                  if (textEditingValue.text.isEmpty) {
                    return filteredItems;
                  }
                  return filteredItems.where((T item) {
                    final displayValue = displayItem != null
                        ? displayItem!(item)
                        : item.toString();
                    return displayValue
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                displayStringForOption: (T option) =>
                    displayItem != null ? displayItem!(option) : option.toString(),
                fieldViewBuilder: (context, textEditingController, focusNode, _) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    enabled: isEnabled,
                    decoration: InputDecoration(
                      hintText: hint,
                      errorText: state.errorText, // 👈 show error message
                    ),
                  );
                },
                onSelected: (selected) {
                  state.didChange(selected); // 👈 updates form state
                  if (onChanged != null) onChanged!(selected);
                },
                initialValue: value != null
                    ? TextEditingValue(
                        text: displayItem != null
                            ? displayItem!(value!)
                            : value.toString(),
                      )
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
