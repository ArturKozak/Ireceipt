import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/data/models/discond_model/discond_model.dart';
import 'package:ireceipt/data/models/product_name_model.dart/product_name_model.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/tax_model/tax_model.dart';
import 'package:ireceipt/data/models/word_box_model/word_box_model.dart';
import 'package:ireceipt/data/repo/product_name_repository.dart';
import 'package:ireceipt/module/receipt_confirm_page/widgets/receipt_product_card.dart';
import 'package:ireceipt/util/app_constants.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:super_string/super_string.dart';

part 'receipt_confirm_state.dart';

class ReceiptConfirmCubit extends Cubit<ReceiptConfirmState> {
  final ProductNameRepository _productNameRepository;

  final listKey = GlobalKey<AnimatedListState>();

  ReceiptConfirmCubit(this._productNameRepository)
      : super(ReceiptConfirmInitial());

  List<TextLine> _getText(RecognizedText recognizedText) {
    final lines = <TextLine>[];

    for (final block in recognizedText.blocks) {
      lines.addAll(block.lines);
    }

    lines.sort(
      (a, b) => a.boundingBox.top.compareTo(b.boundingBox.top),
    );

    return lines;
  }

  List<TextLine> _getOnlyNeddedLine(List<TextLine> items) {
    final sortedList = <TextLine>[];

    for (final item in items) {
      if (AppConstants.drExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.adresExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.nipExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.spExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.paragonExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.spExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.kartaExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.ulExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.nrExp.hasMatch(item.text)) {
        continue;
      }

      if (AppConstants.nrSpaceExp.hasMatch(item.text)) {
        continue;
      }

      sortedList.add(item);
    }

    return sortedList;
  }

  List<WordBox> _alignTextLine(List<TextLine> sortedList) {
    final wordBoxList = <WordBox>[];

    for (final item in sortedList) {
      final cornetPoints = <Point<int>>[];

      cornetPoints.addAll(item.cornerPoints);

      final topLeft = cornetPoints[0];
      final topRight = cornetPoints[1];
      final bottomRight = cornetPoints[2];
      final bottomLeft = cornetPoints[3];

      final differently = (topLeft.y - topRight.y).abs();

      Point<int> fixedTopLeft;
      Point<int> fixedTopRight;

      if (topLeft.y > topRight.y) {
        fixedTopLeft = Point(topLeft.x, topLeft.y - differently ~/ 2) * 10;
        fixedTopRight = Point(topRight.x, topRight.y + differently ~/ 2) * 10;
      } else {
        fixedTopLeft = Point(topLeft.x, topLeft.y + differently ~/ 2) * 10;
        fixedTopRight = Point(topRight.x, topRight.y - differently ~/ 2) * 10;
      }

      final fixedPoints = [
        fixedTopLeft,
        fixedTopRight,
        bottomRight,
        bottomLeft
      ];

      final wordBox = WordBox(
        item.text,
        fixedPoints,
        item.boundingBox,
      );

      wordBoxList.add(wordBox);
    }

    return wordBoxList;
  }

