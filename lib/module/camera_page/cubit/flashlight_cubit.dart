import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ireceipt/module/camera_page/cubit/camera_cubit.dart';

part 'flashlight_state.dart';

class FlashlightCubit extends Cubit<FlashlightState> {
  FlashlightCubit() : super(FlashlightTurnOff());

  bool _isFlashModeOn = false;

  bool get isFlashModeOn => _isFlashModeOn;

  Future<void> setFlashMode(FlashMode mode, BuildContext context) {
    HapticFeedback.mediumImpact();

    if (mode == FlashMode.torch) {
      _isFlashModeOn = true;

      emit(FlashlightTurnOn());
    }

    if (mode == FlashMode.off) {
      _isFlashModeOn = false;

      emit(FlashlightTurnOff());
    }

    return context.read<CameraCubit>().controller.setFlashMode(mode);
  }
}
