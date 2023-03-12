import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';

abstract class ReceiptPageBase extends WidgetBase implements AutoRouteWrapper {
  const ReceiptPageBase({super.key});

  @protected
  Widget readyContent(
    BuildContext context,
    ColorScheme scheme,
    Size? size,
  );

  @override
  @nonVirtual
  Widget body(BuildContext context, ColorScheme scheme, Size? size) {
    return readyContent(context, scheme, size);
  }
}
