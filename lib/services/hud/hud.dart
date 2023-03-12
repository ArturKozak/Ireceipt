import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/util/app_animations.dart';
import 'package:ireceipt/util/app_constants.dart';
import 'package:lottie/lottie.dart';

class OverlayHud {
  BuildContext _context;
  late OverlayEntry overlayEntry;

  void _hide() {
    overlayEntry.remove();
  }

  void _showScanner() {
    final OverlayState overlayState = Overlay.of(_context);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return _ScannerLoader();
      },
    );

    return overlayState.insert(overlayEntry);
  }

  void _show() {
    final OverlayState overlayState = Overlay.of(_context);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return _FullScreenLoader();
      },
    );

    return overlayState.insert(overlayEntry);
  }

  Future<void> duringScanning<T>(Future<T> future) async {
    _showScanner();

    await future;

    await Future.delayed(AppConstants.animDuration * 5);

    return _hide();
  }

  Future<T> during<T>(Future<T> future) async {
    _show();

    return future.whenComplete(_hide);
  }

  OverlayHud._create(this._context);

  factory OverlayHud.of(BuildContext context) {
    return OverlayHud._create(context);
  }
}

class _ScannerLoader extends WidgetBase {
  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return Material(
      color: scheme.background,
      child: Stack(
        children: [
          Center(
            child: Lottie.asset(
              AppAnimations.scanner,
              height: 0.6.sh,
            ),
          ),
          Align(
            alignment: Alignment(0, 0.8),
            child: Text(
              'Wait, please',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w500,
                color: scheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.75)),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
