import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    String? category,
  });

  Future<Either<Failure, Product>> getProductById({
    required String id,
  });

  Future<Either<Failure, List<String>>> getProductCategories();

  Future<Either<Failure, Unit>> addProductToWishList(Product newTask);
  void deleteFromWhishList({required int index});
  List<Product>? getAllProductInWishList();
}
