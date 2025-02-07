import 'package:carecomm/core/domain/use_cases/use_case.dart';
import 'package:carecomm/product/domain/use_cases/get_categories_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCategoriesUseCase getCategoriesUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getCategoriesUseCase = GetCategoriesUseCase(repo: mockProductRepository);
  });
  const testListOfCategories = ['category 1', 'category 2'];
  const params = NoParams();

  test('should fetch list of product categories', () async {
    // arrange
    when(mockProductRepository.getProductCategories())
        .thenAnswer((_) async => const Right(testListOfCategories));
    //act
    final result = await getCategoriesUseCase.call(params);

    //assert

    expect(result, const Right(testListOfCategories));
  });
}
