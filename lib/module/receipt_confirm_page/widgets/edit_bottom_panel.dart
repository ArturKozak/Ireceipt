import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditableReceiptText extends StatefulWidget {
  final String text;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextInputType? textInput;

  const EditableReceiptText({
    required this.text,
    super.key,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.textStyle,
    this.textAlign,
    this.textInput,
  });

  @override
  _EditableReceiptTextState createState() => _EditableReceiptTextState();
}

class _EditableReceiptTextState extends State<EditableReceiptText> {
  late final FocusNode? focusNode;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    focusNode = widget.focusNode ?? FocusNode();

    focusNode?.addListener(_rebuildWidget);

    controller = TextEditingController(text: widget.text);
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

    final backgroundColor = hasFocus ? scheme.onPrimary : scheme.background;

    return Center(
      child: EditableText(
        controller: controller,
        focusNode: focusNode!,
        style: widget.textStyle ??
            GoogleFonts.lato(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w600,
              color: scheme.onSecondaryContainer,
            ),
        cursorColor: scheme.primary,
        backgroundCursorColor: backgroundColor,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign ?? TextAlign.start,
        onSubmitted: widget.onSubmitted,
        keyboardType: widget.textInput,
      ),
    );
  }
}
