// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? "",
      cover: json['cover'] as String? ?? "",
      url: json['url'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'cover': instance.cover,
      'url': instance.url,
      'type': instance.type,
    };
