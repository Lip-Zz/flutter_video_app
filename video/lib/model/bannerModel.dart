import 'package:json_annotation/json_annotation.dart';

part 'bannerModel.g.dart';

@JsonSerializable()
class BannerModel {
  String name;
  BannerModel({this.name = ''});
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
