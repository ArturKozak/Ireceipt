import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/router/app_router.gr.dart';

class AppRoute {
  const AppRoute._();

  static void toReceiptConfirmPage(
    BuildContext context,
    RecognizedText recognizedText,
    InputImage inputImage,
  ) {
    AutoRouter.of(context).push(
      ReceiptConfirmRoute(
        recognizedText: recognizedText,
        inputImage: inputImage,
      ),
    );
  }

  static void toCameraPage(BuildContext context) {
    AutoRouter.of(context).push(CameraRoute());
  }
}
