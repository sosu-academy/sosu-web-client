import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Description :
///
/// Created by juhongmin on 10/22/23

abstract class BaseJson {
  // T fromJson(Map<String, dynamic> json);
  //
  // Map<String, dynamic> toJson();
}

abstract class ApiResponse {}

class Success<T> extends ApiResponse {
  final dynamic json;
  late T _data;

  Success(this.json);

  void setData(T data) {
    _data = data;
  }

  T getData() {
    return _data;
  }
}

class Fail<T> extends ApiResponse {
  final dynamic json;
  final int code;
  late T _data;

  Fail({required this.code, required this.json});

  void setData(T data) {
    _data = data;
  }

  T getData() {
    return _data;
  }
}

class Error extends ApiResponse {
  final String? message;

  Error({this.message});
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

class JSendObjWithMeta<T extends BaseJson, M extends BaseJson> {
  final bool status;
  final PayloadObjectWithMeta<T, M> data;
  String? message;

  JSendObjWithMeta({required this.status, required this.data, this.message});

  factory JSendObjWithMeta.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonEntity,
      M Function(dynamic json) fromJsonMeta) {
    return JSendObjWithMeta(
        status: json["status"] as bool? ?? false,
        data: PayloadObjectWithMeta.fromJson(
            json["data"], fromJsonEntity, fromJsonMeta),
        message: json["message"] as String? ?? "");
  }

  T? getObject() {
    return data.obj;
  }

  M? getMeta() {
    return data.meta;
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
  int? totalCount;

  PaginationMeta({required this.totalCount});

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return _$PaginationMetaFromJson(json);
  }
}

@JsonSerializable()
class EmptyEntity extends BaseJson {
  EmptyEntity();

  factory EmptyEntity.fromJson(Map<String, dynamic> json) {
    return _$EmptyEntityFromJson(json);
  }
}

@JsonSerializable()
class EmptyMeta extends BaseJson {
  EmptyMeta();

  factory EmptyMeta.fromJson(Map<String, dynamic> json) {
    return _$EmptyMetaFromJson(json);
  }
}
