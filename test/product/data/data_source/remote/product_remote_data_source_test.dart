import 'package:carecomm/core/data/utils/configuration.dart';
import 'package:carecomm/core/presentation/utils/generated/configuration.dart';
import 'package:carecomm/product/data/data_sources/remote/product_remote_data_source.dart';
import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../../../../helpers/dummy_data/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDioClient mockDioClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(() {
    mockDioClient = MockDioClient();
    Configuration configuration = DevConfiguration();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(mockDioClient, configuration);
  });

  final Future<Response<dynamic>> outputProducts = Future(
    () => Response(
        requestOptions: RequestOptions(path: 'products'),
        statusCode: 200,
        data: [
          {
            "id": 1,
            "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            "price": 109.95,
            "description":
                "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category": "men's clothing",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating": {"rate": 3.9, "count": 120}
          },
        ]
        //  readJson(
        //   readJson('helpers/dummy_data/dummy_products_response.json'),
        // ),
        ),
  );

  final Future<Response<dynamic>> outputProductById = Future(
    () => Response(
      requestOptions: RequestOptions(path: 'product'),
      statusCode: 200,
      data: readJson(
        readJson('helpers/dummy_data/dummy_product_response.json'),
      ),
    ),
  );

  group('get products', () {
    test('Should return List of product model when response status code is 200',
        () async {
      //arrange
      when(mockDioClient.get('products'))
          .thenAnswer((_) async => outputProducts);
      //act
      final result = await productRemoteDataSourceImpl.getListOfProduct();

      //assert

      expect(result, isA<List<ProductModel>>);
    });

    test('Should return product model when response status code is 200',
        () async {
      //arrange
      when(mockDioClient.get('products/1'))
          .thenAnswer((_) async => outputProductById);
      //act
      final result = await productRemoteDataSourceImpl.getProductById(id: '1');

      //assert

      expect(result, isA<ProductModel>);
    });
  });
}
