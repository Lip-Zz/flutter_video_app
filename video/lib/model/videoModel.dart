import 'package:json_annotation/json_annotation.dart';

part 'videoModel.g.dart';

@JsonSerializable()
class VideoModel {
  String name;
  VideoModel({this.name = ''});
  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
