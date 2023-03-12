// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:google_ml_kit/google_ml_kit.dart' as _i9;

import '../module/analytics_page/analytics_page.dart' as _i5;
import '../module/camera_page/camera_page.dart' as _i3;
import '../module/main_page/main_page.dart' as _i4;
import '../module/receipt_confirm_page/receipt_confirm_page.dart' as _i2;
import '../module/root_page/root_page.dart' as _i1;
import 'app_router.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      final args =
          routeData.argsAs<RootRouteArgs>(orElse: () => const RootRouteArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(child: _i1.RootPage(key: args.key)),
        customRouteBuilder: _i8.fadeRouteBuilder,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ReceiptConfirmRoute.name: (routeData) {
      final args = routeData.argsAs<ReceiptConfirmRouteArgs>();
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(
            child: _i2.ReceiptConfirmPage(
          recognizedText: args.recognizedText,
          inputImage: args.inputImage,
          key: args.key,
        )),
        customRouteBuilder: _i8.fadeRouteBuilder,
        opaque: true,
        barrierDismissible: false,
      );
    },
    CameraRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.CameraPage(),
        customRouteBuilder: _i8.circleEdgeRouteBuilder,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MainRoute.name: (routeData) {
      final args =
          routeData.argsAs<MainRouteArgs>(orElse: () => const MainRouteArgs());
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.MainPage(key: args.key),
        customRouteBuilder: _i8.circleEdgeRouteBuilder,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AnalyticsRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.AnalyticsPage(),
        customRouteBuilder: _i8.fadeRouteBuilder,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          RootRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              MainRoute.name,
              path: 'main-page',
              parent: RootRoute.name,
            ),
            _i6.RouteConfig(
              AnalyticsRoute.name,
              path: 'analytics-page',
              parent: RootRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          ReceiptConfirmRoute.name,
          path: '/receipt-confirm-page',
        ),
        _i6.RouteConfig(
          CameraRoute.name,
          path: '/camera-page',
        ),
      ];
}

/// generated route for
/// [_i1.RootPage]
class RootRoute extends _i6.PageRouteInfo<RootRouteArgs> {
  RootRoute({
    _i7.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          RootRoute.name,
          path: '/',
          args: RootRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RootRoute';
}

class RootRouteArgs {
  const RootRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'RootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.ReceiptConfirmPage]
class ReceiptConfirmRoute extends _i6.PageRouteInfo<ReceiptConfirmRouteArgs> {
  ReceiptConfirmRoute({
    required _i9.RecognizedText recognizedText,
    required _i9.InputImage inputImage,
    _i7.Key? key,
  }) : super(
          ReceiptConfirmRoute.name,
          path: '/receipt-confirm-page',
          args: ReceiptConfirmRouteArgs(
            recognizedText: recognizedText,
            inputImage: inputImage,
            key: key,
          ),
        );

  static const String name = 'ReceiptConfirmRoute';
}

class ReceiptConfirmRouteArgs {
  const ReceiptConfirmRouteArgs({
    required this.recognizedText,
    required this.inputImage,
    this.key,
  });

  final _i9.RecognizedText recognizedText;

  final _i9.InputImage inputImage;

  final _i7.Key? key;

  @override
  String toString() {
    return 'ReceiptConfirmRouteArgs{recognizedText: $recognizedText, inputImage: $inputImage, key: $key}';
  }
}

/// generated route for
/// [_i3.CameraPage]
class CameraRoute extends _i6.PageRouteInfo<void> {
  const CameraRoute()
      : super(
          CameraRoute.name,
          path: '/camera-page',
        );

  static const String name = 'CameraRoute';
}

/// generated route for
/// [_i4.MainPage]
class MainRoute extends _i6.PageRouteInfo<MainRouteArgs> {
  MainRoute({_i7.Key? key})
      : super(
          MainRoute.name,
          path: 'main-page',
          args: MainRouteArgs(key: key),
        );

  static const String name = 'MainRoute';
}

class MainRouteArgs {
  const MainRouteArgs({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.AnalyticsPage]
class AnalyticsRoute extends _i6.PageRouteInfo<void> {
  const AnalyticsRoute()
      : super(
          AnalyticsRoute.name,
          path: 'analytics-page',
        );

  static const String name = 'AnalyticsRoute';
}
