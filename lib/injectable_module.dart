import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'multipart/form-data',
            // 'Accept': '*/*',
            'x-api-key':
                'fdfb6ec9ce6ff5e2258e0fafc441357c560a87b50686e91dc57bb2c2f7886dca'
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          }),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          request.sendTimeout = (request.data is FormData)
              ? const Duration(milliseconds: 300000)
              : const Duration(milliseconds: 60000);
          request.connectTimeout = const Duration(milliseconds: 50000);
          request.receiveTimeout = const Duration(milliseconds: 600000);

          return handler.next(request);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (obj) {
            debugPrint(obj.toString());
          }),
    );
    dio.interceptors.add(CurlLoggerDioInterceptor());
    return dio;
  }

  @lazySingleton
  Logger get logger => Logger();
}
