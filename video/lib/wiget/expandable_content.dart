import 'package:flutter/material.dart';
import 'package:video/model/videoModel.dart';
import 'package:video/util/view_util.dart';

class ExpandableContent extends StatefulWidget {
  final VideoModel? mo;
  ExpandableContent({Key? key, this.mo}) : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  Animatable _easeInTween = CurveTween(curve: Curves.linear);
  late AnimationController _controller;
  late Animation _heightFactor;
  bool _expand = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _heightFactor = _controller.drive(_easeInTween);
    _controller.addListener(() {
      print(_heightFactor.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          _buildTitle(),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _buildDes()
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Text(
                widget.mo?.title ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              color: Colors.transparent,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          )
        ],
      ),
    );
  }

  _toggleExpand() {
    setState(() {
      _expand = !_expand;
      if (_expand) {
        _controller.forward();
      } else {
        _controller.reverse(); //方向执行动画
      }
    });
  }

  _buildInfo() {
    var dateStr = widget.mo?.createTime ?? '';
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    return Row(
      children: [
        ...smallIconText(Icons.video_call, widget.mo?.view ?? 0),
        Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.mo?.reply ?? 0),
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          dateStr,
          style: style,
        ),
      ],
    );
  }

  _buildDes() {
    var child = _expand
        ? Text(
            widget.mo?.desc ?? "--",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Align(
          heightFactor: _heightFactor.value,
          // 从布局之上的位置开始展开，而不是从中间展开
          alignment: Alignment.topCenter,
          child: Container(
            // 会撑满宽度，然后内容对齐
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 8),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
