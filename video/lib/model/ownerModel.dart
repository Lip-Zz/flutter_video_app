import 'package:json_annotation/json_annotation.dart';

part 'ownerModel.g.dart';

@JsonSerializable()
class OwnerModel {
  String face;
  String name;
  int fans;
  OwnerModel({this.face: "", this.name: "", this.fans: 0});
  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}
