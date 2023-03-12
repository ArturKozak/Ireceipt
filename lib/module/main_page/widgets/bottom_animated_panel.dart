import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ireceipt/kit/custom_widgets/liquid_painter.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/camera_page/camera_page.dart';
import 'package:ireceipt/module/main_page/cubit/main_animation_cubit.dart';
import 'package:ireceipt/util/app_animations.dart';
import 'package:ireceipt/util/app_constants.dart';
import 'package:lottie/lottie.dart';

class BottomAnimatedPanel extends WidgetBase {
  static final _iconSize = 35.0.r;

  BottomAnimatedPanel({super.key});

  @override
  Widget body(
    BuildContext context,
    ColorScheme scheme,
    Size size,
  ) {
    return BlocBuilder<MainAnimationCubit, MainAnimationState>(
      builder: (context, state) {
        if (state is MainAnimationUpdate) {
          return AnimatedBuilder(
            animation: context.read<MainAnimationCubit>().firstAniCon,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  (0.83.sh + MediaQuery.of(context).viewInsets.bottom) *
                      context.read<MainAnimationCubit>().firstAni.value,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: AppConstants.padding).r,
                        child: Text(
                          'Start Scan',
                          style: TextStyle(
                            fontSize: 32.0.sp,
                            fontWeight: FontWeight.bold,
                            color: scheme.onSecondaryContainer.withOpacity(
                              context
                                  .read<MainAnimationCubit>()
                                  .calculateOpacity(),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          context
                              .read<MainAnimationCubit>()
                              .processChanges(details, size);
                        },
                        onHorizontalDragStart: (_) =>
                            context.read<MainAnimationCubit>().reset(),
                        onVerticalDragDown: context
                            .read<MainAnimationCubit>()
                            .onVerticalDragDown,
                        onVerticalDragEnd: (details) => context
                            .read<MainAnimationCubit>()
                            .onDragEnd(details),
                        behavior: HitTestBehavior.translucent,
                        child: AnimatedContainer(
                          duration: AppConstants.animDuration,
                          curve: Curves.elasticOut,
                          height: context
                              .read<MainAnimationCubit>()
                              .firstBumpHeight
                              .clamp(100, 150),
                          width: size.width,
                          child: CustomPaint(
                            painter: MyCustomPainter(
                              context
                                  .read<MainAnimationCubit>()
                                  .firstAniBump
                                  .value,
                              context
                                  .read<MainAnimationCubit>()
                                  .hasFirstSheetPassedHalf,
                              scheme.onSecondaryContainer,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: AnimatedSwitcher(
                                duration: AppConstants.halfAnimDuration,
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                                child: context
                                        .read<MainAnimationCubit>()
                                        .animSwitcher
                                    ? Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => context
                                                .read<MainAnimationCubit>()
                                                .reset(),
                                            icon: FaIcon(
                                              FontAwesomeIcons.angleLeft,
                                              size: _iconSize,
                                              color: scheme.background,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '''hello wdsdsa sadsads dasds sadasdsd sads sdasds sadsds sadasdsd sadsadsa a sadsads sadsa''',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : AnimatedContainer(
                                        duration: AppConstants.animDuration,
                                        curve: Curves.ease,
                                        child: Opacity(
                                          opacity: context
                                              .read<MainAnimationCubit>()
                                              .calculateOpacity(),
                                          child: RotatedBox(
                                            quarterTurns: 2,
                                            child: Lottie.asset(
                                              AppAnimations.arrow,
                                              height: 80.0.h,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CameraPage(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).animate().slideY(
                begin: 1,
                end: 0,
                duration: AppConstants.animDuration,
                curve: Curves.bounceIn,
              );
        }
        return SizedBox();
      },
    );
  }
}
