import 'package:flutter/material.dart';
import 'package:video/page/rank_tab_page.dart';
import 'package:video/util/view_util.dart';
import 'package:video/wiget/hi_tab.dart';
import 'package:video/wiget/navigation_bar.dart';

class RankPage extends StatefulWidget {
  RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with SingleTickerProviderStateMixin {
  static const tabs = [
    {'key': 'like', "name": "最热"},
    {'key': 'pubdate', "name": "最新"},
    {'key': 'favorite', "name": "收藏"}
  ];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _navbar(),
          _tabView(),
        ],
      ),
    );
  }

  _navbar() {
    return NavigationBar(
      child: Container(
        decoration: bottomBoxShadow(context),
        alignment: Alignment.center,
        child: HiTab(
          tabs.map((e) {
            return Tab(
              text: e['name'],
            );
          }).toList(),
          controller: _controller,
          fontSize: 16,
          borderWidth: 3,
          unselectedLabelColor: Colors.black54,
        ),
      ),
    );
  }

  _tabView() {
    return Flexible(
      child: TabBarView(
        children: tabs.map((e) {
          return RankTabPage(
            name: e['name'] ?? '',
          );
        }).toList(),
        controller: _controller,
      ),
    );
  }
}
