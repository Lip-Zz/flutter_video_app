import 'package:flutter/material.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/wiget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel video;
  VideoDetailPage(
    this.video, {
    Key? key,
  }) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Text("视频详情页,url:${widget.video.url}"),
          ),
          _video()
        ],
      ),
    );
  }

  _video() {
    return VideoView(
      widget.video.url,
      cover: widget.video.cover,
      autoPlay: true,
      looping: true,
    );
  }
}
