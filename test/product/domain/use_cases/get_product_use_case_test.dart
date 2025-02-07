import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/entities/rating.dart';
import 'package:carecomm/product/domain/use_cases/get_product_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetProductUseCase getProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductUseCase = GetProductUseCase(repo: mockProductRepository);
  });

  const testRate = Rating(
    rate: 10,
    count: 10,
  );
  const testProducts = [
    Product(
      id: 1,
      title: 'test',
      description: 'test',
      price: 10,
      category: 'test',
      image: 'test',
      rating: testRate,
    ),
    Product(
      id: 2,
      title: 'test',
      description: 'test',
      price: 10,
      category: 'test',
      image: 'test',
      rating: testRate,
    ),
  ];

  const testParams = '';

  test('should fetch products', () async {
    //arrange
    when(mockProductRepository.getProducts(category: testParams))
        .thenAnswer((_) async => const Right(testProducts));

    //act
    final result = await getProductUseCase.call(testParams);

    //assert
    expect(result, const Right(testProducts));
  });
}
