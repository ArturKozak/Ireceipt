part of 'receipt_confirm_cubit.dart';

@immutable
abstract class ReceiptConfirmState extends Equatable {}

class ReceiptConfirmInitial extends ReceiptConfirmState {
  @override
  List<Object?> get props => [];
}

class ReceiptConfirmUpdate extends ReceiptConfirmState {
  @override
  List<Object?> get props => [];
}

class ReceiptConfirmCompleted extends ReceiptConfirmState {
  final List<ReceiptProductModel> groupedProduct;
  final double totalSum;
  final List<TaxModel>? taxList;

  ReceiptConfirmCompleted({
    required this.groupedProduct,
    required this.totalSum,
    this.taxList,
  });

  ReceiptConfirmCompleted copyWith({
    List<ReceiptProductModel>? groupedProduct,
    List<Widget>? positionedWidgets,
    List<TaxModel>? taxList,
    double? totalSum,
  }) {
    return ReceiptConfirmCompleted(
      groupedProduct: groupedProduct ?? this.groupedProduct,
      taxList: taxList ?? this.taxList,
      totalSum: totalSum ?? this.totalSum,
    );
  }

  @override
  List<Object?> get props => [groupedProduct];
}
