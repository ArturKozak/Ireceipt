import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';

class ScanArea extends WidgetBase {
  static final _iconSize = 2.0.r;

  final int quarterTurns;
  final double? rightPosition;
  final double? topPosition;
  final double? leftPosition;
  final double? bottomPosition;
  final double? indent;
  final double? endIndent;

  const ScanArea({
    required this.quarterTurns,
    super.key,
    this.rightPosition,
    this.topPosition,
    this.leftPosition,
    this.bottomPosition,
    this.indent,
    this.endIndent,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return Positioned(
      right: rightPosition,
      top: topPosition,
      left: leftPosition,
      bottom: bottomPosition,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: Divider(
          color: scheme.background.withOpacity(0.5),
          height: _iconSize,
          thickness: _iconSize,
          indent: indent,
          endIndent: endIndent,
        ),
      ),
    );
  }
}
