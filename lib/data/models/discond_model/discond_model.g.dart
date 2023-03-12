// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discond_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscondModel _$DiscondModelFromJson(Map<String, dynamic> json) => DiscondModel(
      name: json['name'] as String,
      totalCost: (json['totalCost'] as num).toDouble(),
      cattegory: json['cattegory'] as String?,
    );

Map<String, dynamic> _$DiscondModelToJson(DiscondModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalCost': instance.totalCost,
      'cattegory': instance.cattegory,
    };
