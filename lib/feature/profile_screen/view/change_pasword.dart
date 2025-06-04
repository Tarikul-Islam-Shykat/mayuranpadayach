import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_title.dart';
import '../../../core/const/app_colors.dart';
import '../../auth/widget/text_field_widget.dart';
import '../controller/change_pasword_controller.dart';
import '../widget/round_back_button.dart';

class ChangePasword extends StatelessWidget {
  ChangePasword({super.key});
  final controller = Get.put(ChangePaswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundBackButton(onTap: ()=>Get.back(),),
                //SizedBox(width: 50.w,),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Change Password",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlackColor),
                  ),
                ),
              ],
            ),


            SizedBox(height: 20.h),
            Expanded(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldTitle(text: "Old Password"),
                  CustomAuthField(
                    radiusValue2: 15,
                    radiusValue: 15,
                    controller: controller.oldpaswordController,
                    hintText: 'Enter old password',
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFieldTitle(text: "New Password"),
                  CustomAuthField(
                    radiusValue2: 15,
                    radiusValue: 15,
                    controller: controller.newpaswordController,
                    hintText: 'Enter new password',
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFieldTitle(text: "Confirm Password"),
                  CustomAuthField(
                    radiusValue2: 15,
                    radiusValue: 15,
                    controller: controller.confirmpaswordController,
                    hintText: 'Enter confirm password',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
                onTap: () {},
                title: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 18.sp,color: AppColors.whiteColor),
                )),
          ],
        ),
      ),
    );
  }
}


