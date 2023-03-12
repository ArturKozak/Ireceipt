part of 'receipt_confirm_cubit.dart';

@immutable
abstract class ReceiptConfirmState extends Equatable {}

class ReceiptConfirmInitial extends ReceiptConfirmState {
  @override
  List<Object?> get props => [];
}

class ReceiptConfirmCompleted extends ReceiptConfirmState {
  final List<ReceiptProductModel> groupedProduct;
  final List<Widget> positionedWidgets;
  final List<TaxModel> taxList;
  final double totalSum;

  ReceiptConfirmCompleted({
    required this.groupedProduct,
    required this.positionedWidgets,
    required this.taxList,
    required this.totalSum,
  });

  ReceiptConfirmCompleted copyWith({
    List<ReceiptProductModel>? groupedProduct,
    List<Widget>? positionedWidgets,
    List<TaxModel>? taxList,
    double? totalSum,
  }) {
    return ReceiptConfirmCompleted(
      groupedProduct: groupedProduct ?? this.groupedProduct,
      positionedWidgets: positionedWidgets ?? this.positionedWidgets,
      taxList: taxList ?? this.taxList,
      totalSum: totalSum ?? this.totalSum,
    );
  }

  @override
  List<Object?> get props => [groupedProduct];
}
