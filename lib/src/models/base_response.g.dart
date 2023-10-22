// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadObject<T, M> _$PayloadObjectFromJson<T, M>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
  M Function(Object? json) fromJsonM,
) =>
    PayloadObject<T, M>(
      obj: fromJsonT(json['payload']),
      meta: _$nullableGenericFromJson(json['meta'], fromJsonM),
    );

Map<String, dynamic> _$PayloadObjectToJson<T, M>(
  PayloadObject<T, M> instance,
  Object? Function(T value) toJsonT,
  Object? Function(M value) toJsonM,
) =>
    <String, dynamic>{
      'payload': toJsonT(instance.obj),
      'meta': _$nullableGenericToJson(instance.meta, toJsonM),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

PayloadList<T, M> _$PayloadListFromJson<T, M>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
  M Function(Object? json) fromJsonM,
) =>
    PayloadList<T, M>(
      list: (json['payload'] as List<dynamic>).map(fromJsonT).toList(),
      meta: _$nullableGenericFromJson(json['meta'], fromJsonM),
    );

Map<String, dynamic> _$PayloadListToJson<T, M>(
  PayloadList<T, M> instance,
  Object? Function(T value) toJsonT,
  Object? Function(M value) toJsonM,
) =>
    <String, dynamic>{
      'payload': instance.list.map(toJsonT).toList(),
      'meta': _$nullableGenericToJson(instance.meta, toJsonM),
    };

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      status: json['status'] as bool,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'message': instance.message,
    };

JSendResponseEntity<T> _$JSendResponseEntityFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    JSendResponseEntity<T>(
      data: fromJsonT(json['data']),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$JSendResponseEntityToJson<T>(
  JSendResponseEntity<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'message': instance.message,
    };
