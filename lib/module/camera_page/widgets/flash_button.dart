import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/camera_page/cubit/flashlight_cubit.dart';
import 'package:ireceipt/util/app_icons.dart';

class FlashButton extends WidgetBase {
  static final _bottomPosition = 10.0.h;
  static final _leftPosition = 16.0.w;
  static final _iconSize = 30.0.r;

  final VoidCallback setFlashMode;

  const FlashButton({required this.setFlashMode, super.key});

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return BlocBuilder<FlashlightCubit, FlashlightState>(
      builder: (context, state) {
        if (state is FlashlightTurnOn) {
          return Positioned(
            left: _leftPosition,
            bottom: _bottomPosition,
            child: IconButton(
              onPressed: setFlashMode,
              icon: SvgPicture.asset(
                AppIcons.flashLightOn,
                colorFilter:
                    ColorFilter.mode(scheme.background, BlendMode.srcIn),
                height: _iconSize,
                width: _iconSize,
              ),
            ),
          );
        }

        return Positioned(
          left: _leftPosition,
          bottom: _bottomPosition,
          child: IconButton(
            onPressed: setFlashMode,
            icon: SvgPicture.asset(
              AppIcons.flashLightOff,
              colorFilter: ColorFilter.mode(scheme.background, BlendMode.srcIn),
              height: _iconSize,
              width: _iconSize,
            ),
          ),
        );
      },
    );
  }
}
