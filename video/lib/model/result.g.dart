// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['code'] as int,
      json['method'] as String,
      json['requestParams'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'method': instance.method,
      'requestParams': instance.requestParams,
    };
