import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

authTerms(BuildContext context) {
  return Center(
    child: MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: RichText(
          maxLines: 2,
          textAlign: TextAlign.center,
          text: TextSpan(
              text:
                  "By continuing, you confirm that you are 18 years or older and agree to our ",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1E1E24),
              ),
              children: [
                TextSpan(
                  text: "Terms & Conditions",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepPurple,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: " and",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E1E24),
                  ),
                ),
                TextSpan(
                  text: " Privacy Policy.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepPurple,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ])),
    ),
  );
}
