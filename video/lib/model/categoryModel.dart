import 'package:json_annotation/json_annotation.dart';
part 'categoryModel.g.dart';

@JsonSerializable()
class CategoryModel {
  String name;
  CategoryModel({this.name = ''});
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
