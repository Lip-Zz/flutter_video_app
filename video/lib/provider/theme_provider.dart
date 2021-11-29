import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video/db/hi_cache.dart';
import 'package:hi_base/util/color.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => ['System', 'Light', 'Dark'][index];
}

const String THEME_KEY = "THEME";

class ThemeColor {
  static const Color red = Color(0xffff4759);
  static const Color dark_red = Color(0xffe03e4e);
  static const Color dark_bg = Color(0xff18191a);
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  Brightness? _platformBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  //系统主题发生改变
  void systemThemeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

  ThemeMode getThemeMode() {
    String? _theme = HiCache.getInstance().get(THEME_KEY);
    switch (_theme) {
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      case 'Light':
        _themeMode = ThemeMode.light;
        break;
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    HiCache.getInstance().setString(THEME_KEY, themeMode.value);
    notifyListeners();
  }

  ThemeData getThemeData({bool dark: false}) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        foregroundColor: dark ? Colors.white : Colors.black,
        iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black),
      ),
      colorScheme: dark
          ? ColorScheme.dark(
              secondary: primary[50] ?? ThemeColor.red,
              primary: ThemeColor.dark_bg,
              error: ThemeColor.dark_red,
              brightness: Brightness.dark,
            )
          : ColorScheme.light(
              secondary: white,
              primary: white,
              error: ThemeColor.red,
              brightness: Brightness.light,
            ),
      //tab样式
      indicatorColor: dark ? primary[50] ?? ThemeColor.red : white,
      //页面背景色
      scaffoldBackgroundColor: dark ? ThemeColor.dark_bg : white,
    );
  }
}
