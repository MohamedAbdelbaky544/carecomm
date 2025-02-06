import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddProductToWishlistUseCase {
  final ProductRepository repository;

  AddProductToWishlistUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Product params) {
    return repository.addProductToWishList(params);
  }
}
