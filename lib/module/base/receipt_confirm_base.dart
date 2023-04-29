import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/data/models/product_name_model.dart/product_name_model.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/word_box_model/word_box_model.dart';
import 'package:ireceipt/data/repo/product_name_repository.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';
import 'package:ireceipt/module/receipt_confirm_page/widgets/receipt_product_card.dart';
import 'package:ireceipt/util/app_constants.dart';
import 'package:string_similarity/string_similarity.dart';

abstract class ReceiptConfirmBase extends Cubit<ReceiptConfirmState> {
  @protected
  final ProductNameRepository _productNameRepository;

  final listKey = GlobalKey<AnimatedListState>();

  ReceiptConfirmBase(this._productNameRepository)
      : super(ReceiptConfirmInitial());

  @protected
  Future<void> init(RecognizedText recognizedText);

  @protected
  List<TextLine> getText(RecognizedText recognizedText) {
    final lines = <TextLine>[];

    for (final block in recognizedText.blocks) {
      lines.addAll(block.lines);
    }

    lines.sort(
      (a, b) => a.boundingBox.top.compareTo(b.boundingBox.top),
    );

    return lines;
  }

  @protected
  List<WordBox> alignTextLine(List<TextLine> sortedList) {
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

  @protected
  List<String> getGroupText(List<WordBox> wordBoxList) {
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

  @protected
  double getTotal(
    List<TextLine> lines,
    RegExp regExp,
    List params,
    double? Function(String? match) getPrice,
  ) {
    double scanTotal = 0;

    for (final line in lines) {
      final text = line.text;

      if (regExp.hasMatch(text)) {
        var match = regExp.stringMatch(text);

        if (match == 'null') {
          continue;
        }

        if (match == null) {
          continue;
        }

        if (match.isEmpty) {
          continue;
        }

        for (final element in params) {
          if (match!.contains(element)) {
            final reText = text.replaceAll(match, '');

            match = reText;
          }
        }

        final lineCost = getPrice(match);

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

  @protected
  Future<List<ReceiptProductModel>> bestMatch(
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

  @nonVirtual
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

  @protected
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
}
