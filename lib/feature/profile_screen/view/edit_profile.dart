import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';
import '../../../core/const/app_colors.dart';
import '../../auth/widget/custom_booton_widget.dart';
import '../widget/round_back_button.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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
                roundBackButton(()=>Get.back(),),
                //SizedBox(width: 50.w,),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Edit Profile",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlackColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),

            //profile picture
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 105,
                    width: 105,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.purple.shade50,
                    ),
                    child: Center(child: Image.asset(ImagePath.profile),),
                  ),

                  Positioned(

                    bottom: -6,

                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(ImagePath.editIcon,color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h,),
            Text("Full Name",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 18.sp,color: AppColors.textBlackColor),),
            CustomAuthField(
              radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: nameController, hintText: "Darrell Steward"),

            SizedBox(height: 15.h,),
            Text("Email",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 18.sp,color: AppColors.textBlackColor),),
            CustomAuthField(
                radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: nameController, hintText: "darrellsteward@example.com"),

            SizedBox(height: 15.h,),
            Text("Phone",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 18.sp,color: AppColors.textBlackColor),),
            CustomAuthField(
                radiusValue: 15.r,
                radiusValue2: 15.r,
                controller: nameController, hintText: "+1 761 234 5678"),



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
