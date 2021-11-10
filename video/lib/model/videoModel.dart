import 'package:json_annotation/json_annotation.dart';

part 'videoModel.g.dart';

@JsonSerializable()
class VideoModel {
  String id;
  String url;
  String name;
  VideoModel({this.name = '', this.id: '', this.url: ''});
  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
