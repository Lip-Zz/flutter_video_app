import 'package:flutter/material.dart';
import 'package:video/page/favorite_page.dart';
import 'package:video/page/home_page.dart';
import 'package:video/page/my_page.dart';
import 'package:video/page/rank_page.dart';
import 'package:video/util/color.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            this.setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: _activeColor,
          unselectedItemColor: _defaultColor,
          items: [
            _bottomItem("首页", Icons.home, 0),
            _bottomItem("排行", Icons.local_fire_department, 1),
            _bottomItem("收藏", Icons.favorite, 2),
            _bottomItem("我的", Icons.live_tv, 3),
          ]),
      body: PageView(
        physics: NeverScrollableScrollPhysics(), //禁止滚动
        onPageChanged: (index) {
          this.setState(() {
            _currentIndex = index;
          });
        },
        controller: _controller,
        children: [HomePage(), RankPage(), FavoriatePage(), MyPage()],
      ),
    );
  }

  _bottomItem(String s, IconData home, int i) {
    return BottomNavigationBarItem(
      icon: Icon(
        home,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        home,
        color: _activeColor,
      ),
      label: s,
    );
  }
}
