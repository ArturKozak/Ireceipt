import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/router/app_route.dart';
import 'package:ireceipt/util/app_constants.dart';

class BottomAnimatedPanel extends WidgetBase {
  static const _borderRadius = 25.0;

  BottomAnimatedPanel({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.padding * 2).r,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () => AppRoute.toCameraPage(context),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(scheme.primary),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                vertical: AppConstants.padding / 2,
                horizontal: AppConstants.padding,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_borderRadius).r,
              ),
            ),
          ),
          child: Text(
            'Start Scan',
            style: TextStyle(
              fontSize: 32.0.sp,
              fontWeight: FontWeight.bold,
              color: scheme.background,
            ),
          ),
        ),
      ).animate().slideY(
            begin: 1,
            end: 0,
            duration: AppConstants.animDuration,
            curve: Curves.bounceIn,
          ),
    );
  }
}
