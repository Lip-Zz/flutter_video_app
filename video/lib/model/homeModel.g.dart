// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      bannerList: (json['bannerList'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryList: (json['categoryList'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoList: (json['videoList'] as List<dynamic>?)
          ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String? ?? '',
      face: json['face'] as String? ?? '',
      fans: json['fans'] as int? ?? 0,
      favorite: json['favorite'] as int? ?? 0,
      like: json['like'] as int? ?? 0,
      coin: json['coin'] as int? ?? 0,
      browsing: json['browsing'] as int? ?? 0,
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'categoryList': instance.categoryList,
      'videoList': instance.videoList,
      'name': instance.name,
      'face': instance.face,
      'fans': instance.fans,
      'favorite': instance.favorite,
      'like': instance.like,
      'coin': instance.coin,
      'browsing': instance.browsing,
    };
