import 'package:flutter/material.dart';

class HiBarrageItem extends StatelessWidget {
  final String vid;
  final double top;
  final Widget? child;
  final ValueChanged<String>? onComplete;
  final Duration duration;
  const HiBarrageItem(
    this.vid, {
    Key? key,
    this.top: 0,
    this.child,
    this.onComplete,
    this.duration: const Duration(seconds: 9),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: top),
      child: child,
    );
  }
}
