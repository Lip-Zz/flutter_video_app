import 'package:flutter/material.dart';
import 'package:video/model/video.dart';

class VideoDetailPage extends StatefulWidget {
  final Video video;
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
      body: Container(
        child: Text("视频详情页,vid:${widget.video.vid}"),
      ),
    );
  }
}
