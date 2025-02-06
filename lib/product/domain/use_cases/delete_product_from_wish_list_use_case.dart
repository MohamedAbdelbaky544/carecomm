import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteProductFromWishListUseCase {
  final ProductRepository repository;

  DeleteProductFromWishListUseCase({required this.repository});

  void call({required int index}) {
    return repository.deleteFromWhishList(index: index);
  }
}
