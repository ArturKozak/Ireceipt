import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ireceipt/module/analytics_page/analytics_page.dart';
import 'package:ireceipt/module/camera_page/camera_page.dart';
import 'package:ireceipt/module/main_page/main_page.dart';
import 'package:ireceipt/module/receipt_confirm_page/receipt_confirm_page.dart';
import 'package:ireceipt/module/root_page/root_page.dart';

typedef CustomRouteBuilder = AutoRoute<T> Function<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
);

Route<T> fadeRouteBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return PageRouteBuilder(
    fullscreenDialog: page.fullscreenDialog,
    settings: page,
    pageBuilder: (context, animation, secondaryAnimation) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return FadeTransition(
        opacity: curvedAnimation,
        child: child,
      );
    },
  );
}

Route<T> circleEdgeRouteBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return PageRouteBuilder(
    fullscreenDialog: page.fullscreenDialog,
    settings: page,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: const Duration(seconds: 1),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    CustomRoute(
      page: RootPage,
      initial: true,
      customRouteBuilder: fadeRouteBuilder,
      children: [
        CustomRoute(
          page: MainPage,
          customRouteBuilder: circleEdgeRouteBuilder,
        ),
        CustomRoute(
          page: AnalyticsPage,
          customRouteBuilder: fadeRouteBuilder,
        ),
      ],
    ),
    CustomRoute(
      page: ReceiptConfirmPage,
      customRouteBuilder: fadeRouteBuilder,
    ),
    CustomRoute(
      page: CameraPage,
      customRouteBuilder: circleEdgeRouteBuilder,
    ),
  ],
)
class $AppRouter {}
