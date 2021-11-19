import 'package:flutter/material.dart';
import 'package:video/core/hi_base_tab_state.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/util/color.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_banner.dart';

class NoticePage extends StatefulWidget {
  NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState
    extends HiBaseTabState<HomeModel, BannerModel, NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _nav(),
          Expanded(child: super.build(context)),
        ],
      ),
    );
  }

  @override
  get contentChild => Container(
        child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return _buildItem(index);
            }),
      );

  @override
  Future<HomeModel> getData(int pageIndex) async {
    HomeModel result =
        await HomeDao.get("", pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<BannerModel> parseList(HomeModel result) {
    return result.bannerList ?? [];
  }

  _nav() {
    return AppBar(
      title: Text('通知'),
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        handleItemClick(dataList[index]);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              Icons.wallet_giftcard,
              color: primary,
              size: 35,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: borderLine(context)),
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataList[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    hiSpace(height: 10),
                    Text(
                      dataList[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              dataList[index].type,
            )
          ],
        ),
      ),
    );
  }
}
