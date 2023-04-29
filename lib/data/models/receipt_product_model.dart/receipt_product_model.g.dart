// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptProductModel _$ReceiptProductModelFromJson(Map<String, dynamic> json) =>
    ReceiptProductModel(
      name: json['name'] as String,
      totalCost: (json['totalCost'] as num).toDouble(),
      quantity: json['quantity'] as String?,
      cattegory: json['cattegory'] as String?,
      discondModel: json['discondModel'] == null
          ? null
          : DiscondModel.fromJson(json['discondModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceiptProductModelToJson(
  ReceiptProductModel instance,
) =>
    <String, dynamic>{
      'name': instance.name,
      'totalCost': instance.totalCost,
      'quantity': instance.quantity,
      'cattegory': instance.cattegory,
      'discondModel': instance.discondModel?.toJson(),
    };
