import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/util/app_constants.dart';

class TopInfoRow extends WidgetBase {
  static const _itemSize = 50.0;

  const TopInfoRow({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppConstants.padding,
        AppConstants.padding,
        AppConstants.padding,
        0,
      ).r,
      child: Row(
        children: [
          Container(
            width: _itemSize.w,
            height: _itemSize.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [AppConstants.boxShadowMain],
            ),
            child: Image.network(
              'https://picsum.photos/seed/903/600',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: AppConstants.padding).r,
            child: SelectionArea(
              child: Text(
                'Hello, Artur Kozak',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
