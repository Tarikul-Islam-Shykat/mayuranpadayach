import 'package:flutter/material.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';

class DiscountBadge extends StatelessWidget {
  final String discount;
  final Color? color;

  const DiscountBadge({
    Key? key,
    required this.discount,
    this.color,
  }) : super(key: key);
// MediaQuery.of(context).size.height * 0.2,
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height * 0.1,
      child: CustomPaint(
        painter: _RibbonPainter(color: color ?? Colors.purple),
        child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: normalText(
                  text: discount,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  final Color color;

  _RibbonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 8, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width - 8, size.height)
      ..lineTo(0, size.height)
      ..lineTo(8, size.height / 2)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
