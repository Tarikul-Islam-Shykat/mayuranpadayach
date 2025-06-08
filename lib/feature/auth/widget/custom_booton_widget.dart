import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget title; // Accepts both text and loader
  final Color? color;
  final bool isDoubleInfinity;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
    this.isDoubleInfinity = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handles button click
      child: Center(
        child: SizedBox(
          width: isDoubleInfinity ? double.infinity : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              gradient: AppColors.gradientColor,
              //border: Border.all(color: AppColors.primaryBlue, width: 2),
              color: onTap == null
                  ? Colors.grey
                  : (color ??
                  AppColors.primaryColor), // Disabled state handling
              borderRadius: BorderRadius.circular(15.r),
            ),
            alignment: Alignment.center,
            child: title, // Shows text or loader
          ),
        ),
      ),
    );
  }
}
