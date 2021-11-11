import 'package:json_annotation/json_annotation.dart';
import 'package:video/model/ownerModel.dart';

part 'videoModel.g.dart';

@JsonSerializable()
class VideoModel {
  String id;
  String url;
  String name;
  String cover;
  int view;
  int seconds;
  OwnerModel? owner;
  VideoModel({
    this.name = '',
    this.id: '',
    this.url: '',
    this.cover: '',
    this.view: 0,
    this.seconds: 0,
  });
  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
