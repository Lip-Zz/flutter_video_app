import 'package:flutter/material.dart';
import 'package:video/page/home_page.dart';
import 'package:video/page/login_page.dart';
import 'package:video/page/register_page.dart';
import 'package:video/page/video_detail_page.dart';

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

/// 自定义路由状态，路由状态
enum RouteStatus { login, register, home, detail, unkown }

/// 获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegisterPage) {
    return RouteStatus.register;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }

  return RouteStatus.unkown;
}

/// 路由信息
class RouteStatusInfo {
  RouteStatus routeStatus;
  Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

/// 获取RouteStatus在页面堆栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (var i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}


// parser是web用来做路由的，不需要可以去掉，parser和provider是成对出现的
// class BRouterParser extends RouteInformationParser<BRoutePath> {
//   @override
//   Future<BRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location ?? '');
//     print("跳转地址:$uri");
//     if (uri.pathSegments.length == 0) {
//       return BRoutePath.home();
//     } else {
//       return BRoutePath.detail();
//     }
//   }
// }


// /// PopNavigatorRouterDelegateMixin里面实现了popRoute，可以不用重写实现RouterDelegate里面的popRoute
// /// ChangeNotifier里面实现了addListener,removeListener，可以不用重写实现RouterDelegate里面的addListener,removeListener
// class BRouteDelegate extends RouterDelegate<BRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin {
//   final GlobalKey<NavigatorState> navigationKey;
//   // 为navigator设置一个key，必要的时候可以通过navigationKey.currentState来获取NavigatorState对象，pop,canPop,push等
//   BRouteDelegate() : navigationKey = GlobalKey<NavigatorState>();

//   BRoutePath? path;

//   List<MaterialPage> pages = [];

//   Video? video;

//   @override
//   Widget build(BuildContext context) {
//     //路由堆栈
//     pages = [
//       pageWrap(HomePage(
//         onJumpDetail: (video) {
//           this.video = video;
//           this.notifyListeners();
//         },
//       )),
//       if (video != null) pageWrap(VideoDetailPage(video!)),
//     ];

//     return Navigator(
//       key: navigationKey,
//       pages: pages,
//       onPopPage: (route, result) {
//         //控制是否能返回
//         if (!route.didPop(result)) {
//           return false;
//         }
//         return true;
//       },
//     );
//   }

//   @override
//   Future<void> setNewRoutePath(BRoutePath configuration) async {
//     this.path = configuration;
//   }

//   @override
//   GlobalKey<NavigatorState>? get navigatorKey => navigationKey;
// }
