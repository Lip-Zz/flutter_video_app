import 'package:flutter/material.dart';
import 'package:video/core/hi_base_tab_state.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/wiget/video_large_card.dart';

class RankTabPage extends StatefulWidget {
  final String? name;
  RankTabPage({Key? key, this.name}) : super(key: key);

  @override
  _RankTabPageState createState() => _RankTabPageState();
}

class _RankTabPageState
    extends HiBaseTabState<HomeModel, VideoModel, RankTabPage> {
  @override
  get contentChild => Container(
        child: ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(top: 10),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return VideoLargeCard(
                mo: dataList[index],
              );
            }),
      );

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result = await HomeDao.get(widget.name ?? "",
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeModel result) {
    return result.videoList ?? [];
  }
}
