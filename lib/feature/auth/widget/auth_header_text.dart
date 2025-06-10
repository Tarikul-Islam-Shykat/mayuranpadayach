import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';


Widget authHeaderText(final String text){
  return Text(text,style: GoogleFonts.manrope(
    fontWeight: FontWeight.w800,
    fontSize: 20.sp,
    color: AppColors.blackColor,
  ),);
}