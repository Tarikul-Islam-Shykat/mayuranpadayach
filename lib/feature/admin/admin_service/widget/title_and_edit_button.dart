import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/const/app_colors.dart';

class TitleAndEditButton extends StatelessWidget {
  const TitleAndEditButton({
    super.key, required this.title, required this.buttonName, required this.onTab,
  });
  final String title;
  final String buttonName;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
         title,
          style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlackColor),
        ),
        InkWell(
          onTap: onTab,
          child: Text(
            buttonName,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: Colors.purple),
          ),
        ),
      ],
    );
  }
}