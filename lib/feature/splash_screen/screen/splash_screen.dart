import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import '../../../core/const/app_colors.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff7B4BF5),
                  Color(0xffBD5FF3),
                ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagePath.splashLogo,height: 104,width: 153,),
            Text("TimeLify",style: GoogleFonts.manrope(
              fontWeight: FontWeight.w800,
              fontSize: 64,
              color: AppColors.whiteColor,
            ),)
          ],
        ),
      ),
    );
  }
}
