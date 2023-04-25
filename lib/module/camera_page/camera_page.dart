// ignore_for_file: lines_longer_than_80_chars

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/page_base/receipt_page_base.dart';
import 'package:ireceipt/module/camera_page/cubit/camera_cubit.dart';
import 'package:ireceipt/module/camera_page/cubit/flashlight_cubit.dart';
import 'package:ireceipt/module/camera_page/widgets/arc_scan_area.dart';
import 'package:ireceipt/module/camera_page/widgets/bottom_control_panel.dart';

class CameraPage extends ReceiptPageBase {
  static final _scanAreaPosition = 45.0;
  static final _indent = 15.0;

  const CameraPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CameraCubit()..initControllers(),
        ),
        BlocProvider(
          create: (_) => FlashlightCubit(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget readyContent(BuildContext context, ColorScheme scheme, Size? size) {
    return BlocBuilder<CameraCubit, CameraState>(
      builder: (context, state) {
        if (state is CameraInitial) {
          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.onSecondaryContainer,
                  ),
                  child: CameraPreview(
                    context.read<CameraCubit>().controller,
                    child: LayoutBuilder(
                      builder: (
                        BuildContext context,
                        BoxConstraints constraints,
                      ) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTapDown: (TapDownDetails details) => context
                              .read<CameraCubit>()
                              .onViewFinderTap(details, constraints),
                        );
                      },
                    ),
                  ),
                ),
              ),
              ScanArea(
                topPosition: 0.0,
                rightPosition: _scanAreaPosition.w,
                bottomPosition: 0.0,
                quarterTurns: 3,
                indent: _scanAreaPosition * 2,
              ),
              ScanArea(
                topPosition: 0.0,
                leftPosition: _scanAreaPosition.w,
                bottomPosition: 0.0,
                quarterTurns: 3,
                indent: _scanAreaPosition * 2,
              ),
              ScanArea(
                topPosition: 0.0,
                leftPosition: MediaQuery.of(context).size.width / 2,
                bottomPosition: 0.0,
                quarterTurns: 3,
                indent: _scanAreaPosition * 2,
              ),
              ScanArea(
                bottomPosition: _scanAreaPosition.h * 2,
                rightPosition: 0.0,
                leftPosition: 0.0,
                quarterTurns: 2,
                indent: _indent,
                endIndent: _indent,
              ),
              ScanArea(
                bottomPosition: MediaQuery.of(context).size.height / 2.48,
                rightPosition: 0.0,
                leftPosition: 0.0,
                quarterTurns: 2,
                indent: _indent,
                endIndent: _indent,
              ),
              ScanArea(
                topPosition: _scanAreaPosition.h,
                leftPosition: 0.0,
                rightPosition: 0.0,
                quarterTurns: 2,
                indent: _indent,
                endIndent: _indent,
              ),
              BottomControlPanel(
                getText: () => context.read<CameraCubit>().getText(context),
                getTextFromPhoto: () =>
                    context.read<CameraCubit>().getTextFromPhoto(context),
                setFlashMode: () =>
                    context.read<FlashlightCubit>().setFlashMode(
                          context.read<FlashlightCubit>().isFlashModeOn
                              ? FlashMode.off
                              : FlashMode.torch,
                          context,
                        ),
              ),
            ],
          );
        }

        return SizedBox();
      },
    );
  }
}
