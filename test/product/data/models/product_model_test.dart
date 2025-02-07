import 'dart:convert';

import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:carecomm/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/dummy_data/json_reader.dart';

void main() {
  const testProductModel = ProductModel(id: 1);

  test('should product Model be  Class of entity by using to Domain', () async {
    expect(testProductModel.toDomain(), isA<Product>());
  });

  test('should return a valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_product_response.json'),
    );
    //act
    final result = ProductModel.fromJson(jsonMap);
    //assert
    expect(result, isA<ProductModel>());
  });
}
