import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ireceipt/util/app_constants.dart';

part 'main_animation_state.dart';

class MainAnimationCubit extends Cubit<MainAnimationState> {
  MainAnimationCubit() : super(MainAnimationUpdate());

  late AnimationController firstAniCon;

  late Animation firstAni;
  late Animation firstAniBump;

  double firstBumpHeight = 120;
  double firstBumpPointerLocation = 0;
  double firstBumpPointerLocationSec = 1;
  int firstIconPadding = 25;

  bool animSwitcher = false;
  bool isFirstSheetClosed = true;
  bool hasFirstSheetPassedHalf = false;
  bool firstBumpIconOpac = true;

  MainAnimationCubit init(TickerProvider tickerProvider) {
    firstAniCon = AnimationController(
      vsync: tickerProvider,
      duration: AppConstants.animDuration,
      reverseDuration: AppConstants.animDuration,
    );

    firstAni = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstAniCon,
        curve: Curves.easeInCubic,
        reverseCurve: Curves.easeOutCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isFirstSheetClosed = false;

          emit(MainAnimationUpdate());
        }

        if (status == AnimationStatus.dismissed) {
          isFirstSheetClosed = true;
          firstBumpPointerLocation = 0;
          firstBumpPointerLocationSec = 1;
          firstIconPadding = 25;
          animSwitcher = false;

          emit(MainAnimationUpdate());
        }

        if (status == AnimationStatus.forward) {
          firstBumpIconOpac = false;
          firstIconPadding = 0;

          emit(MainAnimationUpdate());
        }

        if (status == AnimationStatus.reverse) {
          firstBumpIconOpac = true;
          hasFirstSheetPassedHalf = false;

          emit(MainAnimationUpdate());
        }
      });

    firstAniBump = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: firstAniCon,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    return this;
  }

  double calculateOpacity() {
    return firstBumpIconOpac == true
        ? isFirstSheetClosed == true
            ? 0.9 * firstBumpPointerLocationSec
            : 0.9 *
                lerpDouble(
                  1,
                  0,
                  firstAniCon.value,
                )!
                    .toDouble()
        : 0.0;
  }

  void processChanges(DragUpdateDetails details, Size size) {
    isFirstSheetClosed == true
        ? firstBumpHeight = size.height - details.globalPosition.dy
        : null;
    firstBumpPointerLocation =
        (details.localPosition.dy.abs().clamp(0, 100) / 100);
    firstBumpPointerLocationSec =
        ((details.globalPosition.dy - 503).clamp(0, 100) / 100);

    emit(MainAnimationUpdate());
  }

  void onVerticalDragDown(DragDownDetails details) {
    isFirstSheetClosed == false ? firstAniCon.forward() : null;

    emit(MainAnimationUpdate());
  }

  Future<void> onDragEnd(DragEndDetails details) async {
    firstBumpHeight = 110;

    isFirstSheetClosed == true ? firstAniCon.forward() : null;

    await Future.delayed(AppConstants.halfAnimDuration);

    animSwitcher = true;

    emit(MainAnimationUpdate());
  }

  void reset() {
    firstAniCon.reverse();

    isFirstSheetClosed = true;
    firstBumpPointerLocation = 0;
    firstBumpPointerLocationSec = 1;
    firstIconPadding = 25;
    animSwitcher = false;

    emit(MainAnimationUpdate());
  }
}
