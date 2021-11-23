// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barrageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarrageModel _$BarrageModelFromJson(Map<String, dynamic> json) => BarrageModel(
      content: json['content'] as String? ?? '',
      vid: json['vid'] as String? ?? '',
      priority: json['priority'] as int? ?? 0,
      type: json['type'] as int? ?? 0,
    );

Map<String, dynamic> _$BarrageModelToJson(BarrageModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'vid': instance.vid,
      'priority': instance.priority,
      'type': instance.type,
    };
