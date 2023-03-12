import 'package:flutter/cupertino.dart';

class MyCustomPainter extends CustomPainter {
  final double value;
  final bool ifSheetPassedHalf;
  final Color color;

  MyCustomPainter(
    this.value,
    this.ifSheetPassedHalf,
    this.color,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(
        size.width * .0,
        size.height,
      )
      ..lineTo(
        size.width * .0,
        size.height * .64 - (146 * value),
      )
      ..lineTo(
        size.width * .23,
        size.height * .64 - (146 * value),
      )
      ..cubicTo(
        size.width * .35,
        size.height * .61 - (146 * value),
        size.width * .39,
        size.height * .49 - (130 * value),
        size.width * .4,
        size.height * .30 - (110 * value),
      )
      ..arcToPoint(
        Offset(
          size.width * .6,
          size.height * .30 - (110 * value),
        ),
        radius: Radius.elliptical(
          10,
          (10 - (10 * value)),
        ),
      )
      ..cubicTo(
        size.width * .61,
        size.height * .49 - (132 * value),
        size.width * .65,
        size.height * .62 - (146 * value),
        size.width * .77,
        size.height * .63 - (146 * value),
      )
      ..lineTo(
        size.width,
        size.height * .63 - (146 * value),
      )
      ..lineTo(
        size.width,
        size.height * 100 - (146 * value),
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
