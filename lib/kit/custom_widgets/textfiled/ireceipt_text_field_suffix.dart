import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IreceiptTextFieldSuffix extends StatefulWidget {
  final Color? suffixIconColor;
  final TextEditingController? controller;
  final VoidCallback? onSuffixPressed;
  final VoidCallback? onAdditionalClearSuffixPressed;
  final bool canBeClearButton;

  const IreceiptTextFieldSuffix({
    super.key,
    this.suffixIconColor,
    this.controller,
    this.onSuffixPressed,
    this.onAdditionalClearSuffixPressed,
    this.canBeClearButton = false,
  });

  @override
  _IreceiptTextFieldSuffixState createState() =>
      _IreceiptTextFieldSuffixState();
}

class _IreceiptTextFieldSuffixState extends State<IreceiptTextFieldSuffix> {
  late final TextEditingController? controller;
  late final FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    _initController();

    if (!widget.canBeClearButton) {
      return;
    }

    controller?.addListener(() {
      setState(_rebuildWidget);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller?.dispose();
    }

    super.dispose();
  }

  void _initController() {
    if (!widget.canBeClearButton) {
      controller = null;

      return;
    }

    controller = widget.controller ?? TextEditingController();
  }

  void _rebuildWidget() {
    setState(() {/* Nothing to do */});
  }

  @override
  Widget build(BuildContext context) {
    final clearButtonEnabled =
        widget.canBeClearButton && (controller?.text.isNotEmpty ?? false);

    final suffixAssetName = clearButtonEnabled ? FontAwesomeIcons.broom : null;

    if (suffixAssetName == null) {
      return const SizedBox();
    }

    final scheme = Theme.of(context).colorScheme;

    final suffixOnTap =
        widget.canBeClearButton ? controller!.clear : widget.onSuffixPressed;

    return IconButton(
      onPressed: widget.onAdditionalClearSuffixPressed ?? suffixOnTap,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 13.0).r,
      icon: FaIcon(
        suffixAssetName,
        size: 14.r,
        color: widget.suffixIconColor ?? scheme.secondaryContainer,
      ),
    );
  }
}
