import 'package:json_annotation/json_annotation.dart';

part 'product_params_model.g.dart';

@JsonSerializable(
  createToJson: true,
  includeIfNull: false,
)
class ProductParamsModel {
  final String? category;

  const ProductParamsModel(this.category);

  Map<String, dynamic> toJson() => _$ProductParamsModelToJson(this);
}
