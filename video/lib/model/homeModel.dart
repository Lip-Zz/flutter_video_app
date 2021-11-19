import 'package:json_annotation/json_annotation.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/categoryModel.dart';
import 'package:video/model/videoModel.dart';
part 'homeModel.g.dart';

@JsonSerializable()
class HomeModel {
  List<BannerModel>? bannerList;
  List<CategoryModel>? categoryList;
  List<VideoModel>? videoList;
  String name;
  String face;
  int fans;
  int favorite;
  int like;
  int coin;
  int browsing;
  HomeModel({
    this.bannerList,
    this.categoryList,
    this.videoList,
    this.name: '',
    this.face: '',
    this.fans: 0,
    this.favorite: 0,
    this.like: 0,
    this.coin: 0,
    this.browsing: 0,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
