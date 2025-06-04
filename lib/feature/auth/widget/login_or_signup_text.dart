import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';

class LoginOrSignupText extends StatelessWidget {
  const LoginOrSignupText({
    super.key, required this.title, required this.pageName, required this.onTap,
  });
  final String title;
  final String pageName;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(text: TextSpan(
            text:title,
            style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor),
            children: [
              TextSpan(
                  text:pageName,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.deepPurple)
              )
            ]
        )),
      ),
    );
  }
}