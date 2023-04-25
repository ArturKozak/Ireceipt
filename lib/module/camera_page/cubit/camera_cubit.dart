import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ireceipt/router/app_route.dart';
import 'package:ireceipt/services/hud/hud.dart';
import 'package:ireceipt/util/save.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  final _textRecognizer = TextRecognizer();
  final _picker = ImagePicker();

  late CameraController controller;

  Future<void> _recognizeText(BuildContext context, String path) async {
    final inputImage = InputImage.fromFilePath(path);

    final result = await _textRecognizer.processImage(inputImage);

    return AppRoute.toReceiptConfirmPage(
      context,
      result,
      inputImage,
    );
  }

  void initControllers() async {
    controller = CameraController(
      Save.cameras.elementAt(0),
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await controller.initialize();

    await controller.resumePreview();

    emit(CameraInitial());
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final CameraController cameraController = controller;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);

    emit(CameraInitial());
  }

  Future<void> getText(BuildContext context) async {
    HapticFeedback.vibrate();

    final file = await _picker.getImage(source: ImageSource.gallery);

    if (file == null) {
      return;
    }

    await OverlayHud.of(context).duringScanning(
      _recognizeText(
        context,
        file.path,
      ),
    );
  }

  Future<void> getTextFromPhoto(BuildContext context) async {
    HapticFeedback.vibrate();

    final file = await controller.takePicture();

    return OverlayHud.of(context).duringScanning(
      _recognizeText(
        context,
        file.path,
      ),
    );
  }
}
