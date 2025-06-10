import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';



Widget textFieldTitle({required String text}){
  return Row(
    children: [
      Text(text,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16.sp,color: AppColors.blackColor),),
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Colors.purple, Colors.deepPurpleAccent],
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(
          "*",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}