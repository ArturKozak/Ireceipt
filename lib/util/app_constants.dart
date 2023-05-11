import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppConstants {
  const AppConstants._();
  static final animDuration = 700.ms;
  static final halfAnimDuration = 350.ms;
  static const padding = 16.0;
  static const productNameCollection = 'productNameCollection';

  static final boxShadowMain = BoxShadow(
    color: Color(0xFF575757).withOpacity(0.2),
    blurRadius: 20.0,
    spreadRadius: 4,
    offset: Offset(0, 5),
  );
}
