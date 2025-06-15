import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/global_widegts/loading_screen.dart';
import '../../../../route/route.dart';
import '../../../auth/widget/custom_booton_widget.dart';
import '../../../profile_screen/widget/round_back_button.dart';
import '../../admin_service/widget/title_and_edit_button.dart';
import '../controller/add_business_controller.dart';
import '../controller/admin_business_controller.dart';

class AboutDetailsScreen extends StatelessWidget {
   AboutDetailsScreen({super.key});
   final AddBusinessController controller = Get.put(AddBusinessController());
   final AdminBusinessController businessController = Get.put(AdminBusinessController());


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
                controller: controller.aboutTEC.value,
                hintText: "About ",
            ),
            SizedBox(height: 15.h,),

            titleAndEditButton('Contract Info', 'Save', ()=>Get.toNamed(AppRoute.serviceAboutScreen),),
            SizedBox(height: 4,),
            CustomAuthField(
              radiusValue2: 10,
              radiusValue: 10,
              controller: controller.contactTEC.value,
              hintText: "+1 434 535 2463",
            ),

            SizedBox(height: 30,),
            Obx(()=>controller.isAboutLoading.value?
            btnLoading():CustomButton(
              onTap: () async {
                log("id -------${controller.selectedID.value.toString()}");

                bool updated = await controller.editAbout(controller.selectedID.value.toString());

                if (updated) {
                  Get.back();
                }
              },

              title: Text("Update",
                  style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor),
                )))

          ],
        ),
      ),
    );
  }
}
