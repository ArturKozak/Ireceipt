import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/util/app_constants.dart';

class BottomInfoRow extends WidgetBase {
  static const _itemSize = 75.0;
  static const _borderRadius = 25.0;

  const BottomInfoRow({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.padding).r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: AppConstants.padding).r,
            child: Text(
              'Your scanned receipts',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 22.0.sp,
                fontWeight: FontWeight.w500,
                color: scheme.background,
              ),
            ),
          ),
          Container(
            width: _itemSize.w,
            height: _itemSize.h,
            decoration: BoxDecoration(
              color: scheme.background,
              borderRadius: BorderRadius.circular(_borderRadius).r,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              '12',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
                color: scheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
