import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/custom_widgets/curved_painter.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/util/app_constants.dart';

class MainTopCustomPanel extends WidgetBase {
  static const _borderRadius = 25.0;

  static final _topContainerHeight = 250.0.h;
  static final _emptyContainerHeight = 175.0.h;
  static final _emptyMarginContainer = EdgeInsets.fromLTRB(25, 142, 25, 0).r;

  const MainTopCustomPanel({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return Stack(
      children: [
        SizedBox(
          height: _topContainerHeight,
          width: double.infinity,
          child: CustomPaint(
            painter: CurvedPainter(scheme.onSecondaryContainer),
          ),
        ),
        Container(
          width: double.infinity,
          margin: _emptyMarginContainer,
          height: _emptyContainerHeight,
          decoration: BoxDecoration(
            color: scheme.background,
            borderRadius: BorderRadius.circular(_borderRadius).r,
          ),
        ),
      ],
    ).animate().slideY(
          begin: -1,
          end: 0,
          duration: AppConstants.animDuration,
          curve: Curves.bounceIn,
        );
  }
}
