import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ireceipt/app/base/configuration_base.dart';
import 'package:ireceipt/data/models/product_name_model.dart/product_name_model.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/data/models/tax_model/tax_model.dart';
import 'package:ireceipt/data/models/word_box_model/word_box_model.dart';
import 'package:ireceipt/data/repo/product_name_repository.dart';
import 'package:ireceipt/kit/custom_widgets/modal_sheets/edit_receipt_item_sheet/edit_receipt_item_sheet.dart';
import 'package:ireceipt/module/receipt_confirm_page/widgets/receipt_product_card.dart';
import 'package:ireceipt/util/app_constants.dart';
import 'package:ireceipt/util/valut.dart';
import 'package:string_similarity/string_similarity.dart';

part 'receipt_confirm_state.dart';

class ReceiptConfirmCubit extends Cubit<ReceiptConfirmState> {
  final ConfigurationBase _configuration = Valut.configuration;

  final listKey = GlobalKey<AnimatedListState>();

  final ProductNameRepository productNameRepository;

  ReceiptConfirmCubit(this.productNameRepository)
      : super(ReceiptConfirmUpdate());

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

  double _getTotal(
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

  Future<List<ReceiptProductModel>> _bestMatch(
    List<ReceiptProductModel> list,
  ) async {
    final replacedNameList = <ReceiptProductModel>[];

    await productNameRepository.ensureInitialized;

    for (final item in list) {
      final raring = <double, ProductNameModel>{};

      for (final element in productNameRepository.productList) {
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

  Widget buildReceiptCard(
    ReceiptConfirmCompleted state,
    int index,
    Animation<double> animation,
    BuildContext context,
  ) {
    final model = state.groupedProduct[index];

    return ReceiptProductCard(
      key: ValueKey<ReceiptProductModel>(model),
      receiptProductModel: model,
      animation: animation,
      index: index,
      deleteTap: () => deleteProduct(index, state),
    );
  }

  Future<void> editProduct({
    required ReceiptProductModel model,
    required ReceiptConfirmState state,
    required int index,
    required BuildContext context,
  }) async {
    if (state is! ReceiptConfirmCompleted) {
      return;
    }

    final list = state.groupedProduct;

    list.removeAt(index);

    list.insert(index, model);

    final newState = state.copyWith(groupedProduct: list);

    Navigator.pop(context);

    emit(ReceiptConfirmUpdate());

    emit(
      ReceiptConfirmCompleted(
        groupedProduct: newState.groupedProduct,
        totalSum: newState.totalSum,
        taxList: newState.taxList,
      ),
    );
  }

  Future<void> deleteProduct(
    int index,
    ReceiptConfirmState state,
  ) async {
    if (state is! ReceiptConfirmCompleted) {
      return;
    }

    state.groupedProduct.removeAt(index);

    HapticFeedback.lightImpact();

    state.copyWith(groupedProduct: state.groupedProduct);

    listKey.currentState!.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return buildReceiptCard(
          state,
          index,
          animation,
          context,
        );
      },
      duration: AppConstants.halfAnimDuration,
    );
  }

  void showEditSheet({
    required BuildContext context,
    required ReceiptProductModel model,
    required ReceiptConfirmCubit cubit,
    required int index,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditReceiptItemSheet(
          model: model,
          index: index,
          cubit: cubit,
        );
      },
    );
  }

  Future<void> init(RecognizedText recognizedText) async {
    final lineTextList = _getText(recognizedText);

    final alignTextLines = _alignTextLine(lineTextList);

    final groupedText = _getGroupText(alignTextLines);

    final totalSum = _getTotal(
      lineTextList,
      _configuration.generalCostExp!,
      _configuration.totalCostParams,
      _configuration.getPrice,
    );

    final products = _configuration.getProducts(groupedText);

    final taxList = _configuration.getTax(groupedText);

    final replacedProduct = await _bestMatch(products);

    emit(
      ReceiptConfirmCompleted(
        groupedProduct: replacedProduct,
        totalSum: totalSum,
        taxList: taxList,
      ),
    );
  }
}
