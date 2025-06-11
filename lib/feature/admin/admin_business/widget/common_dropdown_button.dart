import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/const/app_colors.dart';
class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String label;
  final void Function(T?)? onChanged;
  final bool enabled;
  final String Function(T)? itemAsString;

  const CommonDropdown({
    required this.items,
    required this.selectedItem,
    required this.label,
    this.onChanged,
    this.itemAsString,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      style:  GoogleFonts.poppins(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      value: selectedItem,
      onChanged: enabled ? onChanged : null,
      items: items.map((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(itemAsString != null ? itemAsString!(value) : value.toString()),
        );
      }).toList(),
      decoration: InputDecoration(
        fillColor: AppColors.fillColor.withValues(alpha:.1),
        filled: true,
        hintText: label,
        hintStyle: GoogleFonts.poppins(
          color:  AppColors.hintTextColor.withValues(alpha: 0.5),
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
      ),
    );
  }
}