import 'package:json_annotation/json_annotation.dart';

part 'base_response_v2.g.dart';

/// Description :
///
/// Created by juhongmin on 10/22/23

abstract class BaseJson {
  // T fromJson(Map<String, dynamic> json);
  //
  // Map<String, dynamic> toJson();
}

abstract class ApiResponseV2 {}

class SuccessV2<T> extends ApiResponseV2 {
  final dynamic json;
  late T _data;

  SuccessV2(this.json);

  void setData(T data) {
    _data = data;
  }

  T getData() {
    return _data;
  }
}

class ErrorV2 extends ApiResponseV2 {
  final String? message;

  ErrorV2({this.message});
}

///
/// {
///   "status" : true,
///   "data" : {
///     "payload" : [],
///     "meta" : {
///       "size" : 3
///     }
///   }
/// },
/// {
///   "status" : false,
///   "data" : {
///     "payload" : {
///       "errorBody" : "EEEE"
///     }
///   }
///   "message" : "에러입니다."
/// }
///
class JSendListWithMeta<T extends BaseJson, M extends BaseJson> {
  final bool status;
  final PayloadListWithMeta<T, M> data;
  String? message;

  JSendListWithMeta({required this.status, required this.data, this.message});

  factory JSendListWithMeta.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonEntity,
      M Function(dynamic json) fromJsonMeta) {
    return JSendListWithMeta(
        status: json["status"] as bool? ?? false,
        data: PayloadListWithMeta.fromJson(
            json["data"], fromJsonEntity, fromJsonMeta),
        message: json["message"] as String? ?? "");
  }

  List<T> getList() {
    return data.list;
  }

  M? getMeta() {
    return data.meta;
  }
}

class PayloadObject<T extends BaseJson> {
  final T obj;

  PayloadObject({required this.obj});

  factory PayloadObject.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonEntity) {
    T payloadObj = fromJsonEntity(json['payload']);
    return PayloadObject(obj: payloadObj);
  }
}

class PayloadObjectWithMeta<T extends BaseJson, M extends BaseJson> {
  final T obj;
  final M? meta;

  PayloadObjectWithMeta({required this.obj, this.meta});

  factory PayloadObjectWithMeta.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonEntity,
      M Function(Object? json) fromJsonMeta) {
    T payloadObj = fromJsonEntity(json['payload']);
    Object? metaInput = json['meta'];
    M? payloadMeta = metaInput == null ? null : fromJsonMeta(metaInput);
    return PayloadObjectWithMeta(obj: payloadObj, meta: payloadMeta);
  }
}

class PayloadList<T extends BaseJson> {
  final List<T> list;

  PayloadList({required this.list});

  factory PayloadList.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonEntity) {
    List<T> payloadList =
        (json['payload'] as List<dynamic>).map(fromJsonEntity).toList();
    return PayloadList<T>(list: payloadList);
  }
}

class PayloadListWithMeta<T extends BaseJson, M extends BaseJson> {
  final List<T> list;
  final M? meta;

  PayloadListWithMeta({required this.list, this.meta});

  factory PayloadListWithMeta.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonEntity,
      M Function(Object? json) fromJsonMeta) {
    List<T> payloadList =
        (json['payload'] as List<dynamic>).map(fromJsonEntity).toList();
    Object? metaInput = json['meta'];
    M? payloadMeta = metaInput == null ? null : fromJsonMeta(metaInput);
    return PayloadListWithMeta(list: payloadList, meta: payloadMeta);
  }
}

@JsonSerializable()
class PaginationMeta extends BaseJson {
  @JsonKey(name: "total_count")
  int totalCount;

  PaginationMeta({required this.totalCount});

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return _$PaginationMetaFromJson(json);
  }
}
