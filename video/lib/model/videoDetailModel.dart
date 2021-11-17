import 'package:json_annotation/json_annotation.dart';
import 'package:video/model/videoModel.dart';

part 'videoDetailModel.g.dart';

@JsonSerializable()
class VideoDetailModel {
  bool isFavorite;
  bool isLike;
  VideoModel? videoInfo;
  List<VideoModel>? videoList;
  VideoDetailModel({
    this.isFavorite: false,
    this.isLike: false,
    this.videoInfo,
    this.videoList,
  });

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) =>
      _$VideoDetailModelFromJson(json);

  Map toJson() => _$VideoDetailModelToJson(this);
}
