import 'package:flutter/material.dart';

class RoundBackButton extends StatelessWidget {
  const RoundBackButton({
    super.key, required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 18,
          ),
        ),
      ),
    );
  }
}