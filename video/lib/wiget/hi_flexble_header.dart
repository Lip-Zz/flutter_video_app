import 'package:flutter/material.dart';
import 'package:video/provider/theme_provider.dart';
import 'package:video/util/view_util.dart';
import 'package:provider/provider.dart';

class HiFlexbleHeader extends StatefulWidget {
  final String? name;
  final String? face;
  final ScrollController? controller;
  HiFlexbleHeader({Key? key, this.name, this.face, this.controller})
      : super(key: key);

  @override
  _HiFlexbleHeaderState createState() => _HiFlexbleHeaderState();
}

class _HiFlexbleHeaderState extends State<HiFlexbleHeader> {
  static const double MAX_BOTTOM_PADDING = 40;
  static const double MIN_BOTTOM_PADDING = 10;
  static const double MAX_OFFSET = 80; //滚动距离

  //动态变化的底部间距
  double _dyBottomPadding = MAX_BOTTOM_PADDING;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      var offset = widget.controller?.offset ?? 0;
      //计算滚动距离的占比
      var dyOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      //计算出具体的padding值
      var dy = dyOffset * (MAX_BOTTOM_PADDING - MIN_BOTTOM_PADDING);
      if (dy > (MAX_BOTTOM_PADDING - MIN_BOTTOM_PADDING)) {
        dy = MAX_BOTTOM_PADDING - MIN_BOTTOM_PADDING;
      } else if (dy < 0) {
        dy = 0;
      }

      setState(() {
        _dyBottomPadding = MIN_BOTTOM_PADDING + dy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    Color textColor = themeProvider.isDark() ? Colors.white70 : Colors.black87;
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _dyBottomPadding, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cacheNetworkImage(widget.face ?? '', width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name ?? '',
            style: TextStyle(fontSize: 11, color: textColor),
          )
        ],
      ),
    );
  }
}
