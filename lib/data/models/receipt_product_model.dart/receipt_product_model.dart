import 'package:ireceipt/data/models/discond_model/discond_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'receipt_product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ReceiptProductModel {
  static const nameKey = 'name';
  static const totalCostKey = 'totalCost';
  static const quantityKey = 'quantity';
  static const cattegoryKey = 'cattegory';
  static const discondModelKey = 'discondModel';

  @JsonKey(name: nameKey)
  final String name;

  @JsonKey(name: totalCostKey)
  double totalCost;

  @JsonKey(name: quantityKey)
  String? quantity;

  @JsonKey(name: cattegoryKey)
  String? cattegory;

  @JsonKey(name: discondModelKey)
  DiscondModel? discondModel;

  ReceiptProductModel({
    required this.name,
    required this.totalCost,
    this.quantity,
    this.cattegory,
    this.discondModel,
  });

  ReceiptProductModel copyWith({
    String? name,
    double? totalCost,
    String? quantity,
    String? cattegory,
    DiscondModel? discondModel,
  }) {
    return ReceiptProductModel(
      name: name ?? this.name,
      totalCost: totalCost ?? this.totalCost,
      cattegory: cattegory ?? this.cattegory,
      discondModel: discondModel ?? this.discondModel,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ReceiptProductModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptProductModelToJson(this);
}
