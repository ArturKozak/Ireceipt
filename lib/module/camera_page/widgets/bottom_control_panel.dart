import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/camera_page/widgets/flash_button.dart';

class BottomControlPanel extends WidgetBase {
  static const _bigCircleSize = 65.0;
  static const _smallCircleSize = 45.0;

  static final _rightPosition = 16.0.w;
  static final _bottomPosition = 10.0.h;
  static final _iconSize = 35.0.r;

  final VoidCallback getText;
  final VoidCallback getTextFromPhoto;
  final VoidCallback setFlashMode;

  const BottomControlPanel({
    required this.getText,
    required this.getTextFromPhoto,
    required this.setFlashMode,
    super.key,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return Stack(
      children: [
        Positioned(
          right: _rightPosition,
          bottom: _bottomPosition,
          child: IconButton(
            onPressed: getText,
            icon: FaIcon(
              FontAwesomeIcons.solidImage,
              size: _iconSize,
              color: scheme.background,
            ),
          ),
        ),
        FlashButton(setFlashMode: setFlashMode),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: getTextFromPhoto,
            icon: Container(
              height: _bigCircleSize.h,
              width: _bigCircleSize.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.background,
                  width: 3,
                ),
              ),
              child: Container(
                height: _smallCircleSize.h,
                width: _smallCircleSize.w,
                decoration: BoxDecoration(
                  color: scheme.background,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
