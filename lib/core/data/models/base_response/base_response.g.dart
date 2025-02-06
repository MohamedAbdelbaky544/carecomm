// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      msg: json['msg'] as String?,
      code: json['code'] as String?,
    );

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);
