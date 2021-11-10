import 'package:json_annotation/json_annotation.dart';

part 'bannerModel.g.dart';

@JsonSerializable()
class BannerModel {
  String name;
  String title;
  String cover;
  String url;
  String type;
  BannerModel(
      {this.name = '',
      this.title = "",
      this.cover = "",
      this.url = '',
      this.type = ''});
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
