import 'package:carecomm/product/data/models/rating_model/rating_model.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ProductModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final double? price;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? category;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final RatingModel? rating;

  ProductModel({
    required this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  @override
  bool operator ==(other) {
    return (other is ProductModel) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

extension MapToDomain on ProductModel {
  Product toDomain() => Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating?.toDomain(),
      );
}

extension MapFromDomain on Product {
  ProductModel fromDomain() => ProductModel(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating?.fromDomain(),
      );
}
