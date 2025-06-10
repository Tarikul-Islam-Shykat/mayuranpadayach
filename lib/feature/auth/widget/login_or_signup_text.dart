import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';

Widget loginOrSignupText({
  required String title,
  required String pageName,
  required VoidCallback onTap,
}) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: RichText(
          text: TextSpan(
              text: title,
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor),
              children: [
            TextSpan(
                text: pageName,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.deepPurple))
          ])),
    ),
  );
}
