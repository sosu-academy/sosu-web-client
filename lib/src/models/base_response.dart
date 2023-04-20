import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Description : HTTP Base Response
///
/// Created by juhongmin on 2023/04/19

class ApiErrorException implements Exception {
  final String msg;

  ApiErrorException(this.msg);
}

// @JsonSerializable(genericArgumentFactories: true)
// class DataListWithMeta<T, M> {
//   @JsonKey(name: "payload")
//   List<T> list;
//   @JsonKey(name: "meta")
//   M? meta;
//
//   DataListWithMeta({required this.list, this.meta});
//
//   factory DataListWithMeta.fromJson(Map<String, dynamic> json) =>
//       _$DataListWithMetaFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DataListWithMetaToJson(this);
// }

/// {
///  status: true,
///  data: {
///   payload: Object or List,
///   meta: {
///     pageCount..
///   },
///   message: String
/// }
///

@JsonSerializable(genericArgumentFactories: true)
class PayloadObject<T> {
  @JsonKey(name: "payload")
  T obj;

  PayloadObject({required this.obj});
}

@JsonSerializable(genericArgumentFactories: true)
class PayloadList<T> {
  @JsonKey(name: "payload")
  List<T> list;

  PayloadList({required this.list});

  factory PayloadList.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return _$PayloadListFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(T Function(dynamic) fromJsonT) =>
      _$PayloadListToJson(this, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool status;
  final T? data;
  final String? message;

  ApiResponse({required this.status, this.data, this.message});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      status: json['status'] as bool,
      data: json['status'] == true ? fromJsonT(json['data']) : null,
      message: json['status'] == false ? json['message'] as String : null,
    );
  }
}
