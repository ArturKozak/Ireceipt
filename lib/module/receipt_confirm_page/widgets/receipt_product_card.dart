import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';
import 'package:ireceipt/module/receipt_confirm_page/widgets/edit_bottom_panel.dart';
import 'package:ireceipt/util/app_constants.dart';

class ReceiptProductCard extends WidgetBase {
  static const _borderRadius = 50.0;
  static const _editTextSize = 30.0;
  static final _rightPosition = 10.0.w;

  final ReceiptProductModel receiptProductModel;
  final Animation<double> animation;
  final VoidCallback onTap;
  final ReceiptConfirmCompleted state;

  const ReceiptProductCard({
    required this.receiptProductModel,
    required this.animation,
    required this.onTap,
    required this.state,
    super.key,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
        child: Stack(
          children: [
            Container(
              color: scheme.background,
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.padding / 2,
                vertical: AppConstants.padding / 2,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.padding / 2,
                ).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppConstants.padding / 2,
                            left: AppConstants.padding / 2,
                            right: AppConstants.padding / 2,
                          ).r,
                          child: Container(
                            width: _borderRadius.w,
                            height: _borderRadius.h,
                            decoration: BoxDecoration(
                              color: scheme.onSecondaryContainer,
                              borderRadius:
                                  BorderRadius.circular(_borderRadius / 4).r,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: _editTextSize.w,
                                child: EditableReceiptText(
                                  text: receiptProductModel.cattegory ?? '',
                                  textAlign: TextAlign.center,
                                  textStyle: GoogleFonts.dhurjati(
                                    fontSize: 22.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: scheme.background,
                                  ),
                                  textInput: TextInputType.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: EditableReceiptText(
                                  text: receiptProductModel.name,
                                  onSubmitted: (value) => context
                                      .read<ReceiptConfirmCubit>()
                                      .updateText(
                                        state,
                                        value,
                                        receiptProductModel.name,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: EditableReceiptText(
                                  text: receiptProductModel.quantity.toString(),
                                  textStyle: GoogleFonts.dhurjati(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w700,
                                    color: scheme.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.padding,
                          ).r,
                          child: SizedBox(
                            width: _editTextSize.w * 2,
                            child: EditableReceiptText(
                              text: receiptProductModel.totalCost.toString(),
                              textAlign: TextAlign.end,
                              textStyle: GoogleFonts.dhurjati(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: scheme.onSecondaryContainer,
                              ),
                              textInput: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (receiptProductModel.discondModel != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppConstants.padding + _borderRadius,
                          right: AppConstants.padding,
                        ).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: _editTextSize.w * 2,
                              child: EditableReceiptText(
                                text: receiptProductModel.discondModel!.name,
                                onSubmitted: (value) => context
                                    .read<ReceiptConfirmCubit>()
                                    .updateText(
                                      state,
                                      value,
                                      receiptProductModel.name,
                                    ),
                                textStyle: GoogleFonts.lato(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: scheme.secondary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _editTextSize.w * 2,
                              child: EditableReceiptText(
                                text: receiptProductModel
                                    .discondModel!.totalCost
                                    .toString(),
                                textAlign: TextAlign.end,
                                textStyle: GoogleFonts.dhurjati(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: scheme.secondary,
                                ),
                                textInput: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: _rightPosition,
              child: IconButton(
                onPressed: onTap,
                icon: FaIcon(
                  FontAwesomeIcons.trash,
                  size: 16.r,
                  color: scheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
