import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../route/route.dart';
import '../controller/signup_controller.dart';
import '../widget/auth_header_subtitle.dart';
import '../widget/auth_header_text.dart';
import '../widget/auth_terms.dart';
import '../widget/custom_booton_widget.dart';
import '../widget/custome_dropdown.dart';
import '../widget/login_or_signup_text.dart';
import '../widget/text_field_title.dart';
import '../widget/text_field_widget.dart';
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Center(child: Image.asset(ImagePath.loginLogo,width: 71.w,height: 48.h,fit: BoxFit.fill,)),
            SizedBox(height: 10.h,),
            Center(child: headingText(text: "Create An Account"),),
            SizedBox(height: 4.h,),
            Center(child: smallText(text: "Start your journey in playmate with fun, interactive lessons now",maxLines: 2,textAlign: TextAlign.center,color: AppColors.grayColor),),

            SizedBox(height: 20.h,),
            textFieldTitle(text: 'Full Name',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: controller.nameTEController,
              hintText: "Enter Full Name Here",
              keyboardType: TextInputType.name,
            ),

            SizedBox(height: 15.h,),

            textFieldTitle(text: 'Email',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: controller.emailTEController,
              hintText: "Enter Email Here",
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 15.h,),

            textFieldTitle(text: 'Password',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: controller.passwordTEController,
              hintText: "Enter Password Here",
              keyboardType: TextInputType.visiblePassword,
            ),

            SizedBox(height: 15.h,),

            textFieldTitle(text: 'Role',),

            CustomDropdown(
              items: controller.role,
              selectedItem: controller.selectedRoleItem,
              label: "Select Your Role",
            ),
            SizedBox(height:Get.height*0.05.h,),


            CustomButton(
              onTap: (){},
              title: Text("Sign Up",
                style: GoogleFonts.manrope(fontSize: 16.sp,fontWeight: FontWeight.w800,color: Colors.white),),
              color: Colors.deepPurple,
            ),
            SizedBox(height: 15.h,),
            loginOrSignupText(
              title: 'Already have an account? ',
              pageName: 'Log in',
              onTap: ()=>Get.toNamed(AppRoute.loginScreen),
            ),
            SizedBox(height: 5.h,),
            Center(child: authTerms(context)),
            SizedBox(height: 10.h,),

          ],
        ),
      ),

    );
  }
}