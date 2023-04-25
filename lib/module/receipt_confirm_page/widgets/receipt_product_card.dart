import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';
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
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.padding / 2,
                vertical: AppConstants.padding / 2,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.padding / 2,
              ).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.padding),
                ).r,
              ),
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
                          bottom: AppConstants.padding / 2,
                        ).r,
                        child: Container(
                          width: _borderRadius.w,
                          height: _borderRadius.h,
                          decoration: BoxDecoration(
                            color: scheme.onSecondaryContainer,
                            borderRadius:
                                BorderRadius.circular(_borderRadius / 4).r,
                            boxShadow: [AppConstants.boxShadowMain],
                          ),
                          child: Center(
                            child: SizedBox(
                              width: _editTextSize.w,
                              child: Text(
                                receiptProductModel.cattegory ?? '',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dhurjati(
                                  fontSize: 22.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.primary,
                                ),
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
                              child: Text(
                                receiptProductModel.name,
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: scheme.primary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                receiptProductModel.quantity.toString(),
                                style: GoogleFonts.dhurjati(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w700,
                                  color: scheme.primary,
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
                          child: Text(
                            receiptProductModel.totalCost.toString(),
                            textAlign: TextAlign.end,
                            style: GoogleFonts.dhurjati(
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                              color: scheme.primary,
                            ),
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
                            child: Text(
                              receiptProductModel.discondModel!.name,
                              style: GoogleFonts.lato(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _editTextSize.w * 2,
                            child: Text(
                              receiptProductModel.discondModel!.totalCost
                                  .toString(),
                              textAlign: TextAlign.end,
                              style: GoogleFonts.dhurjati(
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
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
