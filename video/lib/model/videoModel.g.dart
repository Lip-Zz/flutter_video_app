// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
    };
