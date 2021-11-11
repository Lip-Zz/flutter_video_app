// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      name: json['name'] as String? ?? '',
      id: json['id'] as String? ?? '',
      url: json['url'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      view: json['view'] as int? ?? 0,
      seconds: json['seconds'] as int? ?? 0,
    )..owner = json['owner'] == null
        ? null
        : OwnerModel.fromJson(json['owner'] as Map<String, dynamic>);

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'cover': instance.cover,
      'view': instance.view,
      'seconds': instance.seconds,
      'owner': instance.owner,
    };
