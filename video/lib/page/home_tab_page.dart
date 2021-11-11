import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video/core/hi_state.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/util/toast.dart';
import 'package:video/wiget/hi_banner.dart';
import 'package:video/wiget/video_card.dart';

class HomeTabPage extends StatefulWidget {
  final String? name;
  List<BannerModel>? bannerList;
  HomeTabPage({Key? key, this.name, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends HiState<HomeTabPage> {
  List<VideoModel> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: videoList.length,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          itemBuilder: (context, index) {
            if (index == 0 && widget.bannerList != null) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: _banner(),
              );
            } else {
              return VideoCard(
                videoModel: videoList[index],
              );
            }
          },
          staggeredTileBuilder: (index) {
            if (index == 0 && widget.bannerList != null) {
              return StaggeredTile.fit(2);
            } else {
              return StaggeredTile.fit(1);
            }
          }),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0),
      child: HiBanner(
        bannerList: widget.bannerList ?? [],
        bannerHeight: 200,
      ),
    );
  }

  _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeModel result = await HomeDao.get(widget.name ?? "",
          pageIndex: currentIndex, pageSize: 10);
      setState(() {
        if (loadMore) {
          if (result.videoList?.isNotEmpty == true &&
              result.videoList != null) {
            videoList = [...videoList, ...result.videoList!];
            pageIndex++;
          }
        } else {
          videoList = result.videoList ?? [];
        }
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNETError catch (e) {
      showWarnToast(e.message);
    }
  }
}
