import 'package:flutter/material.dart';
import 'package:video/util/color.dart';

class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const HiTab(
    this.tabs, {
    Key? key,
    this.controller,
    this.fontSize: 15,
    this.borderWidth: 2,
    this.insets: 10,
    this.unselectedLabelColor: Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelColor: primary,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: TextStyle(fontSize: fontSize),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: borderWidth, color: primary),
        insets: EdgeInsets.only(left: insets, right: insets),
      ),
      tabs: tabs,
    );
  }
}
