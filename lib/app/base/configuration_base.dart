import 'package:flutter/material.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/tax_model/tax_model.dart';

abstract class ConfigurationBase {
  static final _commasSpaceExp = RegExp(r',\s');
  static final _letterSExp = RegExp(r'[A-Z]');
  static final _allSpaceExp = RegExp(r'\s+');
  static final _nonLetterExp = RegExp(r'[!$%^&*()_+|~=`\-{}\[\]:\/;<>\s?,@#]');

  @protected
  final receiptParams = <String, RegExp>{};

  final totalCostParams = <RegExp>[];

  RegExp? get generalCostExp => null;

  ConfigurationBase();

  double? getPrice(String? match) {
    if (match == null) {
      return null;
    }

    final spacedText = match.replaceAll(_commasSpaceExp, '.');

    final convertText = spacedText.replaceAll(_letterSExp, '');

    final specSymbols = convertText.replaceAll(_nonLetterExp, '');

    final unSpacedNum = specSymbols.replaceAll(_allSpaceExp, '');

    if (unSpacedNum.isEmpty) {
      return null;
    }

    if (unSpacedNum == 'null') {
      return null;
    }

    return double.parse(unSpacedNum);
  }

  @protected
  String convertProductName(String text, List<RegExp> params) {
    String textResult = text;

    for (final element in params) {
      final replacedText = textResult.replaceAll(element, '');

      textResult = replacedText;
    }

    return textResult;
  }

  List<TaxModel> getTax(List<String> lines);

  List<ReceiptProductModel> getProducts(List<String> list);
}
