import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
Widget profileListTile(
    final String image,
    final String name,
    final VoidCallback onTap,
    ){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0,),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.shade200
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(image)),
              ),
              SizedBox(width: 10.w,),
              Text(name,style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.textBlackColor,
              ),),
            ],
          ),
          Icon(Icons.arrow_forward_ios,size:20.sp,color: AppColors.textBlackColor,),


        ],
      ),
    ),
  );
}