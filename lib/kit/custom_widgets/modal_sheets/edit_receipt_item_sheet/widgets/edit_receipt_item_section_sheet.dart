import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireceipt/kit/custom_widgets/textfiled/ireceipt_textfield.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';

class EditReceiptItemSectionSheet extends WidgetBase {
  static const _pagePadding = 16.0;
  static const _titleLeftPadding = 7.0;

  static final _sectionHeaderSpacing = 8.0.verticalSpace;

  final TextEditingController controller;
  final FocusNode node;
  final VoidCallback onSubmitted;
  final VoidCallback onSuffixPressed;
  final String sectionName;
  final String hintName;
  final TextInputType? keyboardType;
  final double? textFieldWidth;

  const EditReceiptItemSectionSheet({
    required this.sectionName,
    required this.hintName,
    required this.controller,
    required this.node,
    required this.onSubmitted,
    required this.onSuffixPressed,
    this.keyboardType,
    this.textFieldWidth,
    super.key,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return SizedBox(
      width: textFieldWidth,
      height: 100.0.h,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: _pagePadding + _titleLeftPadding,
            ).r,
            child: Text(
              sectionName,
              style: GoogleFonts.dhurjati(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
                color: scheme.primary,
              ),
            ),
          ),
          _sectionHeaderSpacing,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _pagePadding,
              ).r,
              child: IreceiptTextField(
                hintText: hintName,
                controller: controller,
                focusNode: node,
                showClearButton: true,
                respondToFocusChanges: true,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onSubmitted.call(),
                onSuffixPressed: onSuffixPressed,
                keyboardType: keyboardType,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
