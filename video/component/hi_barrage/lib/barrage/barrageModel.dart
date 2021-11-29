import 'package:json_annotation/json_annotation.dart';
part 'barrageModel.g.dart';

@JsonSerializable()
class BarrageModel {
  // wss://api.devio.org/uapi/fa/barrage/
  String content;
  String vid;
  int priority;
  int type;
  BarrageModel(
      {this.content: '', this.vid: '', this.priority: 0, this.type: 0});
  factory BarrageModel.fromJson(Map<String, dynamic> json) =>
      _$BarrageModelFromJson(json);
  Map<String, dynamic> toJson() => _$BarrageModelToJson(this);
}
