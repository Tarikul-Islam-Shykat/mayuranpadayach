import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/const/app_colors.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key, required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16,color: AppColors.blackColor),),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            "*",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
