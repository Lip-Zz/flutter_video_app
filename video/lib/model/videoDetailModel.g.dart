// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videoDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDetailModel _$VideoDetailModelFromJson(Map<String, dynamic> json) =>
    VideoDetailModel(
      isFavorite: json['isFavorite'] as bool? ?? false,
      isLike: json['isLike'] as bool? ?? false,
      videoInfo: json['videoInfo'] == null
          ? null
          : VideoModel.fromJson(json['videoInfo'] as Map<String, dynamic>),
      videoList: (json['videoList'] as List<dynamic>?)
          ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoDetailModelToJson(VideoDetailModel instance) =>
    <String, dynamic>{
      'isFavorite': instance.isFavorite,
      'isLike': instance.isLike,
      'videoInfo': instance.videoInfo,
      'videoList': instance.videoList,
    };
