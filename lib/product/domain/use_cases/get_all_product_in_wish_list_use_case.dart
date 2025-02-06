import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllProductInWishListUseCase {
  final ProductRepository repository;

  GetAllProductInWishListUseCase({required this.repository});

  List<Product>? call() {
    return repository.getAllProductInWishList();
  }
}
