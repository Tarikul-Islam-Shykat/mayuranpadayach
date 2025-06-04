import 'package:flutter/material.dart';
class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    super.key, required this.icon, required this.onTap,
  });
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white
        ),
        child: icon,
      ),
    );
  }
}