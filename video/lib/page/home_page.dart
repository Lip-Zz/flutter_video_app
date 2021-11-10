import 'package:flutter/material.dart';
import 'package:video/core/hi_state.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/categoryModel.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/model/video.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/home_tab_page.dart';
import 'package:video/util/color.dart';
import 'package:video/util/toast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RouteChangeListener? listener;
  List<CategoryModel> categoryList = [];
  List<BannerModel> bannerList = [];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    //如果不加AutomaticKeepAliveClientMixin，页面会重新创建
    HiNavigator.getInstance().addListener(this.listener = (current, pre) => {
          if (widget == current.page || current.page is HomePage)
            {printLog("打开了首页:onResume")}
          else if (widget == pre?.page || pre?.page is HomePage)
            {printLog("首页:onPause")}
        });
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20),
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: categoryList.map<HomeTabPage>((tab) {
                    return HomeTabPage(
                      name: tab.name,
                      bannerList:
                          categoryList.indexOf(tab) == 0 ? bannerList : null,
                    );
                  }).toList())),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      controller: _controller,
      isScrollable: true,
      labelColor: Colors.black,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: primary),
        insets: EdgeInsets.only(left: 10, right: 10),
      ),
      tabs: categoryList.map<Tab>((tab) {
        return Tab(
            child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(tab.name),
        ));
      }).toList(),
    );
  }

  void loadData() async {
    try {
      HomeModel result = await HomeDao.get("推荐");
      print(result);
      if (result.categoryList != null) {
        _controller = TabController(
            length: result.categoryList?.length ?? 0, vsync: this);
      }

      this.setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNETError catch (e) {
      showWarnToast(e.message);
    }
  }
}
