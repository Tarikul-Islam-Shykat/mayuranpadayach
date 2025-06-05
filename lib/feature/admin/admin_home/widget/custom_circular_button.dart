import 'package:flutter/material.dart';

import '../../../../core/const/app_colors.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.height=42,
    this.width=42,
    this.bgColor=Colors.white,
    this.borderColor=Colors.white54,
  });
  final Widget icon;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: borderColor),
            color: bgColor,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
