import 'package:carecomm/product/data/data_sources/remote/product_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

@GenerateMocks([
  ProductRepository,
  ProductRemoteDataSource,
], customMocks: [
  MockSpec<Dio>(as: #MockDioClient)
])
void main() {}
