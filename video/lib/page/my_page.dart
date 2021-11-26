import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/util/format_util.dart';
import 'package:video/util/hi_blur.dart';
import 'package:video/util/toast.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/course_card.dart';
import 'package:video/wiget/good_card.dart';
import 'package:video/wiget/hi_banner.dart';
import 'package:video/wiget/hi_flexble_header.dart';
import 'package:video/wiget/theme_item.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  HomeModel? mo;
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (context, b) {
          return [_appbar()];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [...content()],
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      HomeModel result = await HomeDao.get("推荐");
      print(result);

      this.setState(() {
        mo = result;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNETError catch (e) {
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;

  _info() {
    return HiFlexbleHeader(
      name: mo?.name,
      face: mo?.face,
      controller: _controller,
    );
  }

  _bg() {
    return Stack(
      children: [
        Positioned.fill(child: cacheNetworkImage(mo?.face ?? '')),
        Positioned.fill(
          child: HiBlur(
            sigma: 20,
          ),
        ),
        Positioned(
          child: _profile(),
          left: 0,
          right: 0,
          bottom: 0,
        )
      ],
    );
  }

  _appbar() {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _info(),
        background: _bg(),
      ),
    );
  }

  content() {
    //不写保护的话，banner会疯狂滚动，然后恢复正常
    if (mo == null) {
      return [];
    }
    return [
      _banner(),
      CourseCard(
        courseList: mo?.bannerList ?? [],
      ),
      GoodCard(courseList: mo?.bannerList ?? []),
      ThemeItem()
    ];
  }

  _profile() {
    if (mo == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoText('收藏', mo?.favorite ?? 0),
          _infoText('点赞', mo?.like ?? 0),
          _infoText('浏览', mo?.browsing ?? 0),
          _infoText('金币', mo?.coin ?? 0),
          _infoText('粉丝数', mo?.fans ?? 0),
        ],
      ),
    );
  }

  _banner() {
    return HiBanner(
      bannerList: mo?.bannerList ?? [],
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }

  _infoText(String s, int i) {
    return Column(
      children: [
        Text(
          s,
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
        Text(
          countFormat(i),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        )
      ],
    );
  }
}
