import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/app/base/configuration_base.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/tax_model/tax_model.dart';
import 'package:ireceipt/module/base/receipt_confirm_base.dart';
import 'package:ireceipt/util/valut.dart';

part 'receipt_confirm_state.dart';

class ReceiptConfirmCubit extends ReceiptConfirmBase {
  late final ConfigurationBase _configuration;

  ReceiptConfirmCubit(super.productNameRepository);

  @override
  Future<void> init(RecognizedText recognizedText) async {
    _configuration = Valut.configuration;

    final lineTextList = getText(recognizedText);

    final alignTextLines = alignTextLine(lineTextList);

    final groupedText = getGroupText(alignTextLines);

    final totalSum = getTotal(
      lineTextList,
      _configuration.generalCostExp!,
      _configuration.totalCostParams,
      _configuration.getPrice,
    );

    final products = _configuration.getProducts(groupedText);

    final taxList = _configuration.getTax(groupedText);

    final replacedProduct = await bestMatch(products);

    emit(
      ReceiptConfirmCompleted(
        groupedProduct: replacedProduct,
        totalSum: totalSum,
        taxList: taxList,
      ),
    );
  }
}
