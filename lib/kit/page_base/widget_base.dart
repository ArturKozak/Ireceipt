import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class WidgetBase extends StatelessWidget {
  const WidgetBase({super.key});

  Widget body(BuildContext context, ColorScheme scheme, Size size);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return body(context, scheme, size);
  }
}
