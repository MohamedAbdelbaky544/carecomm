import 'package:mockito/annotations.dart';
import 'package:carecomm/product/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

@GenerateMocks([
  ProductRepository,
], customMocks: [
  MockSpec<Dio>(as: #MockDioClient)
])
void main() {}
