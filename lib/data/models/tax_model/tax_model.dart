import 'package:json_annotation/json_annotation.dart';

part 'tax_model.g.dart';

@JsonSerializable()
class TaxModel {
  static const nameKey = 'name';
  static const totalCostKey = 'totalCost';

  @JsonKey(name: nameKey)
  final String name;

  @JsonKey(name: totalCostKey)
  double? totalCost;

  TaxModel({
    required this.name,
    this.totalCost = 0.0,
  });

  TaxModel copyWith({
    String? name,
    double? totalCost,
  }) {
    return TaxModel(
      name: name ?? this.name,
      totalCost: totalCost ?? this.totalCost,
    );
  }

  factory TaxModel.fromJson(Map<String, dynamic> json) =>
      _$TaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaxModelToJson(this);
}
