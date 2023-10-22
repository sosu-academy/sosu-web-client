/// Description :
///
/// Created by juhongmin on 10/22/23

abstract class BaseJson<T> {
  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
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
}

class PayloadObject<T extends BaseJson> {
  final T obj;

  PayloadObject({required this.obj});

  factory PayloadObject.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonEntity) {
    T payloadObj = fromJsonEntity(json['payload']);
    return PayloadObject(obj: payloadObj);
  }
}

class PayloadObjectWithMeta<T extends BaseJson, M extends BaseJson> {
  final T obj;
  final M? meta;

  PayloadObjectWithMeta({required this.obj, this.meta});

  factory PayloadObjectWithMeta.fromJson(Map<String, dynamic> json,
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

  factory PayloadList.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonEntity) {
    List<T> payloadList =
    (json['payload'] as List<dynamic>).map(fromJsonEntity).toList();
    return PayloadList<T>(list: payloadList);
  }
}

class PayloadListWithMeta<T extends BaseJson, M extends BaseJson> {
  final List<T> list;
  final M? meta;

  PayloadListWithMeta({required this.list, this.meta});

  factory PayloadListWithMeta.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonEntity,
      M Function(Object? json) fromJsonMeta) {
    List<T> payloadList =
    (json['payload'] as List<dynamic>).map(fromJsonEntity).toList();
    Object? metaInput = json['meta'];
    M? payloadMeta = metaInput == null ? null : fromJsonMeta(metaInput);
    return PayloadListWithMeta(list: payloadList, meta: payloadMeta);
  }
}
