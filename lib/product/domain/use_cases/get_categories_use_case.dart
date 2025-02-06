import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/core/domain/use_cases/use_case.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCategoriesUseCase extends UseCase<List<String>, NoParams> {
  final ProductRepository repo;

  GetCategoriesUseCase({required this.repo});
  @override
  Future<Either<Failure, List<String>>> call(NoParams? params) async {
    return await repo.getProductCategories();
  }
}
