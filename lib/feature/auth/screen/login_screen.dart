import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../route/route.dart';
import '../controller/login_controller.dart';
import '../widget/auth_header_subtitle.dart';
import '../widget/auth_header_text.dart';
import '../widget/auth_terms.dart';
import '../widget/login_or_signup_text.dart';
import '../widget/text_field_title.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var loginEmailController = TextEditingController();
    var loginPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Center(child: Image.asset(ImagePath.loginLogo,width: 71,height: 48,)),
            SizedBox(height: 10,),
            Center(child: AuthHeaderText(text: "Sign In Account",)),
            SizedBox(height: 4,),
            Center(child: AuthHeaderSubtitle(text: "Start your journey in playmate with fun, interactive lessons now",)),

            SizedBox(height: 15.h,),


            TextFieldTitle(text: 'Email',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: controller.emailTEController,
              hintText: "Enter Email Here",
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 15.h,),

            TextFieldTitle(text: 'Password',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: controller.passwordTEController,
              hintText: "Enter Password Here",
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 5,),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: ()=>Get.toNamed(AppRoute.forgetScreen),
                  child: Text("Forgot Password",
                    style: GoogleFonts.poppins(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.deepPurple),)),
            ),


            SizedBox(height: Get.height*0.25,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: AuthTerms()),
                SizedBox(height: 15.h,),
                CustomButton(
                  onTap: ()=>Get.toNamed(AppRoute.profileScreen),
                  title: Text("Log In",
                    style: GoogleFonts.manrope(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.white),),
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 15,),
                LoginOrSignupText(
                  title: 'Don’t have an account? ',
                  pageName: 'Sign Up',
                  onTap: ()=>Get.toNamed(AppRoute.signUpScreen),
                ),
                SizedBox(height: 10,),
              ],
            ),



          ],
        ),
      ),


    );
  }
}
