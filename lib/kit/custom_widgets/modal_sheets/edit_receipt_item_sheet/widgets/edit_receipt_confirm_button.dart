import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/util/app_constants.dart';

class EditReceiptConfirmButton extends WidgetBase {
  static final _buttonHeight = 50.0.h;

  final VoidCallback onTap;

  const EditReceiptConfirmButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.padding).r,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.padding,
          ).r,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.padding).r,
          ),
        ),
        child: Container(
          height: _buttonHeight,
          alignment: Alignment.center,
          child: Text(
            'Confirm',
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w700,
              color: scheme.background,
            ),
          ),
        ),
      ),
    );
  }
}
