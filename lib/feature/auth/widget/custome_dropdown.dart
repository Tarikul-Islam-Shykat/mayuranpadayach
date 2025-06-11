import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../core/const/app_colors.dart';
import '../../../core/style/global_text_style.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key,
    required this.items,
    required this.selectedItem,
    required this.label,
  });
  final List<String> items;
  final RxString selectedItem;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
      style: GoogleFonts.poppins(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      ),
      value: selectedItem.value.isEmpty ? null : selectedItem.value,
      items: items
          .map((item) =>
          DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        selectedItem.value = value!;
      },

      decoration: InputDecoration(
        fillColor: AppColors.fillColor,
        filled: true,
        hintText: label,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
      ),
    ));
  }
}
