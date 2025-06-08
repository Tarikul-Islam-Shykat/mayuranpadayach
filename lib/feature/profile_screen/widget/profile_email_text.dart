import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';


class ProfileEmailText extends StatelessWidget {
  const ProfileEmailText({
    super.key, required this.image, required this.name,
  });
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image),
        SizedBox(width: 6.w,),
        SizedBox(
          width: 210.w,
          child: Text(name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(

            fontWeight: FontWeight.w300,
            fontSize: 12.sp,
            color: AppColors.textBlackColor,
          )),
        ),
      ],
    );
  }
}