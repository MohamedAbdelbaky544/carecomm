import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/entities/rating.dart';
import 'package:carecomm/product/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetProductByIdUseCase getProductByIdUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductByIdUseCase = GetProductByIdUseCase(repo: mockProductRepository);
  });

  const testRate = Rating(
    rate: 10,
    count: 10,
  );
  const testProduct = Product(
    id: 1,
    title: 'test',
    description: 'test',
    price: 10,
    category: 'test',
    image: 'test',
    rating: testRate,
  );

  const testParams = '1';

  test('should return product Details ', () async {
    //arrange
    when(mockProductRepository.getProductById(id: testParams))
        .thenAnswer((_) async => const Right(testProduct));

    //act
    final result = await getProductByIdUseCase.call(testParams);

    // assert
    expect(result, const Right(testProduct));
  });
}
