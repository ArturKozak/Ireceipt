import 'package:flutter/cupertino.dart';

class CurvedPainter extends CustomClipper<Path> {
  CurvedPainter();

  @override
  Path getClip(Size size) {
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

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
