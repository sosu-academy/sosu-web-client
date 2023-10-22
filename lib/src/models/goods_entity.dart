import 'package:json_annotation/json_annotation.dart';
import 'package:sosu_web/src/models/base_response_v2.dart';

part 'goods_entity.g.dart';

/// Description :
///
/// Created by juhongmin on 2023/04/19

@JsonSerializable()
class GoodsEntity {
  @JsonKey(name: "id")
  int uid;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "imagePath")
  String imageUrl;

  GoodsEntity(
      {required this.uid,
      required this.title,
      required this.message,
      required this.imageUrl});

  factory GoodsEntity.fromJson(Map<String, dynamic> json) {
    return _$GoodsEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GoodsEntityToJson(this);
}

@JsonSerializable()
class GoodsEntityV2 extends BaseJson<GoodsEntityV2> {
  @JsonKey(name: "id")
  int uid;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "imagePath")
  String imageUrl;

  GoodsEntityV2(
      {required this.uid,
      required this.title,
      required this.message,
      required this.imageUrl});

  @override
  GoodsEntityV2 fromJson(Map<String, dynamic> json) {
    return _$GoodsEntityV2FromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$GoodsEntityV2ToJson(this);
  }
}
