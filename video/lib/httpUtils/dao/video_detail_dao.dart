import 'package:hi_net/hi_net.dart';
import 'package:video/httpUtils/request/video_detail_request.dart';
import 'package:video/model/videoDetailModel.dart';

class VideoDetailDao {
  static get(String vid) async {
    var request = VideoDetailRequest()..add("vid", vid);
    var result = await HiNET.getInstance().fire(request);
    return VideoDetailModel.fromJson(result["data"]);
  }
}
