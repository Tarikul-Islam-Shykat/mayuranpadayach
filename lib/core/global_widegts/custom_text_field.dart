import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../const/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hitText,
    required this.textEditingController,
    this.fontSize,
    this.fontWeight,
    this.lineHeight, this.suffixIcon,
  });
  final String? hitText;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width:Get.width,
      child: TextField(
        controller: textEditingController,
        style: GoogleFonts.poppins(
            fontSize: fontSize ?? 16.sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            height: lineHeight ?? 24.h / 16.h,
            color: AppColors.grayColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon:suffixIcon ,
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          hintText: hitText,
          hintStyle: GoogleFonts.poppins(
              fontSize: fontSize ?? 16.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
              height: lineHeight ?? 24.h / 16.h,
              color: AppColors.grayColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:BorderSide.none,
          ),
        ),
      ),
    );
  }
}
