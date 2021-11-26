import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/page/my_page.dart';
import 'package:video/page/video_detail_page.dart';
import 'package:video/provider/theme_provider.dart';
import 'package:video/wiget/navigation_bar.dart';
import 'package:provider/provider.dart';

/// 改变状态栏颜色
void changeStatusBar(
    {color: Colors.white,
    StatusStyle statusStyle: StatusStyle.Light,
    BuildContext? context}) {
  if (context != null) {
    var themeProvider = context.read<ThemeProvider>();
    if (themeProvider.isDark()) {
      statusStyle = StatusStyle.Light;
      color = ThemeColor.dark_bg;
    }
  }

  var page = HiNavigator.getInstance().current?.page;
  // 安卓切换变白
  if (page is MyPage) {
    color = Colors.transparent;
  } else if (page is VideoDetailPage) {
    color = Colors.black;
    statusStyle = StatusStyle.Light;
  }

  FlutterStatusbarManager.setColor(color, animated: false);
  FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.Dark
      ? StatusBarStyle.DARK_CONTENT
      : StatusBarStyle.LIGHT_CONTENT);
}

BoxDecoration? bottomBoxShadow(BuildContext context) {
  var themeProvider = context.watch<ThemeProvider>();
  if (themeProvider.isDark()) {
    return null;
  }
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
      color: Colors.grey[100] ?? Colors.black26,
      offset: Offset(0, 5),
      blurRadius: 5,
      spreadRadius: 1,
    ),
  ]);
}
