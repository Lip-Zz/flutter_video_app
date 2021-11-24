import 'package:flutter/material.dart';
import 'package:video/core/hi_base_tab_state.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/video_detail_page.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/navigation_bar.dart';
import 'package:video/wiget/video_large_card.dart';

class FavoriatePage extends StatefulWidget {
  FavoriatePage({Key? key}) : super(key: key);

  @override
  _FavoriatePageState createState() => _FavoriatePageState();
}

class _FavoriatePageState
    extends HiBaseTabState<HomeModel, VideoModel, FavoriatePage> {
  late RouteChangeListener _listener;
  @override
  void initState() {
    super.initState();
    HiNavigator.getInstance().addListener(this._listener = (current, pre) {
      if (current.page is FavoriatePage && pre?.page is VideoDetailPage) {
        print("收藏刷新数据");
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_nav(), Expanded(child: super.build(context))],
    );
  }

  @override
  get contentChild => ListView.builder(
      //防止只有一条数据的时候不能滑动加载
      physics: AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      padding: EdgeInsets.only(top: 10),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return VideoLargeCard(
          mo: dataList[index],
        );
      });

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result =
        await HomeDao.get("", pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeModel result) {
    return result.videoList ?? [];
  }

  _nav() {
    return NavigationBar(
      child: Container(
        alignment: Alignment.center,
        decoration: bottomBoxShadow(context),
        child: Text(
          "收藏",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
