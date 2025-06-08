import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTerms extends StatelessWidget {
  const AuthTerms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: RichText(text: TextSpan(
            text: "By continuing, you confirm that you are 18 years or older and agree to our ",
            style:GoogleFonts.poppins(
              fontSize: 12,
              fontWeight:FontWeight.w400,
              color: Color(0xFF1E1E24),
            ) ,
            children:[
              TextSpan(
                text: "Terms & Conditions",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight:FontWeight.w400,
                  color: Colors.deepPurple,
                ),
                recognizer:TapGestureRecognizer()
                  ..onTap = () {},
              ),

              TextSpan(
                text: " and",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight:FontWeight.w400,
                  color: Color(0xFF1E1E24),
                ),
              ),
              TextSpan(
                text: " Privacy Policy.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight:FontWeight.w400,
                  color: Colors.deepPurple,
                ),
                recognizer:TapGestureRecognizer()
                  ..onTap = () {},
              ),
            ]
        )),
      ),
    );
  }
}