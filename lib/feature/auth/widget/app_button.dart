import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onTap,
    required this.name,
    this.bgColor =Colors.grey,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.boarderColor=Colors.transparent,
  });
  final VoidCallback onTap;
  final String name;
  final Color? bgColor;
  final Color? textColor;
  final Color boarderColor;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: boarderColor),
          color:bgColor,
        ),
        child: Center(child:isLoading?CircularProgressIndicator.adaptive(): Text(name,style: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: textColor,
        ),),),
      ),
    );
  }
}