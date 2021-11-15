import 'package:flutter/material.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/appbar.dart';
import 'package:video/wiget/hi_tab.dart';
import 'package:video/wiget/navigation_bar.dart';
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

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _contorller;
  List<String> tabs = ["简介", "评论"];

  @override
  void initState() {
    super.initState();
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.Dark);
    _contorller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _contorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.name),
      ),
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Column(
            children: [
              _video(),
              _tabNav(),
              _tabView(),
            ],
          )),
    );
  }

  _video() {
    return VideoView(
      widget.video.url,
      cover: widget.video.cover,
      autoPlay: true,
      looping: true,
      overlayUI: videoAppbar(),
    );
  }

  _tabNav() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabbar(),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                Icons.live_tv_outlined,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabbar() {
    return HiTab(
      tabs.map((e) {
        return Tab(
          text: e,
        );
      }).toList(),
      controller: _contorller,
    );
  }

  _tabView() {
    return Container();
  }
}
