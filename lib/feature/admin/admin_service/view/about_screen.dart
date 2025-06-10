import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/route/route.dart';

import '../../../../core/const/app_colors.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../widget/title_and_edit_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: roundBackButton( () => Get.back()),
        ),
        title: Text(
          "About",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.textBlackColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            titleAndEditButton('Basic Info', 'Edit', ()=>Get.toNamed(AppRoute.serviceAboutDetailsScreen)),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              height: 220.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.fillColor,
              ),
              child: Text(
                "“ Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna "
                "aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ”",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000)),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            titleAndEditButton('Contract Info', 'Edit', ()=>Get.toNamed(AppRoute.serviceAboutDetailsScreen)),
            SizedBox(height: 5,),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.fillColor,
              ),
              child: Text(
                "+1 434 535 2463",
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000)),
              ),
            )
          ],
        ),
      ),
    );
  }
}


