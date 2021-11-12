import 'package:flutter/material.dart';
import 'package:video/db/hi_cache.dart';
import 'package:video/httpUtils/dao/login_dao.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/navigator/bottom_navigator.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/login_page.dart';
import 'package:video/page/register_page.dart';
import 'package:video/page/video_detail_page.dart';
import 'package:video/util/color.dart';
import 'package:video/util/string_util.dart';
import 'package:video/util/toast.dart';

void main() {
  runApp(BApp());
}

class BApp extends StatefulWidget {
  BApp({Key? key}) : super(key: key);

  @override
  _BAppState createState() => _BAppState();
}

class _BAppState extends State<BApp> {
  BRouteDelegate _routeDelegate = BRouteDelegate();
  // BRouterParser _routeParser = BRouterParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      // 项目初始化
      future: HiCache.preInit(),
      builder: (context, snapshot) {
        var routes = snapshot.connectionState == ConnectionState.done
            ? Router(
                routerDelegate: _routeDelegate,
                // parser是web用来做路由的，不需要可以去掉
                // routeInformationParser: _routeParser,
                //parser和provider是成对出现的
                // routeInformationProvider: PlatformRouteInformationProvider(
                // initialRouteInformation: RouteInformation(location: "/")),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

        return MaterialApp(
          home: routes,
          theme: ThemeData(primarySwatch: white),
        );
      },
    );
  }
}

class BRoutePath {
  final String location;

  BRoutePath.home() : location = "/";
  BRoutePath.detail() : location = '/detail';
}

/// PopNavigatorRouterDelegateMixin里面实现了popRoute，可以不用重写实现RouterDelegate里面的popRoute
/// ChangeNotifier里面实现了addListener,removeListener，可以不用重写实现RouterDelegate里面的addListener,removeListener
class BRouteDelegate extends RouterDelegate<BRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigationKey;
  // 为navigator设置一个key，必要的时候可以通过navigationKey.currentState来获取NavigatorState对象，pop,canPop,push等
  BRouteDelegate() : navigationKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      if (routeStatus == RouteStatus.detail) {
        this.video = args?["video"];
      }
      this.notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home;
  //路由拦截
  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.register && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (video != null) {
      return _routeStatus = RouteStatus.detail;
    }

    return _routeStatus;
  }

  List<MaterialPage> pages = [];
  VideoModel? video;

  bool get hasLogin => isNotEmpty(LoginDao.getAccessToken());

  @override
  Widget build(BuildContext context) {
    //管理路由堆栈
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面出栈，
      //这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }

    var page;
    switch (routeStatus) {
      case RouteStatus.home: //跳转到首页是将堆栈中的其他页面全部出栈，因为首页不可回退
        pages.clear();
        page = pageWrap(BottomNavigator());
        break;
      case RouteStatus.detail:
        page = pageWrap(VideoDetailPage(video!));
        break;
      case RouteStatus.register:
        page = pageWrap(RegisterPage());
        break;
      case RouteStatus.login:
        page = pageWrap(LoginPage(
          onJumpToRegister: () {
            _routeStatus = RouteStatus.register;
            this.notifyListeners();
          },
          onLoginSuccess: () {
            _routeStatus = RouteStatus.home;
            this.notifyListeners();
          },
        ));
        break;
      default:
        break;
    }

    tempPages = [...tempPages, page];

    //通知路由变化
    HiNavigator.getInstance().notify(tempPages, pages);

    //路由堆栈
    pages = tempPages;

    return WillPopScope(
      //安卓物理返回键WillPopScope,修复无法返回上一页而是直接回到桌面的问题
      onWillPop: () async =>
          !(await navigationKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigationKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录拦截返回事件
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarnToast("请先登录");
                return false;
              }
            }
          }
          //控制是否能返回
          if (!route.didPop(result)) {
            return false;
          }

          var tempPages = [...pages];

          pages.removeLast();
          //通知路由变化
          HiNavigator.getInstance().notify(pages, tempPages);

          return true;
        },
      ),
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigationKey;

  @override
  Future<void> setNewRoutePath(BRoutePath configuration) async {}
}
