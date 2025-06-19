import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/services_class/local_service/local_data.dart';
import 'package:prettyrini/route/route.dart';

import '../../../core/const/app_colors.dart';
import '../widget/profile_email_text.dart';
import '../widget/profile_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Profile",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.textBlackColor),
            )),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: Get.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Color(0xFFFFFFFF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile pic
                  Container(
                    height: 55.h,
                    width: 64.w,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: Colors.purple.shade50.withValues(alpha: .5),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          ImagePath.profile,
                        )),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      SizedBox(
                        width: 240.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Darrell Steward",
                              style: GoogleFonts.poppins(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlackColor),
                            ),
                            InkWell(
                                onTap: () =>
                                    Get.toNamed(AppRoute.editProfileScreen),
                                child: Image.asset(ImagePath.editIcon)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      profileEmailText(
                        ImagePath.messageIcon,
                        'darrellsteward@example.com',
                      ),
                      profileEmailText(
                        ImagePath.callIcon,
                        '+1 761 234 5678',
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Support & Help",
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlackColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileListTile(
                    ImagePath.aboutIcon,
                    'About Us',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    ImagePath.changePassIcon,
                    'Change Password',
                    () => Get.toNamed(AppRoute.changePasswordScreen),
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    ImagePath.termsIcon,
                    'Terms & Conditions',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    ImagePath.privacyIcon,
                    'Privacy Policy',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    ImagePath.privacyIcon,
                    'Log Out',
                    () async {
                      var userService = LocalService();
                      await userService.clearUserData();
                      Get.toNamed(AppRoute.loginScreen);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
