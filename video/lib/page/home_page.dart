import 'package:flutter/material.dart';
import 'package:video/core/hi_state.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/dao/home_dao.dart';
import 'package:video/model/bannerModel.dart';
import 'package:video/model/categoryModel.dart';
import 'package:video/model/homeModel.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/home_tab_page.dart';
import 'package:video/page/my_page.dart';
import 'package:video/page/video_detail_page.dart';
import 'package:video/util/toast.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_tab.dart';
import 'package:video/wiget/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJmupTo;
  HomePage({Key? key, this.onJmupTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  RouteChangeListener? listener;
  List<CategoryModel> categoryList = [];
  List<BannerModel> bannerList = [];
  late TabController _controller;
  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    //如果不加AutomaticKeepAliveClientMixin，页面会重新创建
    HiNavigator.getInstance().addListener(
      this.listener = (current, pre) => {
            if (widget == current.page || current.page is HomePage)
              {printLog("打开了首页:onResume")}
            else if (widget == pre?.page || pre?.page is HomePage)
              {printLog("首页:onPause")},
            //当前页面返回到首页时，恢复首页的状态栏样式
            if (pre?.page is VideoDetailPage && !(current.page is MyPage))
              {
                changeStatusBar(
                    color: Colors.white, statusStyle: StatusStyle.Dark)
              }
          },
    );
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    HiNavigator.getInstance().removeListener(this.listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("AppLifecycleState:${state}");
    switch (state) {
      case AppLifecycleState.resumed: //后台切换到前台
        //修复安卓后台切换到前台，状态栏变白色的问题
        if (!(_currentPage is VideoDetailPage)) {
          changeStatusBar(color: Colors.white, statusStyle: StatusStyle.Dark);
        }
        break;
      case AppLifecycleState.inactive: //处于这种状态的应用应该假设他们可能在任何时候会暂停
        break;
      case AppLifecycleState.paused: //界面不可见，后台
        break;
      case AppLifecycleState.detached: //关闭
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          NavigationBar(
            height: 60,
            child: _appbar(),
            color: Colors.white,
            statusStyle: StatusStyle.Dark,
          ),
          Container(
            color: Colors.white,
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
    return HiTab(
      categoryList.map((e) {
        return Tab(
          text: e.name,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black,
      insets: 13,
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

  _appbar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [_avatar(), _searchInput(), ..._buttonItems()],
        ),
      ),
    );
  }

  _avatar() {
    return GestureDetector(
      onTap: () {
        if (widget.onJmupTo != null) {
          widget.onJmupTo!(3);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Image.asset(
          "images/avatar.png",
          height: 46,
          width: 46,
        ),
      ),
    );
  }

  _searchInput() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            height: 32,
            decoration: BoxDecoration(color: Colors.grey[100]),
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  _buttonItems() {
    return [
      Icon(
        Icons.access_alarm,
        color: Colors.grey,
      ),
      Padding(padding: EdgeInsets.only(left: 10)),
      Icon(
        Icons.mail,
        color: Colors.grey,
      ),
    ];
  }
}
