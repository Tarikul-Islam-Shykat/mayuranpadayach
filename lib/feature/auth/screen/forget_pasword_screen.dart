import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../core/style/global_text_style.dart';
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50.h),
              Center(child: Image.asset(ImagePath.loginLogo,width: 71,height: 48,)),
              SizedBox(height: 10,),
              Center(child: AuthHeaderText(text: "Forget Password",)),
              SizedBox(height: 4,),
              Center(child: AuthHeaderSubtitle(
                width: 320,
                text: "Enter your email here. Give valid email to reset your password",)),
              SizedBox(height: 15.h),
              TextFieldTitle(text: 'Email',),
              CustomAuthField(
                radiusValue: 15,
                radiusValue2: 15,
                controller: controller.emailController,
                hintText: 'Enter Email Here',
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 55,
          child: CustomButton(
            onTap: () =>Get.toNamed(AppRoute.otpVerificationScreen),
            title: Text(
              'Send Email',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
