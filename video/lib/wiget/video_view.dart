import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:video/util/color.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_video_control.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  VideoView(this.url,
      {Key? key,
      this.cover: '',
      this.autoPlay: false,
      this.looping: false,
      this.aspectRatio: 16 / 9})
      : super(key: key);
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  get _videoPlaceholder => FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: cacheNetworkImage(widget.cover),
      );
  get _videoProgressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white,
      );

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      allowPlaybackSpeedChanging: false,
      showControlsOnInitialize: true,
      customControls: MaterialControls(),
      placeholder: _videoPlaceholder,
      materialProgressColors: _videoProgressColors,
      cupertinoProgressColors: _videoProgressColors,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = width / widget.aspectRatio;
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      child: Chewie(controller: _chewieController),
    );
  }
}
