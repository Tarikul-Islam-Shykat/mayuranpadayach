import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../route/route.dart';
import '../controller/forget_pasword_controller.dart';
import '../widget/auth_header_subtitle.dart';
import '../widget/auth_header_text.dart';
import '../widget/custom_booton_widget.dart';
import '../widget/text_field_title.dart';
import '../widget/text_field_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});

  final ForgetPasswordController controller = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Center(child: Image.asset(ImagePath.loginLogo,width: 71.w,height: 48.h,fit: BoxFit.fill,)),
              SizedBox(height: 10.h,),
              Center(child: headingText(text: "Forget Password"),),
              //Center(child: authHeaderText("Forget Password",)),
              SizedBox(height: 4.h,),
              Center(child:smallText(text: "Enter your email here. Give valid email to reset your password",maxLines: 2,textAlign: TextAlign.center,color: AppColors.grayColor) ,),
              // Center(child: authHeaderSubtitle(
              //   "Enter your email here. Give valid email to reset your password", width:320.w,)),
              SizedBox(height: 15.h),
              textFieldTitle(text: 'Email',),
              CustomAuthField(
                keyboardType: TextInputType.emailAddress,
                radiusValue: 15,
                radiusValue2: 15,
                controller: controller.emailController,
                hintText: 'Enter Email Here',
              ),
              Spacer(),
           CustomButton(
                    onTap: ()=>controller.sendemail(),
                    title: Text(
                      'Send Email',
                      style: GoogleFonts.manrope(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

            ],
          ),
        ),
      ),
    );
  }
}
