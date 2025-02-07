import 'package:carecomm/product/domain/entities/product.dart';
import 'package:carecomm/product/domain/entities/rating.dart';
import 'package:carecomm/product/domain/use_cases/get_all_product_in_wish_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetAllProductInWishListUseCase getAllProductInWishListUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getAllProductInWishListUseCase =
        GetAllProductInWishListUseCase(repository: mockProductRepository);
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
  test('should get all product in local dataBase', () async {
    // arrange
    when(mockProductRepository.getAllProductInWishList())
        .thenAnswer((_) => testProducts);

    //act
    getAllProductInWishListUseCase.call();

    //assert

    verify(mockProductRepository.getAllProductInWishList()).called(1);
  });
}
