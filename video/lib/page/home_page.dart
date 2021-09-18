import 'package:flutter/material.dart';
import 'package:video/model/video.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/home_tab_page.dart';
import 'package:video/util/color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RouteChangeListener? listener;
  List<String> tabs = [
    "推荐",
    "热门",
    "追播",
    "影视",
    "搞笑",
    "日常",
    "综合",
    "手机游戏",
    "短片·手书·配音"
  ];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    //如果不加AutomaticKeepAliveClientMixin，页面会重新创建
    HiNavigator.getInstance().addListener(this.listener = (current, pre) => {
          if (widget == current.page || current.page is HomePage)
            {printLog("打开了首页:onResume")}
          else if (widget == pre?.page || pre?.page is HomePage)
            {printLog("首页:onPause")}
        });
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(this.listener);
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
                  children: tabs.map<HomeTabPage>((tab) {
                    return HomeTabPage(
                      name: tab,
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
      tabs: tabs.map<Tab>((tab) {
        return Tab(
            child: Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Text(tab),
        ));
      }).toList(),
    );
  }
}
