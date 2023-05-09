import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ireceipt/data/models/receipt_product_model.dart/receipt_product_model.dart';
import 'package:ireceipt/kit/custom_widgets/modal_sheets/edit_receipt_item_sheet/widgets/edit_receipt_confirm_button.dart';
import 'package:ireceipt/kit/custom_widgets/modal_sheets/edit_receipt_item_sheet/widgets/edit_receipt_item_section_sheet.dart';
import 'package:ireceipt/module/receipt_confirm_page/cubit/receipt_confirm_cubit.dart';

class EditReceiptItemSheet extends StatefulWidget {
  final ReceiptProductModel model;
  final ReceiptConfirmCubit cubit;
  final int index;

  const EditReceiptItemSheet({
    required this.model,
    required this.index,
    required this.cubit,
    super.key,
  });

  @override
  State<EditReceiptItemSheet> createState() => _EditReceiptItemSheetState();
}

class _EditReceiptItemSheetState extends State<EditReceiptItemSheet> {
  static final _sectionSpacing = 24.0.verticalSpace;

  late final TextEditingController nameController;
  late final TextEditingController quantityController;
  late final TextEditingController costController;
  late final TextEditingController categoryController;
  late final FocusNode nameFocusNode;
  late final FocusNode quantityFocusNode;
  late final FocusNode costFocusNode;
  late final FocusNode categoryFocusNode;

  @override
  void initState() {
    super.initState();

    _initController();

    nameController.addListener(() {
      setState(_rebuildWidget);
    });

    categoryController.addListener(() {
      setState(_rebuildWidget);
    });

    quantityController.addListener(() {
      setState(_rebuildWidget);
    });

    costController.addListener(() {
      setState(_rebuildWidget);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    quantityController.dispose();
    costController.dispose();

    nameFocusNode.dispose();
    categoryFocusNode.dispose();
    quantityFocusNode.dispose();
    costFocusNode.dispose();

    super.dispose();
  }

  void _initController() {
    nameController = TextEditingController(text: widget.model.name);
    categoryController = TextEditingController(text: widget.model.cattegory);
    quantityController = TextEditingController(text: widget.model.quantity);
    costController = TextEditingController(
      text: widget.model.totalCost.toString(),
    );

    nameFocusNode = FocusNode();
    categoryFocusNode = FocusNode();
    quantityFocusNode = FocusNode();
    costFocusNode = FocusNode();
  }

  void _rebuildWidget() {
    setState(() {/* Nothing to do */});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
          ),
          Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionSpacing,
                  EditReceiptItemSectionSheet(
                    textFieldWidth: double.maxFinite,
                    sectionName: 'Name',
                    hintName: 'Name',
                    controller: nameController,
                    node: nameFocusNode,
                    onSubmitted: _rebuildWidget,
                    onSuffixPressed: _rebuildWidget,
                    keyboardType: TextInputType.name,
                  ),
                  _sectionSpacing,
                  EditReceiptItemSectionSheet(
                    textFieldWidth: double.maxFinite,
                    sectionName: 'Quantity',
                    hintName: 'Quantity',
                    controller: quantityController,
                    node: quantityFocusNode,
                    onSubmitted: _rebuildWidget,
                    onSuffixPressed: _rebuildWidget,
                    keyboardType: TextInputType.number,
                  ),
                  _sectionSpacing,
                  Row(
                    children: [
                      EditReceiptItemSectionSheet(
                        textFieldWidth: 120.w,
                        sectionName: 'Category',
                        hintName: 'Category',
                        controller: categoryController,
                        node: categoryFocusNode,
                        onSubmitted: _rebuildWidget,
                        onSuffixPressed: _rebuildWidget,
                        keyboardType: TextInputType.name,
                      ),
                      EditReceiptItemSectionSheet(
                        textFieldWidth: 160.w,
                        sectionName: 'Cost',
                        hintName: 'Cost',
                        controller: costController,
                        node: costFocusNode,
                        onSubmitted: _rebuildWidget,
                        onSuffixPressed: _rebuildWidget,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  EditReceiptConfirmButton(
                    onTap: () => widget.cubit.editProduct(
                      model: ReceiptProductModel(
                        name: nameController.text,
                        totalCost: double.parse(costController.text),
                        cattegory: categoryController.text,
                        quantity: quantityController.text,
                      ),
                      index: widget.index,
                      state: widget.cubit.state,
                      context: context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
