import 'package:json_annotation/json_annotation.dart';

part 'base_pagination_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class BasePaginationParamsModel {
  @JsonKey(name: 'size', toJson: limitValue)
  final int? limit;
  @JsonKey(name: 'page', toJson: skipValue)
  final int? skip;

  BasePaginationParamsModel({
    this.limit,
    this.skip,
  });

  static int limitValue(int? number) => number ?? 10;
  static int skipValue(int? number) => number ?? 0;

  Map<String, dynamic> toJson() => _$BasePaginationParamsModelToJson(this);
}
