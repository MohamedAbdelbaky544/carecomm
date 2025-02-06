import 'package:carecomm/core/data/repositories/base_repository_impl.dart';
import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/product/data/data_sources/local/wish_list_local_data_base.dart';
import 'package:carecomm/product/data/data_sources/remote/product_remote_data_source.dart';
import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends BaseRepositoryImpl
    implements ProductRepository {
  final ProductRemoteDataSource remote;
  final WishListLocalDataBase local;
  ProductRepositoryImpl(this.remote, this.local, super.logger);

  @override
  Future<Either<Failure, Product>> getProductById({required String id}) {
    return request(() async {
      final result = await remote.getProductById(id: id);

      return Right(result.toDomain());
    });
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts({String? category}) {
    return request(() async {
      final result = await remote.getListOfProduct();

      return Right(result.map((e) => e.toDomain()).toList());
    });
  }

  @override
  Future<Either<Failure, List<String>>> getProductCategories() {
    return request(() async {
      final result = await remote.getProductCategories();

      return Right(result);
    });
  }

  @override
  Future<Either<Failure, Unit>> addProductToWishList(Product newTask) async {
    await local.addProductToWishList(newTask: newTask.fromDomain());
    return right(unit);
  }

  @override
  void deleteFromWhishList({required int index}) {
    local.deleteFromWhishList(index: index);
  }

  @override
  List<Product>? getAllProductInWishList() {
    List<ProductModel>? request = local.getAllProductInWishList();
    if (request != null) {
      return request.map((e) => e.toDomain()).toList();
    } else {
      return null;
    }
  }
}
