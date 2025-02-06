import 'dart:convert';
import 'dart:io';
import 'package:carecomm/core/data/models/error_model/error_model.dart';
import 'package:carecomm/core/domain/entities/enums/server_error_code.dart';
import 'package:carecomm/core/domain/entities/failures.dart';
import 'package:carecomm/core/domain/repositories/base_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class BaseRepositoryImpl implements BaseRepository {
  final Logger _logger;
  BaseRepositoryImpl(this._logger);

  @override
  Future<Either<Failure, T>> request<T>(
      FutureEitherFailureOrData<T> body) async {
    try {
      return await body();
    } catch (e) {
      if (e is DioException) {
        const connectionTimeout = 'connectionTimeout';
        if (e.error is SocketException) {
          return left(NetworkFailure());
        } else if (e.type.name == connectionTimeout) {
          return left(NetworkFailure(connectionTimeOut: true));
        }
        _logger.e(e.message, error: e, stackTrace: e.stackTrace);

        var message = '';
        var errorCode = ServerErrorCode.serverError;

        if (e.response != null) {
          errorCode = _getErrorCode(e.response!.statusCode ?? 500);

          try {
            final responseData = e.response!.data is String
                ? jsonDecode(e.response!.data)
                : e.response!.data;

            message = ErrorModel.fromJson(responseData).detail;
          } catch (e) {
            return left(ServerFailure(errorCode: errorCode, message: message));
          }
        }

        return left(ServerFailure(errorCode: errorCode, message: message));
      } else if (e is Error) {
        _logger.e(e.toString(), error: e, stackTrace: e.stackTrace);
      } else {
        _logger.e(e);
      }

      return left(ServerFailure(errorCode: ServerErrorCode.serverError));
    }
  }

  ServerErrorCode _getErrorCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return ServerErrorCode.unauthenticated;
      case 404:
        return ServerErrorCode.notFound;
      case 403:
        return ServerErrorCode.forbidden;
      case 422:
        return ServerErrorCode.wrongInput;
      default:
        return ServerErrorCode.serverError;
    }
  }
}
