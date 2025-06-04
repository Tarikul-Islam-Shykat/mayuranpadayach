import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';

class AuthHeaderSubtitle extends StatelessWidget {
  const AuthHeaderSubtitle({
    super.key, required this.text, this.width=365,
  });
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width ,
      child: Text(text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(

            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.authHeaderSubtitleColor.withValues(alpha: .3)

        ),),
    );
  }
}
