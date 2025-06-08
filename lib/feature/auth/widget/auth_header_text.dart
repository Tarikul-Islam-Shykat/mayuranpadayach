import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';
class AuthHeaderText extends StatelessWidget {
  const AuthHeaderText({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.manrope(
      fontWeight: FontWeight.w800,
      fontSize: 24,
      color: AppColors.blackColor,
    ),);
  }
}