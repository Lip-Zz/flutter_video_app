import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video/core/hi_base_tab_state.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/wiget/hi_banner.dart';
import 'package:video/wiget/video_card.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  final List<BannerModel>? bannerList;
  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends HiBaseTabState<HomeModel, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print("${widget.name}");
    print("${widget.bannerList}");
  }

  _banner() {
    return HiBanner(
      bannerList: widget.bannerList ?? [],
      bannerHeight: 200,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  @override
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      crossAxisCount: 2,
      itemCount: dataList.length,
      // crossAxisSpacing: 10,
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      itemBuilder: (context, index) {
        if (index == 0 && widget.bannerList != null) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _banner(),
          );
        } else {
          return VideoCard(
            videoModel: dataList[index],
          );
        }
      },
      staggeredTileBuilder: (index) {
        if (index == 0 && widget.bannerList != null) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.fit(1);
        }
      });

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result = await HomeDao.get(widget.name ?? "",
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(result) {
    return result.videoList ?? [];
  }
}
