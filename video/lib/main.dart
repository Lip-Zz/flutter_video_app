import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video/db/hi_cache.dart';
import 'package:video/httpUtils/core/hi_error.dart';
import 'package:video/httpUtils/core/hi_net.dart';
import 'package:video/httpUtils/dao/login_dao.dart';
import 'package:video/httpUtils/request/notice_request.dart';
import 'package:video/model/owner.dart';
import 'package:video/httpUtils/request/test_request.dart';
import 'package:video/model/video.dart';
import 'package:video/page/home_page.dart';
import 'package:video/page/login_page.dart';
import 'package:video/page/register_page.dart';
import 'package:video/page/video_detail_page.dart';
import 'package:video/util/color.dart';

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
  BRouterParser _routeParser = BRouterParser();

  @override
  Widget build(BuildContext context) {
    var routes = Router(
      routerDelegate: _routeDelegate,
      routeInformationParser: _routeParser,
      //parser和provider是成对出现的
      routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(location: "/")),
    );
    return MaterialApp(
      home: routes,
    );
  }
}

class BRouterParser extends RouteInformationParser<BRoutePath> {
  @override
  Future<BRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    print("跳转地址:$uri");
    if (uri.pathSegments.length == 0) {
      return BRoutePath.home();
    } else {
      return BRoutePath.detail();
    }
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
  BRouteDelegate() : navigationKey = GlobalKey<NavigatorState>();

  BRoutePath? path;

  List<MaterialPage> pages = [];

  Video? video;

  @override
  Widget build(BuildContext context) {
    //路由堆栈
    pages = [
      pageWrap(HomePage(
        onJumpDetail: (video) {
          this.video = video;
          this.notifyListeners();
        },
      )),
      if (video != null) pageWrap(VideoDetailPage(video!)),
    ];

    return Navigator(
      key: navigationKey,
      pages: pages,
      onPopPage: (route, result) {
        //控制是否能返回
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BRoutePath configuration) async {
    this.path = configuration;
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigationKey;
}

pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}
