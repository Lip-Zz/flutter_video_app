import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:video/util/view_util.dart';

enum StatusStyle { Light, Dark }

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  NavigationBar(
      {Key? key,
      this.statusStyle: StatusStyle.Dark,
      this.color: Colors.white,
      this.height: 46,
      this.child})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  void initState() {
    super.initState();
    _statusBarInit();
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }

  void _statusBarInit() {
    changeStatusBar(color: widget.color);
  }
}
