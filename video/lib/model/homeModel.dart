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
  HomeModel({this.bannerList,this.categoryList,this.videoList});

  factory HomeModel.fromJson(Map<String,dynamic> json)=>_$HomeModelFromJson(json);
  Map<String,dynamic> toJson()=>_$HomeModelToJson(this);
}