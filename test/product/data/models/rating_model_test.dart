import 'dart:convert';

import 'package:carecomm/product/data/models/rating_model/rating_model.dart';
import 'package:carecomm/product/domain/entities/rating.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/dummy_data/json_reader.dart';

void main() {
  const testRatingModel = RatingModel();

  test('should rating Model be  Class of entity by using to Domain', () async {
    expect(testRatingModel.toDomain(), isA<Rating>());
  });

  test('should return a valid model from json', () {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_rate_response.json'),
    );
    //act
    final result = RatingModel.fromJson(jsonMap);
    //assert
    expect(result, isA<RatingModel>());
  });
}
