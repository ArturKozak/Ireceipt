import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/kit/custom_widgets/textfiled/ireceipt_text_field_suffix.dart';

class IreceiptTextField extends StatefulWidget {
  final Color? foregroundColor;
  final Color? hintColor;
  final Color? fillColor;
  final Color? focusColor;
  final Function(String)? onChanged;
  final Color? suffixIconColor;
  final BoxConstraints? suffixIconConstraints;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final double? textSize;
  final double? borderRadius;
  final VoidCallback? onSuffixPressed;
  final VoidCallback? onAdditionalClearSuffixPressed;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool showClearButton;
  final bool respondToFocusChanges;
  final TextInputType? keyboardType;

  const IreceiptTextField({
    super.key,
    this.foregroundColor,
    this.hintColor,
    this.fillColor,
    this.focusColor,
    this.suffixIconColor,
    this.suffixIconConstraints,
    this.hintText,
    this.contentPadding,
    this.textSize,
    this.borderRadius,
    this.onSuffixPressed,
    this.textInputAction,
    this.onSubmitted,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.keyboardType,
    this.onAdditionalClearSuffixPressed,
    this.showClearButton = false,
    this.respondToFocusChanges = false,
  });

  @override
  _IreceiptTextFieldState createState() => _IreceiptTextFieldState();
}

class _IreceiptTextFieldState extends State<IreceiptTextField> {
  static const _contentPadding = 20.0;

  late final FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = widget.focusNode ?? FocusNode();

    if (widget.respondToFocusChanges) {
      focusNode?.addListener(_rebuildWidget);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode?.dispose();
    }

    super.dispose();
  }

  void _rebuildWidget() {
    setState(() {/* Nothing to do */});
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final hasFocus = focusNode?.hasFocus ?? false;
    final contentPadding = widget.contentPadding ??
        const EdgeInsets.only(
          left: _contentPadding,
          top: _contentPadding,
          bottom: _contentPadding,
        ).r;

    final backgroundColor = hasFocus && widget.respondToFocusChanges
        ? widget.focusColor ?? scheme.background
        : widget.fillColor ?? scheme.onSecondaryContainer;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadius ?? 16.0),
        ).r,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF575757).withOpacity(0.2),
            spreadRadius: hasFocus && widget.respondToFocusChanges ? 0.5 : 0.0,
            blurRadius: hasFocus && widget.respondToFocusChanges ? 10.0 : 0.0,
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: focusNode,
        textInputAction: widget.textInputAction,
        textAlignVertical: TextAlignVertical.center,
        onSubmitted: widget.onSubmitted,
        style: TextStyle(
          color: widget.foregroundColor ?? scheme.primary,
          fontSize: widget.textSize?.sp ?? 16.0.sp,
        ),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgroundColor,
          hintText: widget.hintText,
          suffixIcon: IreceiptTextFieldSuffix(
            suffixIconColor: widget.suffixIconColor,
            controller: widget.controller,
            onSuffixPressed: widget.onSuffixPressed,
            canBeClearButton: widget.showClearButton,
            onAdditionalClearSuffixPressed:
                widget.onAdditionalClearSuffixPressed,
          ),
          contentPadding: contentPadding,
          hintStyle: TextStyle(
            color: widget.hintColor ?? scheme.secondary,
            fontSize: widget.textSize?.sp ?? 16.0.sp,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(
                widget.borderRadius ?? 16.0,
              ).r,
            ),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
