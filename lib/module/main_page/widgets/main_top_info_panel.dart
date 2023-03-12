import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/main_page/cubit/main_animation_cubit.dart';
import 'package:ireceipt/module/main_page/widgets/bottom_info_row.dart';
import 'package:ireceipt/module/main_page/widgets/top_info_row.dart';
import 'package:ireceipt/util/app_constants.dart';

class MainTopInfoPanel extends WidgetBase {
  static const _borderRadius = 25.0;

  static final _infoContainerHeight = 175.0.h;
  static final _infoMarginContainer = EdgeInsets.fromLTRB(33, 150, 33, 0).r;

  const MainTopInfoPanel({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return BlocBuilder<MainAnimationCubit, MainAnimationState>(
      builder: (context, state) {
        if (state is MainAnimationUpdate) {
          return Container(
            width: double.infinity,
            margin: _infoMarginContainer,
            height: _infoContainerHeight,
            decoration: BoxDecoration(
              color: scheme.onSecondaryContainer,
              borderRadius: BorderRadius.circular(_borderRadius).r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TopInfoRow(),
                BottomInfoRow(),
              ],
            ),
          ).animate().fade(duration: AppConstants.animDuration);
        }

        return SizedBox();
      },
    );
  }
}
