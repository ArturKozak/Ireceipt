// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaxModel _$TaxModelFromJson(Map<String, dynamic> json) => TaxModel(
      name: json['name'] as String,
      totalCost: (json['totalCost'] as num).toDouble(),
    );

Map<String, dynamic> _$TaxModelToJson(TaxModel instance) => <String, dynamic>{
      'name': instance.name,
      'totalCost': instance.totalCost,
    };
