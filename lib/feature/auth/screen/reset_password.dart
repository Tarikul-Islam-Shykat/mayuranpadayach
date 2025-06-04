import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/widget.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/auth/widget/custom_booton_widget.dart';
import 'package:prettyrini/feature/auth/widget/text_field_widget.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/app_snackbar.dart';
import '../../../route/route.dart';
import '../widget/auth_header_subtitle.dart';
import '../widget/auth_header_text.dart';
import '../widget/text_field_title.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // validateAndAction() async {
  //   String? password = passwordController.text;
  //   String? confirmPassword = confirmPasswordController.text;
  //
  //   if (password.isEmpty || confirmPassword.isEmpty) {
  //     AppSnackbar.show(message: "Please Enter Your Password", isSuccess: false);
  //     return;
  //   }
  //
  //   if (password != confirmPassword) {
  //     AppSnackbar.show(message: "Password Aren't Same", isSuccess: false);
  //     return;
  //   }
  //
  //   if (password.length < 8 || confirmPassword.length < 8) {
  //     AppSnackbar.show(
  //       message: "Password Can't Be Less then 8",
  //       isSuccess: false,
  //     );
  //     return;
  //   }
  //
  //   //final AuthController authController = Get.put(AuthController());
  //   final String email = Get.arguments['email'];
  //
  //   // var isResetPasswordSuccess = await authController.resetPassword(
  //   //   email: email,
  //   //   password: password,
  //   // );
  //   if (isResetPasswordSuccess) {
  //     Get.offAllNamed(AppRoute.loginScreen);
  //   }
  // }
  //    final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.h),

            Center(child: Image.asset(ImagePath.loginLogo,width: 71,height: 48,)),
            SizedBox(height: 10,),
            Center(child: AuthHeaderText(text: "Reset Password",)),
            SizedBox(height: 4,),
            Center(child: AuthHeaderSubtitle(
              width: 320,
              text: "Please check your email. Give correct reset 5 digit code here.",)),
            SizedBox(height: 20,),

            TextFieldTitle(text: 'New Password',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: passwordController,
              hintText: "New Password",
            ),
            SizedBox(height: 10.h),

            TextFieldTitle(text: 'Confirm Password',),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: confirmPasswordController,
              hintText: "Confirm Password",
            ),

            SizedBox(height: 30.h),


          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onTap: (){},
              color: Colors.white,
              title: Text(
                'Reset Password',
                style: GoogleFonts.manrope(
                  fontSize: 16.sp,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
