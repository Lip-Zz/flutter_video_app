import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_base/util/view_util.dart';
import 'package:orientation/orientation.dart';
import 'package:hi_base/util/color.dart';
import 'package:video/wiget/hi_video_control.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;
  final Widget? barrageUI;
  VideoView(
    this.url, {
    Key? key,
    this.cover: '',
    this.autoPlay: false,
    this.looping: false,
    this.aspectRatio: 16 / 9,
    this.overlayUI,
    this.barrageUI,
  }) : super(key: key);
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
      customControls: MaterialControls(
        barrageUI: widget.barrageUI,
      ),
      placeholder: _videoPlaceholder,
      materialProgressColors: _videoProgressColors,
      cupertinoProgressColors: _videoProgressColors,
      // overlay: widget.overlayUI,
    );
    _chewieController.addListener(_fullscreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullscreenListener);
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

  _fullscreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
