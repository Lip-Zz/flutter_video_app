import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video/navigator/hi_navigator.dart';
import 'package:video/provider/theme_provider.dart';

class ThemeItem extends StatelessWidget {
  const ThemeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon = themeProvider.isDark()
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    return GestureDetector(
      onTap: () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.theme);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 10, bottom: 15),
        child: Row(
          children: [
            Text(
              "夜间模式",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 1),
              child: Icon(icon),
            )
          ],
        ),
      ),
    );
  }
}
