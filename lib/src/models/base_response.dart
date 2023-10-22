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

@JsonSerializable(genericArgumentFactories: true)
class PayloadObject<T, M> {
  @JsonKey(name: "payload")
  T obj;
  @JsonKey(name: "meta")
  M? meta;

  PayloadObject({required this.obj, this.meta});
}

@JsonSerializable(genericArgumentFactories: true)
class PayloadList<T,M> {
  @JsonKey(name: "payload")
  List<T> list;
  @JsonKey(name: "meta")
  M? meta;

  PayloadList({required this.list,this.meta});

  // factory PayloadList.fromJson(
  //     Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
  //   return _$PayloadListFromJson(json, fromJsonT);
  // }

  factory PayloadList.fromJson(
      Map<String,dynamic> json,
      T Function(Object? json) fromJsonT,
      M Function(Object? json) fromJsonM) {
    return _$PayloadListFromJson(json, fromJsonT,fromJsonM);
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

@JsonSerializable(genericArgumentFactories: true)
class JSendResponseEntity<T> {
  final T data;
  final String? message;

  JSendResponseEntity({required this.data, required this.message});

  factory JSendResponseEntity.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    T data = fromJsonT(json["data"]);
    String? msg;
    if (json.containsKey("message")) {
      msg = json["message"] as String;
    }
    return JSendResponseEntity(data: data, message: msg);
  }
}

abstract class ApiRes {}

class Success<T> extends ApiRes {
  final dynamic _json;

  JSendResponseEntity<T>? _res;

  Success(this._json);

  void handleJsonMapping(T Function(dynamic) fromJsonT) {
    _res = JSendResponseEntity.fromJson(_json, fromJsonT);
  }

  T getPayload() {
    return _res!.data;
  }
}

/// HTTP 통신 에러 Error Body를 리턴합니다.
class HttpError<T> extends ApiRes {
  final T? data;

  HttpError({this.data});
}

/// HTTP Exception 이 아닌 다른 에러
class Error extends ApiRes {
  final String? message;

  Error({this.message});
}
