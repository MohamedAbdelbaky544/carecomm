import 'package:carecomm/product/domain/use_cases/delete_product_from_wish_list_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductFromWishListUseCase deleteProductFromWishListUseCase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductFromWishListUseCase =
        DeleteProductFromWishListUseCase(repository: mockProductRepository);
  });

  const testIndex = 1;

  test('delete Item from local dataBase', () {
    //arrange
    when(mockProductRepository.deleteFromWhishList(index: 1))
        .thenAnswer((_) async {});
    //act
    deleteProductFromWishListUseCase.call(index: testIndex);

    //assert
    verify(mockProductRepository.deleteFromWhishList(index: testIndex))
        .called(1);
  });
}
