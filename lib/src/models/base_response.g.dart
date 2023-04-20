// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadObject<T> _$PayloadObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PayloadObject<T>(
      obj: fromJsonT(json['payload']),
    );

Map<String, dynamic> _$PayloadObjectToJson<T>(
  PayloadObject<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'payload': toJsonT(instance.obj),
    };

PayloadList<T> _$PayloadListFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PayloadList<T>(
      list: (json['payload'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PayloadListToJson<T>(
  PayloadList<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'payload': instance.list.map(toJsonT).toList(),
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
