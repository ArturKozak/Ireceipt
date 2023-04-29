import 'package:collection/collection.dart';
import 'package:ireceipt/app/base/configuration_base.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/tax_model/tax_model.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:super_string/super_string.dart';

class PlCofiguration extends ConfigurationBase {
  static const _vatParamsName = [
    'SPRZEDAŻ OPODATKOWANA A',
    'SPRZEDAŻ OPODATKOWANA B',
    'SPRZEDAŻ OPODATKOWANA D',
    'PTU A 23.0%',
    'PTU B 8.0%',
    'PTU D 0.0%',
    'KWOTA',
    'SUMA PTU',
  ];

  static const _costCategoryExpKey = 'costCategoryExp';
  static const _dateExpKey = 'dateExp';
  static const _adressExpKey = 'adressExp';
  static const _streetExpKey = 'streetExp';
  static const _discondExpKey = 'discondExp';
  static const _categoryExpKey = 'categoryExp';
  static const _numCategoryExpKey = 'numCategoryExp';
  static const _spaceExpKey = 'spaceExp';
  static const _numExpKey = 'numExp';
  static const _quantityExpKey = 'quantityExp';
  static const _quantityTwoExpKey = 'quantityTwoExp';

  @override
  List<RegExp> get totalCostParams => [
        RegExp(r'23,00'),
        RegExp(r'8,00'),
      ];

  @override
  RegExp? get generalCostExp => RegExp(r'([0-9]{1,4}(\,|\.)\s?[0-9]{1,5})');

  @override
  Map<String, RegExp> get receiptParams => {
        _costCategoryExpKey: RegExp(r'([0-9]{1,3}\,\s?[0-9]{2}\s?[ABD])'),
        _dateExpKey:
            RegExp(r'[0-9]{1,4}\-[0-9]{2}\-[0-9]{2}\s[0-9]{2}\:[0-9]{2}'),
        _adressExpKey: RegExp(r'([Aa][Dd][Rr][Ee][Ss])'),
        _categoryExpKey: RegExp(r'\s?[ABD]\s?'),
        _discondExpKey: RegExp(r'([Rr][Aa][Bb][Aa][Tt])'),
        _numCategoryExpKey: RegExp(r'[0-9][ABD]\s?'),
        _quantityExpKey: RegExp(
          r'[0-9]\,?\s?[0-9]?[0-9]?[0-9]?\s?[a-z][0-9]{1,3}\s?\,\s?[0-9]{1,3}',
        ),
        _quantityTwoExpKey: RegExp(
          r'[0-9]\,?\s?[0-9]?[0-9]?[0-9]?\s?\*\s?[0-9]{1,3}\s?\,\s?[0-9]{1,3}',
        ),
        _streetExpKey: RegExp(r'([Uu][Ll]\.\s?)'),
        _spaceExpKey: RegExp(r'\sx\s'),
        _numExpKey: RegExp(r'\s[0-9]{1,15}'),
      };

  TaxModel? _getBestMatchForVat(String text) {
    final raring = <double, String>{};

    for (final element in _vatParamsName) {
      final similarity = text.similarityTo(element);

      raring.addAll({similarity: element});
    }

    final maxValue = raring.keys.max;

    final bestMathName = raring[maxValue]!;

    if (maxValue < 0.29) {
      return null;
    }

    final moneyMatch = generalCostExp!.hasMatch(text);

    if (moneyMatch) {
      final match = generalCostExp!.stringMatch(text);

      final lineCost = getPrice(match);

      final model = TaxModel(name: bestMathName, totalCost: lineCost);

      return model;
    }

    return TaxModel(name: bestMathName);
  }

  @override
  List<TaxModel> getTax(List<String> lines) {
    final taxList = <TaxModel>[];

    for (final line in lines) {
      final text = line;

      final model = _getBestMatchForVat(text);

      if (model == null) {
        continue;
      }

      taxList.add(model);
    }

    return taxList;
  }

  @override
  List<ReceiptProductModel> getProducts(List<String> list) {
    final productList = <ReceiptProductModel>[];

    for (var i = 0; i < list.length; i++) {
      final text = list[i];

      final moneyMatch = generalCostExp!.hasMatch(text);
      final quantityMatch = receiptParams[_quantityExpKey]!.hasMatch(text);
      final quantityTwoMatch =
          receiptParams[_quantityTwoExpKey]!.hasMatch(text);

      if (moneyMatch && (quantityMatch || quantityTwoMatch)) {
        String? category;

        final match = generalCostExp!.stringMatch(text);

        final matchCategory =
            receiptParams[_costCategoryExpKey]!.stringMatch(text);

        if (matchCategory != null) {
          category = matchCategory[matchCategory.length - 1];
        }

        category ??= receiptParams[_categoryExpKey]!.stringMatch(text);

        final lineCost = getPrice(match);

        if (lineCost == null) {
          continue;
        }

        late String? scannedQuantity;

        scannedQuantity = receiptParams[_quantityExpKey]!.stringMatch(text);

        scannedQuantity ??=
            receiptParams[_quantityTwoExpKey]!.stringMatch(text);

        final textInt = convertProductName(
          text,
          [
            generalCostExp!,
            receiptParams[_spaceExpKey]!,
            receiptParams[_numExpKey]!,
            receiptParams[_quantityExpKey]!,
            receiptParams[_quantityTwoExpKey]!,
            receiptParams[_costCategoryExpKey]!,
          ],
        );

        final model = ReceiptProductModel(
          name: textInt,
          totalCost: lineCost,
          quantity: scannedQuantity,
          cattegory: category,
        );

        if (model.name.isEmpty) {
          continue;
        }

        if (model.name.isAlNum) {
          continue;
        }

        if (model.name.startsWith(generalCostExp!)) {
          continue;
        }

        productList.add(model);
      }
    }

    return productList;
  }
}
