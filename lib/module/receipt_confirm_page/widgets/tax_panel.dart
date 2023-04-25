import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/data/repo/product_name_repository.dart';
import 'package:ireceipt/kit/page_base/widget_base.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';
import 'package:ireceipt/util/app_constants.dart';

class TaxPanel extends WidgetBase {
  static final _buttonHeight = 50.0.h;
  static final _textHorizontalSpace = 10.horizontalSpace;

  final ReceiptConfirmCompleted state;

  const TaxPanel({
    required this.state,
    super.key,
  });

  @override
  Widget body(BuildContext context, ColorScheme scheme, Size size) {
    return Container(
      height: 0.33.sh,
      padding: EdgeInsets.all(AppConstants.padding).r,
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.padding),
          topRight: Radius.circular(AppConstants.padding),
        ).r,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.taxList!.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.taxList![index].name.trim(),
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                  _textHorizontalSpace,
                  Text(
                    state.taxList![index].totalCost.toString(),
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _buttonHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.padding,
                ).r,
                decoration: BoxDecoration(
                  color: scheme.background,
                  borderRadius: BorderRadius.circular(AppConstants.padding).r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suma PLN:',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.w600,
                        color: scheme.primary,
                      ),
                    ),
                    _textHorizontalSpace,
                    Text(
                      state.totalSum.toString(),
                      style: TextStyle(
                        fontSize: 22.0.sp,
                        fontWeight: FontWeight.w600,
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => context
                    .read<ProductNameRepository>()
                    .addClearName(state.groupedProduct),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.padding,
                  ).r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.padding).r,
                  ),
                ),
                child: Container(
                  height: _buttonHeight,
                  alignment: Alignment.center,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
