import 'package:carecomm/product/data/models/product_params_model/product_params_model.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const testParams = ProductParamsModel('category');
  test('should return a valid  to json', () {
    //act
    final result = testParams.toJson();
    //assert
    const expectedToJson = {"category": "category"};
    expect(result, equals(expectedToJson));
  });
}
