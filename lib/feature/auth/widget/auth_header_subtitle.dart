import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';


Widget authHeaderSubtitle(
    final String text,
    {
    double width = 365,
    }){
  return SizedBox(
    width:width.w,
    child: Text(text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.authHeaderSubtitleColor.withValues(alpha: .3)

      ),),
  );
}
