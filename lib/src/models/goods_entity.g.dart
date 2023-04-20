// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsEntity _$GoodsEntityFromJson(Map<String, dynamic> json) => GoodsEntity(
      uid: json['id'] as int,
      title: json['title'] as String,
      message: json['message'] as String,
      imagePath: json['imagePath'] as String,
    );

Map<String, dynamic> _$GoodsEntityToJson(GoodsEntity instance) =>
    <String, dynamic>{
      'id': instance.uid,
      'title': instance.title,
      'message': instance.message,
      'imagePath': instance.imagePath,
    };
