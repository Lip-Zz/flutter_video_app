import 'package:flutter/material.dart';
import 'package:video/barrage/hi_barrage.dart';
import 'package:video/barrage/hi_barrage_input.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/dao/video_detail_dao.dart';
import 'package:video/model/videoDetailModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/util/toast.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/appbar.dart';
import 'package:video/wiget/expandable_content.dart';
import 'package:video/wiget/hi_tab.dart';
import 'package:video/wiget/navigation_bar.dart';
import 'package:video/wiget/video_header.dart';
import 'package:video/wiget/video_large_card.dart';
import 'package:video/wiget/video_toolbar.dart';
import 'package:video/wiget/video_view.dart';
import 'package:flutter_overlay/flutter_overlay.dart';

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
  VideoDetailModel? detailMo;
  VideoModel? mo;
  var _barrageKey = GlobalKey<HiBarrageState>();
  bool _inoutShowing = false;

  @override
  void initState() {
    super.initState();
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.Dark);
    _contorller = TabController(length: tabs.length, vsync: this);
    mo = widget.video;
    _loadDetail();
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
        title: Text(mo?.name ?? ''),
      ),
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: mo != null
            ? Column(
                children: [
                  _video(),
                  _tabNav(),
                  _tabView(),
                ],
              )
            : Container(),
      ),
    );
  }

  _video() {
    return VideoView(
      widget.video.url,
      cover: mo?.cover ?? '',
      autoPlay: false,
      looping: false,
      overlayUI: videoAppbar(),
      barrageUI: HiBarrage(
        mo?.id ?? '-1',
        key: _barrageKey,
        autoPlay: true,
      ),
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
            _barrage(),
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
    return Flexible(
      child: TabBarView(
        children: [
          _buildDetailList(),
          Container(
            child: Text('data'),
          ),
        ],
        controller: _contorller,
      ),
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        ...buildContent(),
      ],
    );
  }

  buildContent() {
    return [
      Container(
        child: VideoHeader(
          owner: mo?.owner,
        ),
      ),
      ExpandableContent(
        mo: mo,
      ),
      VideoToolBar(
        mo: mo,
        detailMo: detailMo,
        onLike: _doLike,
        onCoin: _doCoin,
        onFavorite: _doFavorite,
        onShare: _doShare,
        onUnLike: _doUnlike,
      ),
      ..._buildVideoList(),
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailModel result = await VideoDetailDao.get(mo?.id ?? '');
      setState(() {
        this.detailMo = result;
        this.mo = result.videoInfo;
      });
    } on HiNETError catch (e) {
      showWarnToast(e.toString());
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  void _doLike() async {
    try {
      bool isLike = !(detailMo?.isLike ?? false);
      // ignore: unused_local_variable
      VideoDetailModel result = await VideoDetailDao.get(mo?.id ?? '');
      detailMo?.isLike = isLike;
      if (isLike) {
        mo?.view += 1;
      } else {
        mo?.view -= 1;
      }
      setState(() {
        this.detailMo = this.detailMo;
        this.mo = this.mo;
      });
    } on HiNETError catch (e) {
      showWarnToast(e.toString());
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  void _doUnlike() async {
    showToast('text1111');
  }

  void _doCoin() async {
    showToast('text');
  }

  void _doFavorite() async {
    try {
      bool isFavorite = !(detailMo?.isFavorite ?? false);
      // ignore: unused_local_variable
      VideoDetailModel result = await VideoDetailDao.get(mo?.id ?? '');
      detailMo?.isFavorite = isFavorite;
      if (isFavorite) {
        mo?.reply += 1;
      } else {
        mo?.reply -= 1;
      }
      setState(() {
        this.detailMo = this.detailMo;
        this.mo = this.mo;
      });
    } on HiNETError catch (e) {
      showWarnToast(e.toString());
    } catch (e) {
      showWarnToast(e.toString());
    }
  }

  void _doShare() async {
    showToast('text');
  }

  _buildVideoList() {
    return detailMo?.videoList == null
        ? [Container()]
        : detailMo!.videoList!.map((e) {
            return VideoLargeCard(
              mo: e,
            );
          });
  }

  _barrage() {
    return GestureDetector(
      onTap: () {
        HiOverlay.show(context, child: HiBarrageInput(
          onTapClose: () {
            setState(() {
              _inoutShowing = false;
            });
          },
        )).then((value) {
          print("发送弹幕:$value");
          _barrageKey.currentState?.send(value ?? "");
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.live_tv_outlined,
          color: Colors.grey,
        ),
      ),
    );
  }
}
