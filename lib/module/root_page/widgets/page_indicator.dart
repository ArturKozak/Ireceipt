import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends AnimatedWidget {
  static const _defaultItemSpacing = 11.0;
  static const _indicatorRadius = 25.0;

  final PageController controller;
  final int itemCount;

  const PageIndicator({
    required this.itemCount,
    required this.controller,
    super.key,
  }) : super(
          listenable: controller,
        );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (index) {
          final value = max(
            0.0,
            1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
          );

          final selectedness = Curves.easeOut.transform(value);

          return Container(
            height: 15.0.h,
            width: 15.0.w,
            decoration: BoxDecoration(
              color: scheme.background,
              borderRadius: const BorderRadius.all(
                Radius.circular(_indicatorRadius),
              ),
            ),
            margin: EdgeInsets.only(
              left: index == 0 ? _defaultItemSpacing / 2 : _defaultItemSpacing,
              right: index == itemCount - 1
                  ? _defaultItemSpacing / 2
                  : _defaultItemSpacing,
            ),
            child: Center(
              child: Opacity(
                opacity: selectedness,
                child: Container(
                  height: 10.0.h,
                  width: 10.0.w,
                  decoration: BoxDecoration(
                    color: scheme.onSecondaryContainer,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(_indicatorRadius),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
