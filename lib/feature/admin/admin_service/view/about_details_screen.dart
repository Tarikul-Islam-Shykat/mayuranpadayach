import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../route/route.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../widget/title_and_edit_button.dart';

class AboutDetailsScreen extends StatelessWidget {
   AboutDetailsScreen({super.key});
   final detailsTextController = TextEditingController();
   final numberTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.bgColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: roundBackButton(() => Get.back()),
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
            titleAndEditButton("Basic Info", 'Save', ()=>Get.toNamed(AppRoute.serviceAboutScreen)),
            SizedBox(height: 4,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              maxLines: 10,
                controller: detailsTextController,
                hintText: "“ Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris ”",
            ),
            SizedBox(height: 15.h,),

            titleAndEditButton('Contract Info', 'Save', ()=>Get.toNamed(AppRoute.serviceAboutScreen),),
            SizedBox(height: 4,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller: detailsTextController,
              hintText: "+1 434 535 2463",
            ),

          ],
        ),
      ),
    );
  }
}
