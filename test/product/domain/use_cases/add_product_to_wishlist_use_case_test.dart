import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/use_cases/add_product_to_wishlist_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late AddProductToWishlistUseCase addProductToWishlistUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    addProductToWishlistUseCase =
        AddProductToWishlistUseCase(repository: mockProductRepository);
  });

  const testProduct = Product(id: 1);
  test('should add product to local data base ', () async {
//arrange
    when(mockProductRepository.addProductToWishList(testProduct))
        .thenAnswer((_) async => const Right(unit));

//act
    final result = await addProductToWishlistUseCase.call(testProduct);

//assert

    expect(result, const Right(unit));
  });
}
