import 'package:carecomm/product/domain/entities/rating.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class RatingModel {
  @HiveField(0)
  final double? rate;
  @HiveField(1)
  final int? count;

  const RatingModel({
    this.rate,
    this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}

extension MapToDomain on RatingModel {
  Rating toDomain() => Rating(
        rate: rate,
        count: count,
      );
}

extension MapFromDomain on Rating {
  RatingModel fromDomain() => RatingModel(
        count: count,
        rate: rate,
      );
}
