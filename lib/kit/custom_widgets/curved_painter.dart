import 'package:flutter/cupertino.dart';

class CurvedPainter extends CustomPainter {
  final Color color;

  CurvedPainter(
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(
        size.width * .0,
        size.height,
      )
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height - 100.0,
        size.width,
        size.height,
      )
      ..lineTo(
        size.width,
        size.height * .0,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