  List<Widget> _getPositionedLine(List<WordBox> wordBoxList) {
    final list = <Widget>[];

    for (final item in wordBoxList) {
      final widget = Positioned(
        top: ((item.vertices.first.y) - 150) < 0
            ? 20
            : ((item.vertices.first.y / 6) - 150),
        left: item.boundingBox.left / 10 > 100 ? item.boundingBox.left / 9 : 20,
        bottom: item.vertices.last.y / 10,
        child: Text(
          item.text,
          style: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      );

      list.add(widget);
    }

    return list;
  }

  List<String> _getGroupText(List<WordBox> wordBoxList) {
    final compireText = <String>[];

    for (final wordBox in wordBoxList) {
      final lineList = <String>[];

      lineList.add(wordBox.text);

      for (var i = 0; i < wordBoxList.length; i++) {
        if (wordBox.text == wordBoxList[i].text) {
          continue;
        }

        final itemTop = wordBoxList[i].vertices.first.y;

        final textLineTop = wordBox.vertices.first.y;

        final defferently = itemTop / textLineTop;

        if (i > 1 && lineList.contains(wordBoxList[i - 1].text)) {
          continue;
        }

        if (defferently > 0.98 && defferently <= 1.01) {
          lineList.add(wordBoxList[i].text);
        }
      }

      if (lineList.length <= 1) {
        continue;
      }

      final e = lineList.reduce((value, element) => '$value $element');

      compireText.add(e);
    }

    return compireText;
  }

  double? _getPrice(String? match) {
    if (match == 'null') {
      return null;
    }

    if (match == null) {
      return null;
    }

    if (match.isEmpty) {
      return null;
    }

    final convertText = match.replaceAll(RegExp(r',\s?'), '.');

    if (convertText.contains(RegExp(r'[A-Z]'))) {
      return null;
    }

    if (convertText.contains('x')) {
      return null;
    }

    final unSpacedNum = convertText.replaceAll(RegExp(r'\s+'), '');

    return double.parse(unSpacedNum);
  }

  double _getTotal(List<TextLine> lines) {
    double scanTotal = 0;

    final moneyExp = AppConstants.moneyExp;

    for (final line in lines) {
      final text = line.text;

      if (moneyExp.hasMatch(text)) {
        var match = moneyExp.stringMatch(text);

        if (match == 'null') {
          continue;
        }

        if (match == null) {
          continue;
        }

        if (match.isEmpty) {
          continue;
        }

        if (match.contains('23,00')) {
          final reText = text.replaceAll(match, '');

          match = AppConstants.moneyExp.stringMatch(reText).toString();
        }

        final lineCost = _getPrice(match);

        if (lineCost == null) {
          continue;
        }

        if (lineCost > scanTotal) {
          scanTotal = lineCost;
        }
      }
    }

    return scanTotal;
  }

  List<TaxModel> _getTax(List<String> lines) {
    final taxList = <TaxModel>[];

    for (final line in lines) {
      final text = line;

      if (AppConstants.spredExp.hasMatch(text)) {
        final match = AppConstants.moneyExp.stringMatch(text);

        final lineCost = _getPrice(match);

        if (lineCost == null) {
          continue;
        }

        final convertedText = text.replaceAll(AppConstants.moneyExp, '');

        final grammaText = convertedText.replaceAll('0', 'O');

        final model = TaxModel(name: grammaText, totalCost: lineCost);

        taxList.add(model);
      }
    }

    for (final line in lines) {
      final text = line;

      if (AppConstants.ptuExp.hasMatch(text) ||
          AppConstants.kwotaExp.hasMatch(text)) {
        var match = AppConstants.moneyExp.stringMatch(text);

        if (match == 'null') {
          continue;
        }

        if (match == null) {
          continue;
        }

        if (match.isEmpty) {
          continue;
        }

        if (match.contains('23,00')) {
          final reText = text.replaceAll(match, '');

          match = AppConstants.moneyExp.stringMatch(reText).toString();
        }

        if (match.contains('8,00')) {
          final reText = text.replaceAll(match, '');

          match = AppConstants.moneyExp.stringMatch(reText).toString();
        }

        final lineCost = _getPrice(match);

        if (lineCost == null) {
          continue;
        }

        final convertedText = text.replaceAll(AppConstants.moneyExp, '');

        final model = TaxModel(name: convertedText, totalCost: lineCost);

        taxList.add(model);
      }
    }

    for (final line in lines) {
      final text = line;

      if (AppConstants.ptuSumExp.hasMatch(text) ||
          AppConstants.podatekSumExp.hasMatch(text)) {
        final match = AppConstants.moneyExp.stringMatch(text);

        final lineCost = _getPrice(match);

        if (lineCost == null) {
          continue;
        }

        final convertedText = text.replaceAll(AppConstants.moneyExp, '');

        final model = TaxModel(name: convertedText, totalCost: lineCost);

        taxList.add(model);
      }
    }

    return taxList;
  }

  DiscondModel? _getDiscondProduct(String text) {
    final moneyMatch = AppConstants.moneyExp.hasMatch(text);

    if (moneyMatch) {
      final match = AppConstants.moneyExp.stringMatch(text);

      final lineCost = _getPrice(match);

      if (lineCost == null) {
        return null;
      }

      final convertedText = 'Rabat';

      return DiscondModel(
        name: convertedText,
        totalCost: lineCost,
        cattegory: 'A',
      );
    }

    return null;
  }

  String _convertProductName(String text) {
    final exprText = text.replaceAll(AppConstants.moneyExp, '')
      ..replaceAll(AppConstants.quantityExp, '');

    final spacerText = exprText.replaceAll(RegExp(r'\sx\s'), '');

    final categoryText = spacerText.replaceAll(AppConstants.categoryExp, '');

    final numText = categoryText.replaceAll(AppConstants.numCategoryExp, '');

    final unNumText = numText.replaceAll(RegExp(r'\s[0-9]{1,15}'), '');

    return unNumText;
  }

  List<ReceiptProductModel> _getProducts(List<String> list) {
    final productList = <ReceiptProductModel>[];

    for (var i = 0; i < list.length; i++) {
      final text = list[i];

      final moneyMatch = AppConstants.moneyExp.hasMatch(text);
      final quantityMatch = AppConstants.quantityExp.hasMatch(text);
      final quantityTwoMatch = AppConstants.quantityTwoExp.hasMatch(text);

      if (moneyMatch && (quantityMatch || quantityTwoMatch)) {
        String? category;

        final match = AppConstants.moneyExp.stringMatch(text);

        final matchCategory = AppConstants.moneyCategoryExp.stringMatch(text);

        if (matchCategory != null) {
          category = matchCategory[matchCategory.length - 1];
        }

        final lineCost = _getPrice(match);

        if (lineCost == null) {
          continue;
        }

        DiscondModel? discondModel;

        if (list[i + 1].contains(AppConstants.rabatExp) &&
            i + 1 < list.length) {
          discondModel = _getDiscondProduct(list[i + 1]);
        }

        late String? scannedQuantity;

        scannedQuantity = AppConstants.quantityExp.stringMatch(text);

        scannedQuantity ??= AppConstants.quantityTwoExp.stringMatch(text);

        final textInt = _convertProductName(text);

        category ??= AppConstants.categoryExp.stringMatch(text);

        final model = ReceiptProductModel(
          name: textInt,
          totalCost: lineCost,
          quantity: scannedQuantity,
          cattegory: category,
          discondModel: discondModel,
        );

        if (model.name.isEmpty) {
          continue;
        }

        if (model.name.isAlNum) {
          continue;
        }

        if (model.name.startsWith(RegExp(r'[0-9]{1,4}\s?[0-9]{1,5}'))) {
          continue;
        }

        productList.add(model);
      }
    }

    return productList;
  }

  Future<List<ReceiptProductModel>> _bestMatch(
    List<ReceiptProductModel> list,
  ) async {
    final replacedNameList = <ReceiptProductModel>[];

    await _productNameRepository.ensureInitialized;

    for (final item in list) {
      final raring = <double, ProductNameModel>{};

      for (final element in _productNameRepository.productList) {
        final similarity = item.name.similarityTo(element.name);

        raring.addAll({similarity: element});
      }

      final maxValue = raring.keys.max;

      final replacedName = raring[maxValue]!.name;

      if (maxValue < 0.29) {
        replacedNameList.add(item);

        continue;
      }

      final newItem = item.copyWith(name: replacedName);

      replacedNameList.add(newItem);
    }

    return replacedNameList;
  }

  Future<void> deleteProduct(
    int index,
    ReceiptConfirmCompleted state,
  ) async {
    final model = state.groupedProduct.removeAt(index);

    HapticFeedback.vibrate();

    state.copyWith(groupedProduct: state.groupedProduct);

    listKey.currentState!.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return buildReceiptCard(model, state, index, animation);
      },
      duration: AppConstants.halfAnimDuration,
    );
  }

  Future<void> updateText(
    ReceiptConfirmCompleted state,
    String newText,
    String oldText,
  ) async {
    final model =
        state.groupedProduct.singleWhere((element) => element.name == oldText);

    final index =
        state.groupedProduct.indexWhere((element) => element.name == oldText);

    state.groupedProduct.removeAt(index);

    final newModel = model.copyWith(name: newText);

    state.groupedProduct.insert(index, newModel);

    final newState = state.copyWith(groupedProduct: state.groupedProduct);

    emit(
      ReceiptConfirmCompleted(
        groupedProduct: newState.groupedProduct,
        totalSum: newState.totalSum,
        positionedWidgets: newState.positionedWidgets,
        taxList: newState.taxList,
      ),
    );
  }

  Widget buildReceiptCard(
    ReceiptProductModel model,
    ReceiptConfirmCompleted state,
    int index,
    Animation<double> animation,
  ) {
    return ReceiptProductCard(
      key: ValueKey<ReceiptProductModel>(model),
      receiptProductModel: model,
      animation: animation,
      onTap: () => deleteProduct(index, state),
      state: state,
    );
  }

  Future<void> init(RecognizedText recognizedText) async {
    final lineTextList = _getText(recognizedText);

    final sortedTextLineList = _getOnlyNeddedLine(lineTextList);

    final alignTextLines = _alignTextLine(sortedTextLineList);

    final positionedWidgets = _getPositionedLine(alignTextLines);

    final groupedText = _getGroupText(alignTextLines);

    final totalSum = _getTotal(sortedTextLineList);

    final products = _getProducts(groupedText);

    final taxList = _getTax(groupedText);

    final replacedProduct = await _bestMatch(products);

    emit(
      ReceiptConfirmCompleted(
        groupedProduct: replacedProduct,
        totalSum: totalSum,
        positionedWidgets: positionedWidgets,
        taxList: taxList,
      ),
    );
  }
}
