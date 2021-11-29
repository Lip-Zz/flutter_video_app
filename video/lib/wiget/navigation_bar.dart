import 'package:flutter/material.dart';
import 'package:video/provider/theme_provider.dart';
import 'package:video/util/view_util.dart';
import 'package:provider/provider.dart';

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
  late StatusStyle _statusStyle;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _statusStyle = widget.statusStyle;
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    _color = themeProvider.isDark() ? ThemeColor.dark_bg : widget.color;
    _statusStyle =
        themeProvider.isDark() ? StatusStyle.Light : widget.statusStyle;
    _statusBarInit();
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusBarInit() {
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
