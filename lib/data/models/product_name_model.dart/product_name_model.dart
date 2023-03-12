import 'package:json_annotation/json_annotation.dart';

part 'product_name_model.g.dart';

@JsonSerializable()
class ProductNameModel {
  static const nameKey = 'name';

  @JsonKey(name: nameKey)
  final String name;

  ProductNameModel({
    required this.name,
  });

  factory ProductNameModel.fromJson(Map<String, dynamic> json) =>
      _$ProductNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductNameModelToJson(this);
}
