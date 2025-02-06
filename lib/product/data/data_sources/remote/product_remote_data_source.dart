import 'package:carecomm/core/presentation/utils/generated/configuration.dart';
import 'package:carecomm/product/data/models/product_model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'product_remote_data_source.g.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getListOfProduct({
    String? category,
  });
  Future<ProductModel> getProductById({
    required String id,
  });

  Future<List<String>> getProductCategories();
}

@LazySingleton(as: ProductRemoteDataSource)
@RestApi(baseUrl: '')
abstract class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @factoryMethod
  factory ProductRemoteDataSourceImpl(Dio dio, Configuration configuration) {
    return _ProductRemoteDataSourceImpl(dio, baseUrl: configuration.getApiUrl);
  }

  @override
  @GET('products')
  Future<List<ProductModel>> getListOfProduct({
    @Query('category') String? category,
  });

  @override
  @GET('products/{id}')
  Future<ProductModel> getProductById({
    @Path() required String id,
  });

  @override
  @GET('products/categories')
  Future<List<String>> getProductCategories();
}
