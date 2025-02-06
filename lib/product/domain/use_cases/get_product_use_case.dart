import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/core/domain/use_cases/use_case.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductUseCase extends UseCase<List<Product>, String?> {
  final ProductRepository repo;

  GetProductUseCase({required this.repo});
  @override
  Future<Either<Failure, List<Product>>> call(String? params) async {
    return await repo.getProducts(
      category: params,
    );
  }
}
