import 'package:json_annotation/json_annotation.dart';

part 'discond_model.g.dart';

@JsonSerializable()
class DiscondModel {
  static const nameKey = 'name';
  static const totalCostKey = 'totalCost';
  static const cattegoryKey = 'cattegory';

  @JsonKey(name: nameKey)
  final String name;

  @JsonKey(name: totalCostKey)
  double totalCost;

  @JsonKey(name: cattegoryKey)
  String? cattegory;

  DiscondModel({
    required this.name,
    required this.totalCost,
    this.cattegory,
  });

  factory DiscondModel.fromJson(Map<String, dynamic> json) =>
      _$DiscondModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscondModelToJson(this);
}
